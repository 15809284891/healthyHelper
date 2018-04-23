//
//  AddCourseCell.m
//  healthyHelper
//
//  Created by snow on 2018/1/10.
//  Copyright © 2018年 snow. All rights reserved.
//

#import "AddCourseItemView.h"
@interface AddCourseItemView()<UITextFieldDelegate>
@property (nonatomic,strong)UIImageView *icon;
@property (nonatomic,strong)UITextField *tf;
@property (nonatomic,strong)UIButton *editBt;
@end
@implementation AddCourseItemView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        UIImageView *icon = [[UIImageView alloc]initWithFrame:CGRectMake(10, (frame.size.height-30)/2.0, 30, 30)];
        [self addSubview:icon];
        self.icon = icon;
        
        UITextField *tf = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(icon.frame)+10,0,self.frame.size.width-CGRectGetMaxX(icon.frame)-20 ,self.frame.size.height)];
        tf.delegate = self;
        
        self.tf = tf;
        UIButton *editBt = [UIButton buttonWithType:UIButtonTypeCustom];
        editBt.backgroundColor = [UIColor redColor];
        [self addSubview:editBt];
        self.editBt = editBt;
        [self addSubview:tf];
    }
    return self;
}
-(void)setIconImage:(NSString *)iconImage{
    self.icon.image = [UIImage imageNamed:iconImage];
}
-(void)setTfContent:(NSString *)tfContent{
    self.tf.text = tfContent;
    if (self.contentblk) {
        self.contentblk(tfContent);
    }
}
-(void)textFieldDidBeginEditing:(UITextField *)textField{
    [self.tf becomeFirstResponder];
    
}

-(BOOL)resignFirstResponder{
    return YES;
}
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if (self.contentblk) {
        self.contentblk(textField.text);
    }
    return YES;
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    if (self.contentblk) {
        self.contentblk(textField.text);
    }
    return YES;
}
-(void)textFieldDidEndEditing:(UITextField *)textField{
    [textField resignFirstResponder];
    if (self.contentblk) {
        self.contentblk(textField.text);
    }
}
@end

