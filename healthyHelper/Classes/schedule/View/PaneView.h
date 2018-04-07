//
//  PaneView.h
//  healthyHelper
//
//  Created by snow on 2018/1/11.
//  Copyright © 2018年 snow. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CourseModel;
typedef void (^CourseModelBlock)(CourseModel *courseModel);
@interface PaneView : UIButton
-(void)drawPanewithPosion:(CGPoint)point withHeight:(CGFloat)height;
@property (nonatomic,strong)CourseModel *courseModel;
@property (nonatomic,copy)NSString *courseName;
@property (nonatomic,copy)CourseModelBlock CMblk;
@end
