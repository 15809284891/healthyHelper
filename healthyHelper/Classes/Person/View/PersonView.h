//
//  PersonView.h
//  图书管理
//
//  Created by lixue on 16/7/15.
//  Copyright © 2016年 lixue. All rights reserved.
//

#import <UIKit/UIKit.h>
@class personModel;
@protocol PersonViewDelegate <NSObject>
-(void)loginorChange:(UIButton *)sender;
@end
@interface PersonView : UIView
@property(nonatomic)UIButton *ImageButton;
@property(nonatomic)UILabel *nameLb;
@property(nonatomic)UILabel *numLb;
@property(nonatomic)UILabel*majorLb;
@property(nonatomic,weak)id<PersonViewDelegate>delegate;
@property(nonatomic,strong)personModel *person;
-(void)initHeadViewName;
@end

