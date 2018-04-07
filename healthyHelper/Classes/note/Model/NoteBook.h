//
//  NoteBook.h
//  healthyHelper
//
//  Created by snow on 2018/1/6.
//  Copyright © 2018年 snow. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NoteBook : NSObject
@property (nonatomic,copy)NSString *NoteBookId;
@property (nonatomic,copy)NSString *NoteBookName;
@property (nonatomic,assign)NSInteger NoteCount;
@end
