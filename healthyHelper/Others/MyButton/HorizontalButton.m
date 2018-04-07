//
//  HorizontalButton.m
//  healthyHelper
//
//  Created by snow on 2018/2/26.
//  Copyright © 2018年 snow. All rights reserved.
//

#import "HorizontalButton.h"

@implementation HorizontalButton

-(void)layoutSubviews{
    [super layoutSubviews];
    NSLog(@"------  %@",NSStringFromCGRect(self.imageViewFrame));
    self.imageView.frame = self.imageViewFrame;
    self.titleLabel.frame = self.titleLbFrame;
}

@end
