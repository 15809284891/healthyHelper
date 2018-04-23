//
//  XMGLoginRegisterViewController.m
//  01-百思不得姐
//
//  Created by xiaomage on 15/7/26.
//  Copyright (c) 2015年 小码哥. All rights reserved.
//

#import "XMGLoginRegisterViewController.h"
#import "LXTabBarController.h"
#import "XMGTextField.h"
#import "MBProgressHUD+MyHUD.h"
@interface XMGLoginRegisterViewController ()
/** 登录框距离控制器view左边的间距 */
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *loginViewLeftMargin;
@property (weak, nonatomic) IBOutlet XMGTextField *usernameTf;
@property (weak, nonatomic) IBOutlet XMGTextField *pwdTf;
@property (weak, nonatomic) IBOutlet UIButton *register_loginBt;
@property (weak, nonatomic) IBOutlet UIButton *loginBt;
@property (weak, nonatomic) IBOutlet UIButton *changePwd;


@end

@implementation XMGLoginRegisterViewController

- (IBAction)back {
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
}

- (IBAction)login:(id)sender {
    NSLog(@"%@ %@",_usernameTf.text,_pwdTf.text);
//    if ([_usernameTf.text isEqualToString:@"15809284891"] && [_pwdTf.text isEqualToString:@"123456"]) {
//        NSLog(@"hello");
//    [SVProgressHUD showWithStatus:@"正在登陆"];
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [SVProgressHUD dismiss];
        [self dismissViewControllerAnimated:YES completion:nil];
        [UIApplication sharedApplication].keyWindow.rootViewController = [[LXTabBarController alloc]init];
//    });
    
//    }
}
- (IBAction)changePwd:(id)sender {
}

- (IBAction)showLoginOrRegister:(UIButton *)button {
    // 退出键盘
    [self.view endEditing:YES];
    
    if (self.loginViewLeftMargin.constant == 0) { // 显示注册界面
        self.loginViewLeftMargin.constant = - self.view.frame.size.width;
        button.selected = YES;
    } else { // 显示登录界面
        self.loginViewLeftMargin.constant = 0;
        button.selected = NO;
    }
    
    [UIView animateWithDuration:0.25 animations:^{
        [self.view layoutIfNeeded];
    }];
}
@end
