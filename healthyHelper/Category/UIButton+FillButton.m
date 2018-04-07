//
//  UIButton+FillButton.m
//  healthyHelper
//
//  Created by snow on 2018/2/27.
//  Copyright © 2018年 snow. All rights reserved.
//

#import "UIButton+FillButton.h"

@implementation UIButton (FillButton)
-(void)setBackgroundColor:(UIColor *)backgroundColor forState:(UIControlState)state{
    [self setBackgroundImage:[UIButton imageWithColor:backgroundColor] forState:state];
}
+(UIImage *)imageWithColor:(UIColor *)color{
    CGRect rect = CGRectMake(0, 0, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}
@end
