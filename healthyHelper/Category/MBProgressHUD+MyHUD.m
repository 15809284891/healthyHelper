//
//  MBProgressHUD+MyHUD.m
//  图书管理
//
//  Created by snow on 2017/5/15.
//  Copyright © 2017年 lixue. All rights reserved.
//

#import "MBProgressHUD+MyHUD.h"

@implementation MBProgressHUD (MyHUD)
+(MBProgressHUD *)showMessage:(NSString *)message{
    return [self showMessage:message toView:nil];
}
+(MBProgressHUD *)showMessage:(NSString *)message toView:(UIView *)view{
    if (view== nil)
        view = [[UIApplication sharedApplication].windows lastObject];
    MBProgressHUD*hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.labelText = message;
    hud.removeFromSuperViewOnHide = YES;
    hud.mode = MBProgressHUDModeText;
    hud.dimBackground = YES;
    [hud hide:YES afterDelay:2];
    
    
    return hud;
}

@end
