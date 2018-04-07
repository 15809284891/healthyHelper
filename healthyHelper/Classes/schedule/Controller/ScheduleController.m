//
//  ScheduleController.m
//  healthyHelper
//
//  Created by snow on 2017/12/29.
//  Copyright © 2017年 snow. All rights reserved.
//

#import "ScheduleController.h"
#import "WeekView.h"
#import "AddCourseController.h"
#import "PaneView.h"
#import "CourseModel.h"
#import "EditCourseController.h"
#import "GetOneDay.h"
#import "NSDate+TwoDateWeeks.h"
#import <EventKit/EventKit.h>
@interface ScheduleController ()<UITableViewDelegate,
                                UITableViewDataSource,
                                UIScrollViewDelegate>
{
    EKEventStore *eventStore;
}
@property (nonatomic ,strong)UITableView *lineTable;
@property (nonatomic,copy)NSMutableArray *coursesInfoArr;
@property (nonatomic ,copy)NSArray *timeArr;
@property (nonatomic,strong)UIScrollView *scrollerView;
@property (nonatomic,strong)UIView *weekDetailView;
@property (nonatomic,strong)WeekView *weekView;
@property (nonatomic,assign)NSInteger crtWeek;
@property (nonatomic,assign)NSInteger allWeek;
@property (nonatomic,strong)UIButton *identitierCrtWeekBt;

@end

