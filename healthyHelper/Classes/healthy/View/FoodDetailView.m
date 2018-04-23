//
//  FoodDetailView.m
//  healthyHelper
//
//  Created by snow on 2018/4/17.
//  Copyright © 2018年 snow. All rights reserved.
//

#import "FoodDetailView.h"
#import <Masonry/Masonry.h>
#import "TXHRrettyRuler.h"
#import "LXRulerControl.h"
#import "Food.h"
#import "FoodData.h"
@interface FoodDetailView()
@property (nonatomic,strong)LXRulerControl *ruler;
@property (nonatomic,strong)UILabel *showLabel;
@property (nonatomic,strong)UIView *btView;
@property (nonatomic,strong)UIButton *cancleBt;
@property (nonatomic,strong)UIButton *okBt;
@property (nonatomic,strong)UIView *lineV;

@property (nonatomic,strong)UIView *foodInfoView;
@property (nonatomic,strong)UIImageView * foodImageV;
@property (nonatomic,strong)UILabel *fooNameLb;
@property (nonatomic,strong)UILabel *foodEmergyLb;
@property (nonatomic,strong)UILabel *showWeightLb;
@end
@implementation FoodDetailView
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setUpFoodInfoView];
        self.backgroundColor = [UIColor whiteColor];
        _showWeightLb = [[UILabel alloc]init];
        _showWeightLb.textAlignment = NSTextAlignmentCenter;
        _showWeightLb.textColor = [UIColor colorWithRed:94/255.0 green:126/255.0 blue:46/255.0 alpha:1.0];
        _showWeightLb.font = [UIFont systemFontOfSize:35];
        [self addSubview:_showWeightLb];
        [self setupRuleView];
        [self setupBottomView];
    }
    return self;
}
-(void)setupTest{
    // 1.创建一个显示的标签
    _showLabel = [[UILabel alloc] init];
    //    _showLabel.font = [UIFont systemFontOfSize:20.f];
    _showLabel.text = [NSString stringWithFormat:@"119千卡%ld克",_ruler.selectedValue];
    _showLabel.numberOfLines = 2;
    _showLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [self addSubview:_showLabel];
}
-(void)setUpFoodInfoView{
    _foodInfoView = [[UIView alloc]init];
    [self addSubview:_foodInfoView];
    
    _foodImageV = [[UIImageView alloc]init];
    _foodImageV.backgroundColor = [UIColor purpleColor];
    _foodImageV.contentMode= UIViewContentModeScaleToFill;
    [_foodInfoView addSubview:_foodImageV];
    
    _fooNameLb = [[UILabel alloc]init];
    [_foodInfoView addSubview:_fooNameLb];
    
    _foodEmergyLb = [[UILabel alloc]init];
    [_foodInfoView addSubview:_foodEmergyLb];
    
}
-(void)setupBottomView{
    UIView *btView = [[UIView alloc]init];
    btView.backgroundColor = [UIColor colorWithRed:94/255.0 green:126/255.0 blue:46/255.0 alpha:1.0];
    [self addSubview:btView];
    _btView = btView;
    
    _lineV = [[UIView alloc]init];
    _lineV.backgroundColor = [UIColor whiteColor];
    [self addSubview:_lineV];
    
    _cancleBt = [UIButton buttonWithType:UIButtonTypeCustom];
    [_cancleBt setTitle:@"取消" forState: UIControlStateNormal];
    [_cancleBt.titleLabel setTextAlignment:NSTextAlignmentCenter];
    _cancleBt.tag = 0;
    [_cancleBt addTarget:self action:@selector(detailAction:) forControlEvents:UIControlEventTouchUpInside];
    [_cancleBt setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_btView addSubview:_cancleBt];
    
    _okBt = [UIButton buttonWithType:UIButtonTypeCustom];
    [_okBt setTitle:@"确定" forState: UIControlStateNormal];
    _okBt.tag = 1;
    [_okBt.titleLabel setTextAlignment:NSTextAlignmentCenter];
    [_okBt addTarget:self action:@selector(detailAction:) forControlEvents:UIControlEventTouchUpInside];
    [_okBt setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_btView addSubview:_okBt];
}
-(void)setFood:(Food *)food{
    _food = food;
    _foodImageV.image = [UIImage imageNamed:food.foodImage];
    _fooNameLb.text = food.foodName;
    _foodEmergyLb.text = [NSString stringWithFormat:@"%d千卡/100克",food.foodEnergy];
}
-(void)setFoodData:(FoodData *)foodData{
    _foodData = foodData;
    _foodImageV.image = [UIImage imageNamed:foodData.foodImage];
    _fooNameLb.text = foodData.foodName;
    _foodEmergyLb.text = [NSString stringWithFormat:@"%d千卡/100克",foodData.eatingEnergy];
    _showWeightLb.text = [NSString stringWithFormat:@"%d",foodData.eatingWeight];
}

