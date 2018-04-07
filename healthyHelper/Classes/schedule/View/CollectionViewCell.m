//
//  CollectionViewCell.m
//  healthyHelper
//
//  Created by snow on 2018/2/28.
//  Copyright © 2018年 snow. All rights reserved.
//

#import "CollectionViewCell.h"
#import "UIButton+FillButton.h"
@interface CollectionViewCell()

@end
@implementation CollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIButton *selectorBt = [UIButton buttonWithType:UIButtonTypeCustom];
        selectorBt.frame = self.contentView.frame;
        selectorBt.userInteractionEnabled = NO;
        selectorBt.selected = YES;
        [selectorBt setBackgroundColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [selectorBt setBackgroundColor:[UIColor colorWithRed:106/255.0 green:220/255.0 blue:189/255.0 alpha:1.0] forState:UIControlStateSelected];
        [selectorBt setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [selectorBt addTarget:self action:@selector(selectorCellItem:) forControlEvents:UIControlEventTouchUpInside];
         [self.contentView addSubview:selectorBt];//必须加载 contentView上，不然会错位
        _selectorBt = selectorBt;
    }
    return self;
}
-(void)setBtTitle:(NSString *)btTitle{
    [self.selectorBt setTitle:btTitle forState:UIControlStateNormal];
}
@end
