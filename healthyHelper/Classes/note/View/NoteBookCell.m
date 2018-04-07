//
//  NoteBookCell.m
//  healthyHelper
//
//  Created by snow on 2018/2/1.
//  Copyright © 2018年 snow. All rights reserved.
//

#import "NoteBookCell.h"
#import "NoteBook.h"
static NSString *identity = @"noteBookCell";
@interface NoteBookCell()
@property (nonatomic,strong)UILabel *noteBookTitleLb;
@end
@implementation NoteBookCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        UIImageView *imgV = [[UIImageView alloc] initWithFrame:CGRectMake(15, (60-20)/2.0, 20, 20)];
        imgV.image = [UIImage imageNamed:@"noteBook"];
        [self.contentView addSubview:imgV];
        UILabel *noteBookTitleLb = [[UILabel alloc]initWithFrame: CGRectMake(CGRectGetMaxX(imgV.frame)+20, imgV.frame.origin.y, 100, 20)];
        [self.contentView addSubview:noteBookTitleLb];
        _noteBookTitleLb = noteBookTitleLb;
        UIView *lineV = [[UIView alloc]initWithFrame:CGRectMake(10, 59, screenW-10, 1)];
        lineV.backgroundColor = bacColor;
        [self.contentView addSubview:lineV];
        
    }
    return self;
}
+(NoteBookCell *)addNoteBookCellWithTableView:(UITableView *)tableView{
    NoteBookCell *cell = [tableView dequeueReusableCellWithIdentifier:identity];
    if (!cell) {
        cell = [[NoteBookCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identity];
    }
    return cell;
}
-(void)setNoteBook:(NoteBook *)noteBook{
    _noteBook = noteBook;
    self.noteBookTitleLb.text = noteBook.NoteBookName;
}
@end