@implementation ScheduleController
-(NSMutableArray *)coursesInfoArr{
    if (!_coursesInfoArr) {
        _coursesInfoArr = [NSMutableArray array];
    }
    return _coursesInfoArr;
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.title = @"我的课表";
        self.timeArr = @[@"8:00",@"8:50",@"10:15",@"11:05",@"14:30",@"15:20",@"4:15",@"6:16"];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    //计算两个日期之间间隔的天数
//    self.allWeek = (int)[NSDate getAllWeeks:@"2018-3-4 00:00:00" end:@"2018-7-1 00:00:00"];
//    self.crtWeek = (int)[NSDate currentWeekFromBegin:@"2018-3-4 00:00:00"];
    self.allWeek = 17;
    self.crtWeek = 13;
    [self initNavTabBarItem];
    [self setupScrollerView];
   
    [self initWeekView];
     [self setWeekData];
    [self getCoursesData];
    //事件库对象需要相对大量的时间来初始化和释放，因此，应该在应用加载时候，初始化一个事件库，然后反复的使用这一个确保连接一直可用
    eventStore = [[EKEventStore alloc]init];
    [self setupEventStore];
}
-(void)setupEventStore{
    NSDate *startDate = [NSDate dateWithTimeIntervalSinceNow:20];
    NSDate *endDate = [NSDate dateWithTimeIntervalSinceNow:300];
    [self saveEventStartDate:startDate endDate:endDate alarm:-5 eventTitle:@"提醒明天要上课" location:@"明天要上高数课" isReminder:NO];
}
- (void)saveEventStartDate:(NSDate*)startDate
                   endDate:(NSDate*)endDate
                     alarm:(float)alarm
                eventTitle:(NSString*)eventTitle
                  location:(NSString*)location
                isReminder:(BOOL)isReminder{
    //写入事件
    if ([eventStore respondsToSelector:@selector(requestAccessToEntityType:completion:)]) {
        __weak typeof (self)weakSelf = self;
        /*
         等待用户授权访问
         @param:EKEntityTypeEvent 日历
         @param:EKEntityTypeReminder 提醒事项
         */
        [eventStore requestAccessToEntityType:EKEntityTypeEvent completion:^(BOOL granted, NSError * _Nullable error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                if (error) {
                    NSLog(@"%@",error.localizedDescription);
                }else if (!granted){
                    NSLog(@"用户不允许访问");
                }else{
                    //是否写入提醒事项，提醒事项主要为 ios 原生自带的，但是模拟器没有
                    if (isReminder) {
                        EKCalendar *iDefaultCalendar = [eventStore defaultCalendarForNewReminders];
                        EKReminder *reminder = [EKReminder reminderWithEventStore:eventStore];
                        reminder.calendar = [eventStore defaultCalendarForNewReminders];
                        reminder.title = eventTitle;
                        reminder.calendar = iDefaultCalendar;
                        EKAlarm *alarm = [EKAlarm alarmWithAbsoluteDate:[NSDate dateWithTimeIntervalSinceNow:-10]];
                        [reminder addAlarm:alarm];
                        NSError *error = nil;
                        [eventStore saveReminder:reminder commit:YES error:&error];
                        if (!error) {
                            NSLog(@"%@eror = %@",error.localizedDescription);
                        }
                    }
                    else{
                        if (startDate && endDate) {
                            [weakSelf deleteInsertedEvent];
                            //根据开始时间和结束时间创建谓词
                            NSPredicate *predicate = [eventStore predicateForEventsWithStartDate:startDate endDate:endDate calendars:nil];
                            if (predicate) {
                                //根据谓词条件筛选已经插入日历的事件
                                NSArray *evenrsArray = [eventStore eventsMatchingPredicate:predicate];
                                
                                if (evenrsArray.count) {
                                    for (EKEvent *item in evenrsArray) {
                                        if ([item.title isEqualToString:eventTitle]) {
                                            return ;
                                        }
                                    }
                                }
                            }
                            
                        }
                        //创建事件
                        EKEvent *event = [EKEvent eventWithEventStore:eventStore];
                        //主标题
                        event.title = eventTitle;
                        //副标题
                        event.location = location;
                        //事件设定为全天时间
                        event.allDay = NO;
                        //设置事件开始时间
                        event.startDate = startDate;
                        //设定事件结束时间
                        event.endDate = endDate;
                        //设定 url.点击可打开的对应的 app：AAA 为某应用对外访问的入口
                        event.URL = [NSURL  URLWithString:@"AAA:AAA://https://www.baidu.com"];
                        //添加提醒，可以添加多个
                        //设定事件在开始事件多久前提醒
                        [event addAlarm:[EKAlarm alarmWithRelativeOffset:alarm]];
                        event.calendar = [eventStore defaultCalendarForNewEvents];
                        NSError *error;
                        [eventStore saveEvent:event span:EKSpanThisEvent error:&error];
                        if (!error) {
                            UIAlertController *alertVc = [UIAlertController alertControllerWithTitle:@"提示" message:@"设置提醒成功" preferredStyle:UIAlertControllerStyleAlert];
                            [alertVc addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil]];
                            [self presentViewController:alertVc animated:YES completion:nil];
                        }
                    }
                }
            });
        }];
    }
    
}
//! 删除之前插入的事件
- (void)deleteInsertedEvent{
    BOOL isClear = [[NSUserDefaults standardUserDefaults]boolForKey:@"CLEAR"];
    if (!isClear) {
        NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
        formatter.dateFormat = @"yyyyMMddHHmmss";
        NSDate *startDate = [formatter dateFromString:@"20170101000000"];
        NSDate *endDate = [formatter dateFromString:@"20171231235959"];
        NSLog(@"%@",startDate);
        NSPredicate *predicate= [eventStore predicateForEventsWithStartDate:startDate endDate:endDate calendars:nil];
        NSArray *eventsArray = [eventStore eventsMatchingPredicate:predicate];
        if (eventsArray.count)
        {
            for (EKEvent *item in eventsArray)
            {
                NSRange range = [item.title rangeOfString:@"即将到期"];
                if(range.location != NSNotFound)
                {
                    //删除老版本插入的提醒
                    [eventStore removeEvent:item span:EKSpanThisEvent commit:YES error:nil];
                }
            }
            [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"CLEAR"];
        }
    }
}
-(void)setupScrollerView{
    _scrollerView = [[UIScrollView alloc]init];
    _scrollerView.backgroundColor = weekColor;
    _scrollerView.showsHorizontalScrollIndicator = NO;
    _scrollerView.delegate = self;
    [self.view addSubview:_scrollerView];
    CGFloat oneWeekWidth = screenW/7.0;
    _scrollerView.contentSize = CGSizeMake(oneWeekWidth*_allWeek, 0);
    for (int i = 0 ; i<self.allWeek; i++) {
        
        UIButton *bt = [UIButton buttonWithType:UIButtonTypeCustom];
        bt.frame = CGRectMake(i*oneWeekWidth, 0,oneWeekWidth , 40);
        [bt setTitle:[NSString stringWithFormat:@"第%d周",i+1] forState:UIControlStateNormal];
        bt.titleLabel.font = [UIFont systemFontOfSize:14.0];
        bt.tag = i+1;
        bt.titleLabel.textAlignment = NSTextAlignmentCenter;
        [bt setTitleColor:mainColor forState:UIControlStateSelected];
        [bt setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        if (bt.tag == self.crtWeek) {
            bt.selected = YES;
            _identitierCrtWeekBt = bt;
        }
        [bt addTarget:self action:@selector(changeWeek:) forControlEvents:UIControlEventTouchUpInside];
        [_scrollerView addSubview:bt];
    }
    
    /*  1. 获取中心位置中心位置是第四周的位置
        2. 如果当前周在中心周的左边，那么就不偏移。已经到了左边界
        3. 如果当前周在中心周的右边，那就把多余的偏移过去，要选中的就刚好在中间
        4. 如果当前周在最后一个界面，因为无法在偏移，所以直接偏移到最后一个页面
     */
    if ((self.crtWeek>4) && ((self.allWeek-self.crtWeek)>=4)) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            self.scrollerView.contentOffset = CGPointMake(oneWeekWidth*(self.crtWeek-4), 0);
        });
        
    }else if(self.crtWeek<=4){
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            self.scrollerView.contentOffset = CGPointMake(0, 0);
        });
       
    }else if((self.allWeek-self.crtWeek)<4){
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            self.scrollerView.contentOffset = CGPointMake((self.allWeek-7)*oneWeekWidth, 0);
        });
       
    }
}

