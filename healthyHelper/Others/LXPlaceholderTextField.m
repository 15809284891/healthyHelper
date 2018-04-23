//
//  LXPlaceholderTextField.m
//  图书管理
//
//  Created by shixihao on 16/8/9.
//  Copyright © 2016年 lixue. All rights reserved.
//

#import "LXPlaceholderTextField.h"
#import <objc/runtime.h>
@interface LXPlaceholderTextField()
{
    UILabel *_lable;
}
@end
@implementation LXPlaceholderTextField
//+ (void)initialize
//{
//    unsigned int count = 0;
//    Ivar *vars =  class_copyIvarList([UITextField class], &count);
//    for (int i= 0; i<count; i++) {
//        Ivar var = *(vars+i);
//        NSLog(@"%s",ivar_getName(var));
//    }
//}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.textColor = [UIColor colorWithRed:217/255.0 green:102/255.0 blue:97/255.0 alpha:1.0];
        self.tintColor = self.textColor;
        [self setValue:[UIColor lightGrayColor] forKeyPath:@"_placeholderLabel.textColor"];
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        dic[NSForegroundColorAttributeName] = [UIColor lightGrayColor];
        NSAttributedString *attributeString = [[NSAttributedString alloc]initWithString:@"账号" attributes:dic];
        self.attributedPlaceholder = attributeString;
        [self resignFirstResponder];
        _lable = [[UILabel alloc]init];
        _lable.backgroundColor = [UIColor lightGrayColor];
//        NSLog(@"hahah %@",self.subviews);
        [self addSubview:_lable];
    }
    return self;
}
-(void)layoutSubviews{
    [super layoutSubviews];
    _lable.frame=CGRectMake(0, self.frame.size.height-1, self.frame.size.width, 1);
}
-(BOOL)becomeFirstResponder{
    [self setValue:[UIColor colorWithRed:217/255.0 green:102/255.0 blue:97/255.0 alpha:1.0] forKeyPath:@"_placeholderLabel.textColor"];
    return [super becomeFirstResponder];
}
-(BOOL)resignFirstResponder{
    [self setValue:[UIColor lightGrayColor] forKeyPath:@"_placeholderLabel.textColor"];
    return [super resignFirstResponder];
}
@end
