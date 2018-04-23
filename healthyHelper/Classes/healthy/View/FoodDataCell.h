//
//  FoodDataCell.h
//  healthyHelper
//
//  Created by snow on 2018/4/16.
//  Copyright © 2018年 snow. All rights reserved.
//

#import <UIKit/UIKit.h>
@class FoodData;
@interface FoodDataCell : UITableViewCell
@property (nonatomic,strong)FoodData *fooddata;
+(FoodDataCell *)addFoodDataCellWithTableView:(UITableView *)tableView;
@end
