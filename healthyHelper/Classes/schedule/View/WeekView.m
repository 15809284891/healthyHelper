//
//  WeekView.m
//  healthyHelper
//
//  Created by snow on 2018/1/8.
//  Copyright © 2018年 snow. All rights reserved.
//

#import "WeekView.h"
#import "GetOneDay.h"
@interface WeekView()
@property (nonatomic,strong)UILabel *monthLb;
@end
@implementation WeekView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    NSArray *weekArr = @[@"周一",@"周二",@"周三",@"周四",@"周五",@"周六",@"周日"];
    if (self) {
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
        NSLog(@"%@",weekStr);
        int year = [yearStr intValue];
        NSLog(@"%d",year);
        int month = [monthStr intValue];
        NSLog(@"%d",month);
        int day = [dayStr intValue];
        NSLog(@"%d",day);
        self.backgroundColor = [UIColor whiteColor];
        CGFloat beginX = 20;
        CGFloat dis = 1;
        CGFloat width = paneW;
        //设置月份
        _monthLb= [[UILabel alloc]initWithFrame:CGRectMake(0, 0, beginX, self.frame.size.height)];
        _monthLb.backgroundColor = bacColor;
        _monthLb.numberOfLines = 2;
        _monthLb.lineBreakMode = UILineBreakModeCharacterWrap;
        _monthLb.font = [UIFont systemFontOfSize:12.0];
        _monthLb.textColor = [UIColor colorWithRed:111/255.0 green:133/255.0 blue:151/255.0 alpha:1.0];
        _monthLb.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_monthLb];
        //判断当前是周几，从而计算出当周的周一是几号（负数表示上个月月末）
        if ([weekStr isEqualToString:@"周一"]) {
            day = 0;
        }else if([weekStr isEqualToString:@"周二"]){
            day = -1;
        }else if ([weekStr isEqualToString:@"周三"]){
            day = -2;
        }else if ([weekStr isEqualToString:@"周四"]){
            day = -3;
        }else if ([weekStr isEqualToString:@"周五"]){
            day = -4;
        }else if ([weekStr isEqualToString:@"周六"]){
            day = -5;
        }else if ([weekStr isEqualToString:@"周日"]){
            day = -6;
        }
        
        //放置日期
        for (int i = 0; i<7; i++) {
            UILabel *weeklb = [[UILabel alloc]initWithFrame:CGRectMake(beginX+i*width+dis*(i+1), 0, width, self.frame.size.height/2.0)];
            weeklb.backgroundColor = bacColor;
            weeklb.font = [UIFont systemFontOfSize:12.0];
            weeklb.textColor = [UIColor colorWithRed:111/255.0 green:133/255.0 blue:151/255.0 alpha:1.0];
            weeklb.textAlignment = NSTextAlignmentCenter;
            weeklb.text = weekArr[i];
            [self addSubview:weeklb];
            CGRect rect = CGRectMake(weeklb.frame.origin.x, weeklb.frame.size.height, width, self.frame.size.height/2.0);
            UILabel *datelb = [[UILabel alloc]initWithFrame:rect];
            datelb.backgroundColor = bacColor;
            datelb.tag = i+1;
            datelb.font = [UIFont systemFontOfSize:12.0];
            datelb.textColor = [UIColor colorWithRed:111/255.0 green:133/255.0 blue:151/255.0 alpha:1.0];
            datelb.textAlignment = NSTextAlignmentCenter;
            [self addSubview:datelb];
        }
    }
    return self;
}
-(void)setWeekMonthStr:(NSString *)weekMonthStr{
    _monthLb.text = [NSString stringWithFormat:@"%@月",weekMonthStr];
}
-(void)setWeekDateArr:(NSArray *)weekDateArr{
    _weekDateArr = weekDateArr;
    for (int i = 0; i<7; i++) {
        int tag = i+1;
        UILabel *datelb =  [self viewWithTag:tag];
        datelb.text = weekDateArr[i];
    }
}
//添加月份
-(void)setDateLable:(CGRect)rect number:(NSString *)number{
    UILabel *datelb = [[UILabel alloc]initWithFrame:rect];
    datelb.backgroundColor = bacColor;
    datelb.font = [UIFont systemFontOfSize:12.0];
    datelb.textColor = [UIColor colorWithRed:111/255.0 green:133/255.0 blue:151/255.0 alpha:1.0];
    datelb.textAlignment = NSTextAlignmentCenter;
    datelb.text = number;
    [self addSubview:datelb];
    
}
@end
