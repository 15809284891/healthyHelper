//
//  AddCourseView.m
//  healthyHelper
//
//  Created by snow on 2018/1/11.
//  Copyright © 2018年 snow. All rights reserved.
//

#import "AddCourseView.h"
#import "AddCourseItemView.h"
#import "WeekSelector.h"
#import "TimeSelecterTool.h"
#import "CourseModel.h"

@interface AddCourseView()

@property (nonatomic,strong) UIButton *saveBt;
//@property (nonatomic,strong)CourseModel *courseModel;
@property (nonatomic,strong)WeekSelector *weelSelector;
@property (nonatomic,strong)HorizontalButton *weekBt;
@end
@implementation AddCourseView
-(WeekSelector *)weelSelector{
    if (!_weelSelector) {
        _weelSelector = [[WeekSelector alloc]initWithFrame:CGRectMake((screenW-50*6-5*1.)/2.0, 120, 50*6+5*1.0, 50*6) collectionViewLayout:nil];
        
        _weelSelector.backgroundColor = [UIColor redColor];
        __weak typeof(self) weakSelf = self;
        _weelSelector.weekBlk = ^(NSArray *weeks) {
            [weakSelf.weelSelector removeFromSuperview];
            NSMutableString *str = [NSMutableString string];
            for (int i = 0; i<weeks.count; i++) {
                if (i == 0) {
                    [str appendString:[NSString stringWithFormat:@"第%@,",weeks[i]]];
                }else if (i == (weeks.count - 1)) {
                    [str appendString:[NSString stringWithFormat:@"%@周",weeks[i]]];
                }else{
                    [str appendString:[NSString stringWithFormat:@"%@,",weeks[i]]];
                }
                
            }
            [weakSelf.weekBt setTitle:str forState:UIControlStateNormal];
            NSLog(@"%@",weeks);
        };
        _weelSelector.backgroundColor = bacColor;
    }
    return _weelSelector;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        CGFloat width = self.frame.size.width;
        _courseNameItemV= [[AddCourseItemView alloc]initWithFrame:CGRectMake(0, 0, width, courseCellH)];
        _courseNameItemV.iconImage = @"book";
        __weak typeof(self) weakSelf = self;
        _courseNameItemV.contentblk = ^(NSString *content) {

            weakSelf.courseModel.courseName= content;
        };
        [self addSubview:_courseNameItemV];
        
        _teacherNameItemV = [[AddCourseItemView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_courseNameItemV.frame)+1,width , courseCellH)];
        _teacherNameItemV.iconImage = @"teacher";
        _teacherNameItemV.contentblk = ^(NSString *content) {
             weakSelf.courseModel.teacher = content;
        };
        [self addSubview:_teacherNameItemV];
        
        _weekBt = [HorizontalButton buttonWithType:UIButtonTypeCustom];
        _weekBt.frame = CGRectMake(0, CGRectGetMaxY(_teacherNameItemV.frame)+courseDis, width, courseCellH);
        _weekBt.imageViewFrame = CGRectMake(10, (_weekBt.frame.size.height-30)/2.0, 30, 30);
        [_weekBt setTitle:@"第1到17周" forState:UIControlStateNormal];
        [_weekBt setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_weekBt setImage:[UIImage imageNamed:@"date"] forState:UIControlStateNormal];
        _weekBt.titleLbFrame = CGRectMake(10+_weekBt.imageViewFrame.size.width+10, 0, _weekBt.frame.size.width-_weekBt.imageViewFrame.size.width-20, _weekBt.frame.size.height);
        _weekBt.backgroundColor = [UIColor whiteColor];
        [_weekBt addTarget:self action:@selector(chooseWeek) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_weekBt];
        
        _timeV = [[TimeSelecterTool alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_weekBt.frame)+1, width, courseCellH)];
        
        _timeV.timeBlk = ^(NSDictionary *dateAndTime) {
            weakSelf.courseModel.date = dateAndTime[@"week"];
            weakSelf.courseModel.datetimeBegin = dateAndTime[@"begin"];
            weakSelf.courseModel.datetimeEnd = dateAndTime[@"end"];
        };
        [self addSubview:_timeV];
        
        _addressItemV = [[AddCourseItemView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_timeV.frame)+1, width, courseCellH)];
        _addressItemV.iconImage = @"address";
        _addressItemV.contentblk = ^(NSString *content) {
            weakSelf.courseModel.address = content;
        };
        [self addSubview:_addressItemV];
        
        _saveBt = [UIButton buttonWithType:UIButtonTypeCustom];
        _saveBt.frame= CGRectMake(10, CGRectGetMaxY(_addressItemV.frame)+courseDis*2, self.frame.size.width-20, 45);
        [_saveBt setTitle:@"保存" forState:UIControlStateNormal];
        _saveBt.backgroundColor = mainColor;
        _saveBt.layer.cornerRadius = 5;
        _saveBt.layer.masksToBounds = YES;
        [_saveBt addTarget:self action:@selector(saveAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_saveBt];
    }
    return self;
}
-(void)chooseWeek{
    [self addSubview:self.weelSelector];
}
-(void)saveAction:(UIButton *)sender{
    NSLog(@"保存");
    NSInteger weekR = [_timeV.pickerV selectedRowInComponent:0];
    NSInteger beginR = [_timeV.pickerV selectedRowInComponent:1];
    NSInteger endR = [_timeV.pickerV selectedRowInComponent:3];
    self.courseModel.date = _timeV.weeks[weekR];
    self.courseModel.datetimeBegin = _timeV.begins[beginR];
    self.courseModel.datetimeEnd =_timeV.ends[endR];
    NSLog(@"saveAction   : %@",self.courseModel.mj_keyValues);
    if (self.saveBlk) {
        self.saveBlk(self.courseModel);
    }
}
@end

