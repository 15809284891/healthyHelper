//
//  FoodDetailView.h
//  healthyHelper
//
//  Created by snow on 2018/4/17.
//  Copyright © 2018年 snow. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Food;
@class FoodData;
@interface FoodDetailView : UIView
@property (nonatomic,strong)Food *food;
@property (nonatomic,strong)FoodData *foodData;
@end
