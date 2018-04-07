//
//  WeekSelector.h
//  healthyHelper
//
//  Created by snow on 2018/2/26.
//  Copyright © 2018年 snow. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^WeeksBlock) (NSArray *weeks);
@interface WeekSelector : UICollectionView
@property (nonatomic,copy)WeeksBlock weekBlk;;
@end
