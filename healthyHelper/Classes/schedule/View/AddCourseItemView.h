//
//  AddCourseCell.h
//  healthyHelper
//
//  Created by snow on 2018/1/10.
//  Copyright © 2018年 snow. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^ContentBlk)(NSString *content);
@interface AddCourseItemView : UIView
@property (nonatomic,copy)NSString *iconImage;
@property (nonatomic,copy)NSString *tfContent;
@property (nonatomic,copy) ContentBlk contentblk;
@end