-(void)detailAction:(UIButton *)sender{
    if (sender.tag == 0) {
        [self removeFromSuperview];
    }else{
        NSLog(@"保存数据");
        [self removeFromSuperview];
    }
}
-(void)setupRuleView{
    
    _ruler = [[LXRulerControl alloc] init];
    [self addSubview:_ruler];
    _ruler.backgroundColor = [UIColor colorWithWhite:0.93 alpha:1];
    _ruler.midCount=1;//几个大格标记一个刻度
    _ruler.smallCount=10;//一个大格几个小格
    _ruler.minValue = 0;// 最小值
    _ruler.maxValue = 100;// 最大值
    _ruler.valueStep = 10;// 两个标记刻度之间相差大小
    //每个小格格大值计算为:ruler.valueStep÷(ruler.midCount*ruler.smallCount)
    _ruler.selectedValue = 50;// 设置默认值
    [_ruler addTarget:self action:@selector(selectedValueChanged:) forControlEvents:UIControlEventValueChanged];// 添加监听方法
    _showWeightLb.text = [NSString stringWithFormat:@"%ld克",_ruler.selectedValue] ;
    
   
}

- (void)selectedValueChanged:(LXRulerControl *)ruler {
    _showWeightLb.text = [NSString stringWithFormat:@"%ld克",_ruler.selectedValue] ;
     _showLabel.text = [NSString stringWithFormat:@"119千卡%ld克",ruler.selectedValue];
}


-(void)layoutSubviews{
    [super layoutSubviews];
   
    [_foodInfoView makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(0);
        make.height.equalTo(200);
    }];

    [_foodImageV makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(15);
        make.width.equalTo(60);
        make.height.equalTo(60);
        make.top.equalTo(10);

    }];
    [_fooNameLb makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_foodImageV.right).offset(10);
        make.width.equalTo(200);
        make.top.equalTo(_foodImageV.top);
        make.height.equalTo(40);
    }];
    [_foodEmergyLb makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_fooNameLb.bottom);
        make.left.equalTo(_fooNameLb.left);
        make.right.equalTo(_fooNameLb.right);
        make.bottom.equalTo(_foodImageV.bottom);
    }];
    [_btView makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(0);
        make.height.equalTo(40);
    }];
    [_lineV makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_btView.centerX);
        make.height.equalTo(38);
        make.width.equalTo(1);
        make.centerY.equalTo(_btView.centerY);
    }];
    [_cancleBt makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(0);
        make.bottom.equalTo(0);
        make.height.equalTo(40);
        make.right.equalTo(_btView.centerX).offset(-1);
    }];
    [_okBt makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_btView.centerX).offset(1);
        make.bottom.equalTo(0);
        make.height.equalTo(40);
        make.right.equalTo(0);
    }];

    [_ruler makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(0);
        make.right.equalTo(0);
        make.top.equalTo(_foodInfoView.bottom);
        make.bottom.equalTo(_btView.top);
    }];

    [_showLabel makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(200);
        make.height.equalTo(20);
        make.left.equalTo(15);
        make.bottom.equalTo(_ruler.top);
    }];
    [_showWeightLb makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.centerX);
        make.width.equalTo(90);
        make.height.equalTo(50);
        make.bottom.equalTo(_ruler.top);
    }];
}


@end
