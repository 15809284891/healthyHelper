//
//  CourseModel.h
//  healthyHelper
//
//  Created by snow on 2018/1/12.
//  Copyright © 2018年 snow. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CourseModel : NSObject
@property (nonatomic,copy)NSString *courseId;
@property (nonatomic,copy)NSString *courseName;
@property (nonatomic,copy)NSString *datetimeBegin;
@property (nonatomic,copy)NSString *datetimeEnd;
@property (nonatomic,copy)NSString *teacher;
@property (nonatomic,copy)NSString *address;
@property (nonatomic,copy)NSString *date;
@end
