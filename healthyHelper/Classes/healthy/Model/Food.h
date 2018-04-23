//
//  Food.h
//  healthyHelper
//
//  Created by snow on 2018/4/16.
//  Copyright © 2018年 snow. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Food : NSObject

@property (nonatomic,copy)NSString *foodName;
@property (nonatomic,copy)NSString *foodImage;
@property (nonatomic,assign)int foodEnergy;
@end
