//
//  NoteCell.m
//  healthyHelper
//
//  Created by snow on 2018/2/3.
//  Copyright © 2018年 snow. All rights reserved.
//

#import "NoteCell.h"
#import "Note.h"
@interface NoteCell()
@property (nonatomic,strong) UILabel *noteTitleLb;
@end
static NSString *identity = @"noteCell";
@implementation NoteCell

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
        self.contentView.backgroundColor = bacColor;
        UIImageView *bac_imgV = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"background_main"]];
        bac_imgV.userInteractionEnabled = YES;
        bac_imgV.frame = CGRectMake(5,2 , (screenW-10), (self.contentView.frame.size.height-4));
        [self.contentView addSubview:bac_imgV];
        
        UILabel *noteTilteLb = [[UILabel alloc]initWithFrame:CGRectMake(5, 0 , bac_imgV.frame.size.width-5, bac_imgV.frame.size.height)];
        [bac_imgV addSubview:noteTilteLb];
        _noteTitleLb = noteTilteLb;
    }
    return self;
}
+(NoteCell *)addNoteCellWithTableView:(UITableView *)tableView{
    NoteCell *cell = [tableView dequeueReusableCellWithIdentifier:identity];
    if (cell == nil) {
        cell = [[NoteCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identity];
    }
    return cell;
}
-(void)setNote:(Note *)note{
    _note = note;
    _noteTitleLb.text = note.NoteName;
}
@end
