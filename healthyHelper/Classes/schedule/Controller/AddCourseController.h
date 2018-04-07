//
//  AddCourseController.h
//  healthyHelper
//
//  Created by snow on 2018/1/9.
//  Copyright © 2018年 snow. All rights reserved.
//

#import <UIKit/UIKit.h>
@class AddCourseView;
@class CourseModel;
typedef void(^AddCourseBlock)(CourseModel *courseModel);
@interface AddCourseController : UIViewController
@property (nonatomic,strong)CourseModel *courseModel;
@property (nonatomic,strong)AddCourseView *addCourseView;
@property (nonatomic,copy)AddCourseBlock ACBlk;
@end

