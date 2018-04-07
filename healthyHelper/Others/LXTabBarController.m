//
//  LXTabBarController.m
//  healthyHelper
//
//  Created by snow on 2017/12/29.
//  Copyright © 2017年 snow. All rights reserved.
//

#import "LXTabBarController.h"
#import "ScheduleController.h"
#import "NoteBookController.h"
#import "HealthyController.h"
#import "PersonController.h"
@interface LXTabBarController ()

@end

@implementation LXTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UINavigationController *healthyVc = [[UINavigationController alloc]initWithRootViewController:[[HealthyController alloc]init]];
    healthyVc.tabBarItem.title = @"健康";
    healthyVc.tabBarItem.image = [[UIImage imageNamed:@"healthyNormal"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    healthyVc.tabBarItem.selectedImage = [[UIImage imageNamed:@"healthySelected"]imageWithRenderingMode: UIImageRenderingModeAlwaysOriginal];
    [self addChildViewController:healthyVc];
    
    UINavigationController *noteVc = [[UINavigationController alloc]initWithRootViewController:[[NoteBookController alloc]init]];
    noteVc.tabBarItem.title = @"笔记";
    noteVc.tabBarItem.image = [[UIImage imageNamed:@"noteNormal"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    noteVc.tabBarItem.selectedImage = [[UIImage imageNamed:@"noteSelected"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [self addChildViewController:noteVc];
    
    UINavigationController *scheduleVc = [[UINavigationController alloc]initWithRootViewController:[[ScheduleController alloc]init]];
    scheduleVc.tabBarItem.title = @"课程";
    scheduleVc.tabBarItem.image = [[UIImage imageNamed:@"courseNormal"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    scheduleVc.tabBarItem.selectedImage = [[UIImage imageNamed:@"courseSelected"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [self addChildViewController:scheduleVc];
    
    UINavigationController *personVc = [[UINavigationController alloc]initWithRootViewController:[[PersonController alloc]init]];
    personVc.tabBarItem.title = @"我";
    personVc.tabBarItem.image = [[UIImage imageNamed:@"meNormal"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    personVc.tabBarItem.selectedImage = [[UIImage imageNamed:@"meSelected"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [self addChildViewController:personVc];
    self.tabBar.tintColor = mainColor;
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
