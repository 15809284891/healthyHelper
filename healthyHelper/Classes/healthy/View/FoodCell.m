//
//  FoodCell.m
//  healthyHelper
//
//  Created by snow on 2018/4/16.
//  Copyright © 2018年 snow. All rights reserved.
//

#import "FoodCell.h"
#import "Food.h"
#import <Masonry/Masonry.h>
@interface FoodCell()
@property (nonatomic,strong) UIImageView *foodImageV;
@property (nonatomic,strong) UILabel *foodNameLb;
@property (nonatomic,strong)UILabel *kllLb;
@property (nonatomic,strong) UIView *lineV;
@end
static NSString *identifier = @"foodCell";
@implementation FoodCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        _foodImageV = [[UIImageView alloc]init];
        [self.contentView addSubview:_foodImageV];
        
        _foodNameLb = [[UILabel alloc]init];
        _foodNameLb.font = [UIFont systemFontOfSize:16.0];
        [self.contentView addSubview:_foodNameLb];
        
        _kllLb = [[UILabel alloc]init];
        _kllLb.font = [UIFont systemFontOfSize:12.0];
        _kllLb.textColor = [UIColor colorWithRed:64/255.0 green:64/255.0 blue:64/255.0 alpha:1.0];
        [self.contentView addSubview:_kllLb];
        
        UIView *lineV = [[UIView alloc]init];
        lineV.backgroundColor = bacColor;
        [self.contentView addSubview:lineV];
        _lineV = lineV;
    }
    return self;
}

-(void)setFood:(Food *)food{
    _foodImageV.image = [UIImage imageNamed:food.foodImage];
    _foodNameLb.text = food.foodName;
    _kllLb.text = [NSString stringWithFormat:@"卡路里%d/100克",food.foodEnergy];
    
}

+(FoodCell *)addFoodCellWithTableView:(UITableView *)tableView{
    FoodCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[FoodCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    return cell;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    [self.foodImageV makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(15);
        make.top.equalTo(10);
        make.bottom.equalTo(-10);
        make.width.equalTo(40);
    }];
    [self.foodNameLb makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.foodImageV.right).offset(5);
        make.width.equalTo(80);
        make.top.equalTo(15);
        make.height.equalTo(30);
    }];
    [self.kllLb makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.foodNameLb.left);
        make.width.equalTo(200);
        make.top.equalTo(self.foodNameLb.bottom);
        make.bottom.equalTo(-10);
    }];
    [_lineV makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(1);
        make.left.equalTo(15);
        make.right.equalTo(0);
        make.bottom.equalTo(0);
    }];
}
@end
