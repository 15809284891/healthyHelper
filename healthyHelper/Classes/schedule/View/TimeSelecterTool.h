//
//  TimeSelecterTool.h
//  healthyHelper
//
//  Created by snow on 2018/1/11.
//  Copyright © 2018年 snow. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^TimeBlock) (NSDictionary *dateAndTime);
@interface TimeSelecterTool : UIView
@property (nonatomic,copy)TimeBlock timeBlk;
@property (nonatomic,strong)UIPickerView *pickerV;
@property (nonatomic,copy)NSMutableDictionary *timeDic;
@property (nonatomic,copy)NSMutableString *timeStr;
@property (nonatomic,copy)NSArray *weeks;
@property (nonatomic,copy)NSArray *begins;
@property (nonatomic,copy)NSArray *ends;
@end
