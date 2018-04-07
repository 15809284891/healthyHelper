//
//  LXPLaceHolder.m
//  healthyHelper
//
//  Created by snow on 2018/2/10.
//  Copyright © 2018年 snow. All rights reserved.
//

#import "LXPLaceHolder.h"

@implementation LXPLaceHolder
-(CGRect)placeholderRectForBounds:(CGRect)bounds{
    CGRect inset = CGRectMake(5, bounds.origin.y, screenW-10, bounds.size.height);
    return inset;
}
-(CGRect)editingRectForBounds:(CGRect)bounds{
    CGRect inset = CGRectMake(5, bounds.origin.y, screenW-10, bounds.size.height);
    return inset;
}

@end
