//
//  EditNoteController.h
//  healthyHelper
//
//  Created by snow on 2018/1/31.
//  Copyright © 2018年 snow. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Note;
@interface NoteDetailController : UIViewController
@property (nonatomic,strong)UIImage *photoImage;
@property (nonatomic,assign)NSInteger type;
@property (nonatomic,strong)Note *note;
@property (nonatomic,strong)NSString *inHtmlString;//文本中的内容
@end