-(void)setWeekData{
    self.crtWeek = _identitierCrtWeekBt.tag;
    //获取当前时间
    NSDate *sendDate = [NSDate date];
    NSDateFormatter *dateFomatter = [[NSDateFormatter alloc]init];
    [dateFomatter setDateFormat:@"yyy"];
    NSString *yearStr = [dateFomatter stringFromDate:sendDate];
    [dateFomatter setDateFormat:@"MM"];
    NSString *monthStr = [dateFomatter stringFromDate:sendDate];
    [dateFomatter setDateFormat:@"dd"];
    NSString *dayStr = [dateFomatter stringFromDate:sendDate];
    [dateFomatter setDateFormat:@"EEE"];
    NSString *weekStr = [dateFomatter stringFromDate:sendDate];
    NSLog(@"周：%@",weekStr);
    int year = [yearStr intValue];
    NSLog(@"年：%d",year);
    int month = [monthStr intValue];
    NSLog(@"月：%d",month);
    int day = [dayStr intValue];
    NSLog(@"日：%d",day);
    //判断当前是周几，从而计算出下周的周一是几号（负数表示上个月月末）
    if ([weekStr isEqualToString:@"周一"]) {
        day = +7;
    }else if([weekStr isEqualToString:@"周二"]){
        day = +6;
    }else if ([weekStr isEqualToString:@"周三"]){
        day = +5;
    }else if ([weekStr isEqualToString:@"周四"]){
        day = +4;
    }else if ([weekStr isEqualToString:@"周五"]){
        day = +3;
    }else if ([weekStr isEqualToString:@"周六"]){
        day = +2;
    }else if ([weekStr isEqualToString:@"周日"]){
        day = +1;
    }
    day = ((int)self.crtWeek-1)*7;
    NSMutableArray *monthArr = [NSMutableArray array];
    NSMutableArray *dayArr = [NSMutableArray array];
    //获取每一周对应的具体日期
    for (int i = 0; i<7; i++) {
        int k = day;
        NSLog(@"时间%@",[GetOneDay getOneDay:k]);
        NSString *monthAndDateStr= [GetOneDay getOneDay:k];
        NSArray * tmpArr = [monthAndDateStr componentsSeparatedByString:@"-"];
        [monthArr addObject:tmpArr[0]];
        [dayArr addObject:tmpArr[1]];
        day++;
    }
    int i = 0;
    for (i = 0; i<monthArr.count-1; i++) {
        if (![monthArr[i+1] isEqualToString:monthArr[i]]) {
            NSLog(@"%@",monthArr[i+1]);
            break;
        }
    }
       //说明这一周有新的一月产生，那么就将该月所对应的1号设置为该月
    if (i<monthArr.count-2) {
        [dayArr replaceObjectAtIndex:i+1 withObject:[NSString stringWithFormat:@"%@月",monthArr[i+1]]];
    }
    self.weekView.weekDateArr = [dayArr mutableCopy];
    self.weekView.weekMonthStr = monthArr[0];
}
-(void)getCoursesData{
    for (UIView *paneV in self.lineTable.subviews) {
        if ([paneV isKindOfClass:[PaneView class]]) {
            [paneV removeFromSuperview];
        }
        
    }
    self.coursesInfoArr = [CourseModel mj_objectArrayWithKeyValuesArray:[PlistTool getPlistDataWithName:@"course"]];
    NSLog(@"coursesInfoArr  : %@",self.coursesInfoArr);
    for (CourseModel *model in self.coursesInfoArr) {
        PaneView *paneV = [[PaneView alloc]initWithFrame:CGRectMake(0,0,paneW,paneH)];
        paneV.courseModel = model;
        paneV.CMblk = ^(CourseModel *courseModel) {
            EditCourseController *editVc = [[EditCourseController alloc]init];
            editVc.courseModel = model;
            editVc.ACBlk = ^(CourseModel *courseModel) {
                [self getCoursesData];
            };
            editVc.delBlk = ^{
                NSLog(@"del");
                [self getCoursesData];
            };
            [self.navigationController pushViewController:editVc animated:YES];
        };
        [self.lineTable addSubview:paneV];
    }
    [self.lineTable reloadData];
}
-(void)initNavTabBarItem{
    
    UIButton * crtBt = [UIButton buttonWithType:UIButtonTypeCustom];
    [crtBt setTitle:@"第4周-" forState:UIControlStateNormal];
    [crtBt setTitle:@"第4周^" forState:UIControlStateSelected];
    crtBt.selected = NO;
    [crtBt setTitleColor:mainColor forState:UIControlStateNormal];
    [crtBt addTarget:self action:@selector(courseDetail:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:crtBt];
    UIButton *addCourseBt = [UIButton buttonWithType:UIButtonTypeCustom];
    [addCourseBt setImage:[UIImage imageNamed:@"add"] forState:UIControlStateNormal];
    [addCourseBt addTarget:self action:@selector(addCourse:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:addCourseBt];
}
-(void)courseDetail:(UIButton *)bt{
    bt.selected = !bt.selected;
    if (bt.selected == 1) {
        [UIView animateWithDuration:0.5 animations:^{
            _scrollerView.frame = CGRectMake(0, 64, screenW, 40);
            _weekDetailView.frame = CGRectMake(0, 64+_scrollerView.frame.size.height, screenW, screenH-64-40);
        }];
        
    }else{
        [UIView animateWithDuration:0.5 animations:^{
            _scrollerView.frame = CGRectMake(0, 64, screenW, 0);
            _weekDetailView.frame = CGRectMake(0, 64+_scrollerView.frame.size.height, screenW, screenH-64-_scrollerView.frame.size.height);
        }];
    }
}
-(void)initWeekView{
    _weekDetailView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, screenW, screenH-64-_scrollerView.frame.size.height)];
    [self.view addSubview:_weekDetailView];
    WeekView *weekV = [[WeekView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 30)];
    [_weekDetailView addSubview:weekV];
    _weekView = weekV;
    self.lineTable = [[UITableView alloc]initWithFrame:CGRectMake(0, self.weekView.frame.size.height, self.view.frame.size.width, _weekDetailView.frame.size.height-_weekView.frame.size.height) style:UITableViewStylePlain];
    self.lineTable.delegate = self;
    self.lineTable.dataSource = self;
    self.lineTable.scrollEnabled = NO;
    self.lineTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_weekDetailView addSubview:self.lineTable];
   
}
-(void)changeWeek:(UIButton *)bt{
    _identitierCrtWeekBt.selected = !_identitierCrtWeekBt.selected;
    bt.selected = !bt.selected;
    _identitierCrtWeekBt = bt;
    CGFloat oneWeekWidth = screenW/7.0;
    if ((_identitierCrtWeekBt.tag>4) && ((self.allWeek-_identitierCrtWeekBt.tag)>=4)) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            self.scrollerView.contentOffset = CGPointMake(oneWeekWidth*(_identitierCrtWeekBt.tag-4), 0);
        });
        
    }else if(_identitierCrtWeekBt.tag<=4){
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            self.scrollerView.contentOffset = CGPointMake(0, 0);
        });
        
    }else if((self.allWeek-_identitierCrtWeekBt.tag)<4){
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            self.scrollerView.contentOffset = CGPointMake((self.allWeek-7)*oneWeekWidth, 0);
        });
        
    }
    NSLog(@"%ld",bt.tag);
    [self setWeekData];
}
- (void)addCourse:(UIButton *)sender{
    AddCourseController *addVc=[[AddCourseController alloc]init];
    addVc.ACBlk = ^(CourseModel *courseModel) {
        [self getCoursesData];
    };
    [self.navigationController pushViewController:addVc animated:YES];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"lineCell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"lineCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        UILabel *lb = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 20,cell.frame.size.height)];
        lb.text = [NSString stringWithFormat:@"%ld",indexPath.row+1];
        lb.backgroundColor = bacColor;
        lb.textColor = [UIColor colorWithRed:111/255.0 green:133/255.0 blue:151/255.0 alpha:1.0];
        lb.font = [UIFont systemFontOfSize:12.0];
        lb.textAlignment = NSTextAlignmentCenter;
        [cell.contentView addSubview:lb];
        UIView *lineV = [[UIView alloc]initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen]bounds].size.width, 1)];
        lineV.backgroundColor = bacColor;
        [cell.contentView addSubview:lineV];
    }
    return cell;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.timeArr.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return paneH;
}
@end
