//
//  NoNetWorkView.m
//  图书管理
//
//  Created by snow on 2017/5/24.
//  Copyright © 2017年 lixue. All rights reserved.
//

#import "NoNetWorkView.h"

@implementation NoNetWorkView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIImage *image = [UIImage imageNamed:@"网络好像不给力"];
        CGFloat scale = image.size.width/image.size.height;
        CGFloat width = 50;
        CGFloat heoght =width/scale;
        UIImageView *imageV= [[UIImageView alloc]init];
        imageV.image = image;
        [self addSubview:imageV];
        [imageV makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.centerX);
            make.centerY.equalTo(self.centerY).offset(-20);
            make.width.equalTo(width);
            make.height.equalTo(heoght);
        }];
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:@"点击加载" forState: UIControlStateNormal];
        [button setBackgroundImage:[UIImage withBtnImage:[UIImage imageNamed:@"按钮背景"]] forState:UIControlStateNormal];
        button.frame = CGRectMake((self.frame.size.width-90)/2.0, (self.frame.size.height-25)/2.0+30, 90, 25);
        [button addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];

    }
    return self;
}
-(void)click{
        [self.delegate refershView];
}
@end
