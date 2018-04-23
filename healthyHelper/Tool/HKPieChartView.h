//
//  HKPieChartView.h
//  PieChart
//
//  Created by hukaiyin on 16/6/20.
//  Copyright © 2016年 HKY. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HKPieChartView : UIView
@property (nonatomic,assign)NSInteger allKll;
@property (nonatomic,assign)NSInteger haveEatKll;
@property (nonatomic,assign)NSInteger sportKll;
@property (nonatomic,assign)NSInteger canEatkll;
- (void)updatePercent:(CGFloat)percent animation:(BOOL)animationed;
@end
