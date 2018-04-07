//
//  EditCourseController.h
//  healthyHelper
//
//  Created by snow on 2018/1/21.
//  Copyright © 2018年 snow. All rights reserved.
//

#import "AddCourseController.h"
typedef void(^DelBlock)(void);
@interface EditCourseController : AddCourseController
@property (nonatomic,copy)DelBlock delBlk;
@end
