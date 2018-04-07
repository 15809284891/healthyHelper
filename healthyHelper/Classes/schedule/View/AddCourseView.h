//
//  AddCourseView.h
//  healthyHelper
//
//  Created by snow on 2018/1/11.
//  Copyright © 2018年 snow. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CourseModel;
@class  AddCourseItemView;
@class TimeSelecterTool;
typedef  void(^saveBlock)(CourseModel *courseModel);
@interface AddCourseView : UIView
@property (nonatomic,strong)CourseModel *courseModel;
@property (nonatomic,strong) AddCourseItemView *courseNameItemV;
@property (nonatomic,strong) AddCourseItemView *teacherNameItemV;
@property (nonatomic,strong) TimeSelecterTool *timeV;
@property (nonatomic,strong) AddCourseItemView *addressItemV;
@property(nonatomic,copy)saveBlock saveBlk;
@end

