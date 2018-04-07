//
//  PaneView.m
//  healthyHelper
//
//  Created by snow on 2018/1/11.
//  Copyright © 2018年 snow. All rights reserved.
//

#import "PaneView.h"
#import "CourseModel.h"
@interface PaneView()
@property (nonatomic,strong)UILabel *courseNameLb;
@end
@implementation PaneView
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        CGFloat hue = ( arc4random() % 256 / 256.0 );  //0.0 to 1.0
        CGFloat saturation = ( arc4random() % 128 / 256.0 ) + 0.5;  // 0.5 to 1.0,away from white
        CGFloat brightness = ( arc4random() % 128 / 256.0 ) + 0.5;  //0.5 to 1.0,away from black
        self.backgroundColor = [UIColor colorWithRed:hue green:saturation blue:brightness alpha:1.0];
        self.layer.cornerRadius = 8;
        self.layer.masksToBounds = YES;
        _courseNameLb = [[UILabel alloc]initWithFrame:CGRectMake(0, 0,40, 80)];
        _courseNameLb.layer.cornerRadius = 8;
        _courseNameLb.layer.masksToBounds = YES;
        _courseNameLb.font = [UIFont systemFontOfSize:14.0];
        _courseNameLb.textColor = [UIColor whiteColor];
        _courseNameLb.numberOfLines = 0;
        _courseNameLb.textAlignment = NSTextAlignmentCenter;
        _courseNameLb.lineBreakMode = NSLineBreakByCharWrapping;
         [self addTarget:self action:@selector(clickPaneV:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_courseNameLb];
    }
    return self;
}
-(void)setCourseModel:(CourseModel *)courseModel{
    _courseModel = courseModel;
    _courseNameLb.text = courseModel.courseName;
    int begin = [courseModel.datetimeBegin intValue];
    int end = [courseModel.datetimeEnd intValue];
    NSString *weekStr = courseModel.date;
    CGFloat x;
    CGFloat y;
    if ([weekStr isEqualToString:@"周一"]) {
        x= 20;
    }else if([weekStr isEqualToString:@"周二"]){
        x = 20+paneW+1;
    }else if([weekStr isEqualToString:@"周三"]){
        x = 20+(paneW+1)*2;
    }else if([weekStr isEqualToString:@"周四"]){
        x = 20+(paneW+1)*3;
    }else if([weekStr isEqualToString:@"周五"]){
        x = 20+(paneW+1)*4;
    }else if([weekStr isEqualToString:@"周六"]){
        x = 20+(paneW+1)*5;
    }else{
        x = 20+(paneW+1)*6;
    }
    [self drawPanewithPosion:CGPointMake(x, paneH*(begin-1)) withHeight:(end-begin+1)*paneH];
}
-(void)setCourseName:(NSString *)courseName{
    NSLog(@"----------%@",courseName);
    _courseNameLb.text = courseName;
}
-(void)drawPanewithPosion:(CGPoint)point withHeight:(CGFloat)height{
    self.frame = CGRectMake(point.x+2, point.y+2, paneW-4, height-4);
    _courseNameLb.frame = self.bounds;
}
-(void)clickPaneV:(UIButton *)bt{
    if (self.CMblk) {
         self.CMblk(_courseModel);
       
    }
}
@end
