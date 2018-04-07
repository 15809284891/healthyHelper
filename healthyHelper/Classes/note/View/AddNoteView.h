//
//  AddNoteView.h
//  healthyHelper
//
//  Created by snow on 2018/2/1.
//  Copyright © 2018年 snow. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^addNoteBLk)(UIButton *bt);
@interface AddNoteView : UIView
@property (nonatomic,copy)addNoteBLk blk;
-(void)removeAddView:(UIView *)view;
@end
