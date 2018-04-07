//
//  VerticalButton.m
//  healthyHelper
//
//  Created by snow on 2018/1/31.
//  Copyright © 2018年 snow. All rights reserved.
//

#import "VerticalButton.h"

@implementation VerticalButton
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    return self;
}
-(void)layoutSubviews{
    [super layoutSubviews];
    self.imageView.frame = CGRectMake((80-32)/2.0, 0, 32, 32);
    self.titleLabel.frame = CGRectMake(0, 35, 80, 45);
}
@end
