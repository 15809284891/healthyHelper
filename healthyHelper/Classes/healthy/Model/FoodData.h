//
//  Food.h
//  healthyHelper
//
//  Created by snow on 2018/4/16.
//  Copyright © 2018年 snow. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FoodData : NSObject
@property (nonatomic,copy)NSString *foodDataID;
@property (nonatomic,copy)NSString *foodName;
@property (nonatomic,copy)NSString *foodImage;
@property (nonatomic,assign)int eatingWeight;
@property (nonatomic,assign)int eatingEnergy;
@property (nonatomic,copy)NSString *createTime;
@property (nonatomic,assign)int type;
@property (nonatomic,strong)NSString *updateTime;
@end
