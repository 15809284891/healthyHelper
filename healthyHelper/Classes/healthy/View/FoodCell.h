//
//  FoodCell.h
//  healthyHelper
//
//  Created by snow on 2018/4/16.
//  Copyright © 2018年 snow. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Food;
@interface FoodCell : UITableViewCell
@property (nonatomic,strong)Food *food;
+(FoodCell *)addFoodCellWithTableView:(UITableView *)tableView;
@end
