//
//  NoteCell.h
//  healthyHelper
//
//  Created by snow on 2018/2/3.
//  Copyright © 2018年 snow. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Note;
@interface NoteCell : UITableViewCell
@property (nonatomic,strong)Note *note;
+(NoteCell *)addNoteCellWithTableView:(UITableView *)tableView;
@end
