//
//  AddNoteView.m
//  healthyHelper
//
//  Created by snow on 2018/2/1.
//  Copyright © 2018年 snow. All rights reserved.
//

#import "AddNoteView.h"
#import "VerticalButton.h"
@implementation AddNoteView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.alpha = 0.95;
        self.backgroundColor = [UIColor lightGrayColor];
        UIToolbar *toobar = [[UIToolbar alloc]initWithFrame:frame];
        [self addSubview:toobar];
        NSArray *imgs = @[@"tupian",@"tupian",@"tupian"];
        NSArray *titles = @[@"拍照上传",@"图册选择",@"音频上传"];
        CGFloat width = 80;
        CGFloat height = 60;
        CGFloat disX = (self.frame.size.width-width*imgs.count)/4.0;
        for (int i = 0; i<imgs.count; i++) {
            VerticalButton *button = [VerticalButton buttonWithType:UIButtonTypeCustom];
            CGFloat y = (self.frame.size.height-height)/2.0;
            button.frame = CGRectMake(disX*(i+1)+width*i, y, width, height);
            [button setTitle:titles[i] forState:UIControlStateNormal];
            [button setImage:[UIImage imageNamed:imgs[i]] forState:UIControlStateNormal];
            [self addSubview:button];
            button.tag = i;
            [button addTarget:self action:@selector(addNoteAction:) forControlEvents:UIControlEventTouchUpInside];
        }
            UIButton *closeBt = [UIButton buttonWithType:UIButtonTypeCustom];
            closeBt.frame = CGRectMake((self.frame.size.width-35)/2.0, (self.frame.size.height-50), 35, 35);
            [closeBt setImage:[UIImage imageNamed:@"close"] forState:UIControlStateNormal];
            [closeBt addTarget:self action:@selector(close:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:closeBt];
        
    }
    return self;
}
-(void)addNoteAction:(UIButton *)sender{
    if (self.blk) {
        self.blk(sender);
    }
}
-(void)close:(UIButton *)sender{
    [self removeAddView:self];
}
-(void)removeAddView:(UIView *)view{
    [UIView animateWithDuration:0.5 animations:^{
        view.frame = CGRectMake(0, screenH, screenW, screenH);
        [view removeFromSuperview];
    }];
}
@end
