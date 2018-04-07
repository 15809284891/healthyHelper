//
//  NoteBookCell.h
//  healthyHelper
//
//  Created by snow on 2018/2/1.
//  Copyright © 2018年 snow. All rights reserved.
//

#import <UIKit/UIKit.h>
@class NoteBook;
@interface NoteBookCell : UITableViewCell
@property (nonatomic,strong)NoteBook *noteBook;
+(NoteBookCell *)addNoteBookCellWithTableView:(UITableView *)tableView;
@end
