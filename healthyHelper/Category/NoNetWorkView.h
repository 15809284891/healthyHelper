//
//  NoNetWorkView.h
//  图书管理
//
//  Created by snow on 2017/5/24.
//  Copyright © 2017年 lixue. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol NoNetWorkViewDelegate <NSObject>

-(void)refershView;

@end
@interface NoNetWorkView : UIView
@property (nonatomic,weak)id<NoNetWorkViewDelegate>delegate;
@end
