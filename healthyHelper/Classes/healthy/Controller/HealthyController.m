//
//  HealthyController.m
//  healthyHelper
//
//  Created by snow on 2017/12/29.
//  Copyright © 2017年 snow. All rights reserved.
//

#import "HealthyController.h"
#import "PlistTool.h"
#import "FoodData.h"
#import "SearchFoodController.h"
#import "FoodDataCell.h"
#import "HKPieChartView.h"
#import<Masonry/Masonry.h>
#import "FoodDetailView.h"
@interface HealthyController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)UITableView *healthyTable;
@property (nonatomic,strong)NSArray *sectionTitles;
@property (nonatomic,strong)NSMutableArray *flagsArr;
@property (nonatomic,strong)NSMutableArray *breakFastArr;
@property (nonatomic,strong)NSMutableArray *lunchArr;
@property (nonatomic,strong)NSMutableArray *dinnerArr;
@property (nonatomic,strong)HKPieChartView *pieChartView;
@property (nonatomic,strong)UILabel *haveEatLb;
@property (nonatomic,strong)UILabel *sportLb;
@property (nonatomic,assign)NSInteger allKll;
@property (nonatomic,assign)NSInteger haveEatKll;
@property (nonatomic,assign)NSInteger sportKll;
@property (nonatomic,strong)FoodDetailView *foodDetailView;
@property (nonatomic,strong)UIView *coverView;

@end

@implementation HealthyController
- (HKPieChartView *)pieChartView {
    if (!_pieChartView) {
        _allKll = 2000;
        _haveEatKll = 1230;
        _sportKll = 100;
        CGFloat width = 150;
        _pieChartView = [[HKPieChartView alloc]initWithFrame:CGRectMake((self.view.frame.size.width - 150)/2, ((screenH-64)/2.0-150)/2.0, 150, 150)];
        _pieChartView.allKll = _allKll;
        _pieChartView.haveEatKll = _haveEatKll;
        _pieChartView.sportKll = _sportKll;
        NSInteger canEatKll = _allKll - _haveEatKll - _sportKll;
        _pieChartView.canEatkll= canEatKll;
        NSLog(@" canEatKll _allKll: %ld  %ld  %lf",canEatKll,_allKll,canEatKll*1.0/_allKll);
        [_pieChartView updatePercent:(1-canEatKll*1.0/_allKll)*100 animation:YES];
        [self.healthyTable.tableHeaderView addSubview:_pieChartView];
    }
    return _pieChartView;
}
-(NSMutableArray *)breakFastArr{
    if (!_breakFastArr) {
        _breakFastArr = [NSMutableArray array];
    }
    return _breakFastArr;
}
-(NSMutableArray*)lunchArr{
    if (!_lunchArr) {
        _lunchArr = [NSMutableArray array];
    }
    return _lunchArr;
}

-(NSMutableArray *)dinnerArr{
    if (!_dinnerArr) {
        _dinnerArr = [NSMutableArray array];
    }
    return _dinnerArr;
}
-(void)initData{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"foodData" ofType:@"plist"];
    NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:path];
    NSLog(@"%@",dic);
    _breakFastArr = [FoodData mj_objectArrayWithKeyValuesArray:dic[@"breakfast"]];
    _lunchArr = [FoodData mj_objectArrayWithKeyValuesArray:dic[@"lunch"]];
    _dinnerArr = [FoodData mj_objectArrayWithKeyValuesArray:dic[@"dinner"]];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.hidesBottomBarWhenPushed = NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.sectionTitles = @[@"早餐",@"午餐",@"晚餐"];
    self.flagsArr = [NSMutableArray arrayWithObjects:@"1",@"1",@"1", nil];
    self.healthyTable = [[UITableView alloc]initWithFrame:CGRectMake(0, 44+20, screenW, screenH-44-20) style:UITableViewStyleGrouped];
    self.healthyTable.delegate = self;
    self.healthyTable.dataSource = self;
    self.healthyTable.sectionHeaderHeight = 0;
    [self.view addSubview:self.healthyTable];
    [self initWithTableHeaderView];
    [self initData];

}
-(void)initWithTableHeaderView{
    UIImageView *tableHeadreV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, screenW, (screenH-64)/2.0)];
    tableHeadreV.image = [UIImage imageNamed:@"healthyBac.jpg"];
//    LoopProgressView *custom = [[LoopProgressView alloc]initWithFrame:CGRectMake((screenW-100)/2.0, 25, 100, 100)];
//    custom.progress = 99;
//    [tableHeadreV addSubview:custom];
    self.healthyTable.tableHeaderView = tableHeadreV;
    [self pieChartView];
    UILabel *limitLabel = [[UILabel alloc]init];
    limitLabel.textColor = [UIColor whiteColor];
    limitLabel.text =@"还可以摄入";
    limitLabel.font = [UIFont systemFontOfSize:12.0];
    limitLabel.textAlignment = NSTextAlignmentCenter;
    [tableHeadreV addSubview:limitLabel];
    
    UILabel *haveEatTipLb = [[UILabel alloc]init];
    haveEatTipLb.text = @"摄入";
    haveEatTipLb.textAlignment = NSTextAlignmentCenter;
    haveEatTipLb.textColor = [UIColor whiteColor];
    [tableHeadreV addSubview:haveEatTipLb];
    
    UILabel *sportTipLb = [[UILabel alloc]init];
    sportTipLb.text = @"运动";
    sportTipLb.textColor = [UIColor whiteColor];
    sportTipLb.textAlignment = NSTextAlignmentCenter;
    [tableHeadreV addSubview:sportTipLb];
    
    _haveEatLb = [[UILabel alloc]init];
    _haveEatLb.text = [NSString stringWithFormat:@"%ld",_haveEatKll];
    _haveEatLb.font = [UIFont systemFontOfSize:14.0];
    _haveEatLb.textColor = [UIColor whiteColor];
    _haveEatLb.textAlignment = NSTextAlignmentCenter;
    [tableHeadreV addSubview:_haveEatLb];
    
    _sportLb = [[UILabel alloc]init];
    _sportLb.text = [NSString stringWithFormat:@"%ld",_sportKll];
    _sportLb.textColor = [UIColor whiteColor];
    _sportLb.font = [UIFont systemFontOfSize:14.0];
    _sportLb.textAlignment = NSTextAlignmentCenter;
    [tableHeadreV addSubview:_sportLb];
    
    [limitLabel makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(tableHeadreV.centerX);
        make.bottom.equalTo(_pieChartView.top);
        make.height.equalTo(20);
    }];
    [haveEatTipLb makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(40);
        make.height.equalTo(20);
        make.centerY.equalTo(tableHeadreV.centerY);
        make.left.equalTo(20);
    }];
    [_haveEatLb makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(40);
        make.height.equalTo(20);
        make.top.equalTo(haveEatTipLb.bottom);
        make.left.equalTo(20);
    }];
    [sportTipLb makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(40);
        make.height.equalTo(20);
        make.centerY.equalTo(tableHeadreV.centerY);
        make.right.equalTo(-20);
    }];
    [_sportLb makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(40);
        make.height.equalTo(20);
        make.top.equalTo(sportTipLb.bottom);
        make.right.equalTo(-20);
    }];
    
    UILabel *TipLb = [[UILabel alloc]init];
    TipLb.text = @"单位：千卡";
    TipLb.textAlignment = NSTextAlignmentCenter;
    TipLb.font = [UIFont systemFontOfSize:12.0];
    TipLb.textColor = [UIColor whiteColor];
    [tableHeadreV addSubview:TipLb];
    
    UILabel *maxKllLb = [[UILabel alloc]init];
//    maxKllLb.font = [UIFont systemFontOfSize:14.0];
    maxKllLb.text = [NSString stringWithFormat:@"最大摄入:%ld",self.allKll];;
    maxKllLb.textAlignment = NSTextAlignmentCenter;
    maxKllLb.textColor = [UIColor whiteColor];
    
    [tableHeadreV addSubview:maxKllLb];
    
    [maxKllLb makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(200);
        make.height.equalTo(20);
        make.top.equalTo(_pieChartView.bottom).offset(10);
        make.centerX.equalTo(tableHeadreV.centerX);
    }];
    [TipLb makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(100);
        make.bottom.equalTo(-10);
        make.top.equalTo(maxKllLb.bottom).offset(3);
        make.centerX.equalTo(tableHeadreV.centerX);
    }];
    
   
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    FoodDataCell *cell = [FoodDataCell addFoodDataCellWithTableView:tableView];
    cell.clipsToBounds = YES;
    FoodData *fd;
    if (indexPath.section == 0) {
        fd = self.breakFastArr[indexPath.row];
    }else if(indexPath.section == 1){
      fd = self.lunchArr[indexPath.row];
    }else{
        fd = self.dinnerArr[indexPath.row];
    }
    cell.fooddata= fd;
    return cell;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.sectionTitles.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (([self.flagsArr[section] intValue])==1)  {
        if (section == 0) {
            return self.breakFastArr.count;
        }else if(section == 1){
            return self.lunchArr.count;
        }else{
            return self.dinnerArr.count;
        }
    }
    return 0;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return healthyCellH;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return healthyCellH;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *sectionHeaderV = [[UIView alloc]initWithFrame:CGRectMake(0, 0, screenW, healthyHeaderCellH)];
    sectionHeaderV.tag = section;
    
    UILabel *sectionTitleLb = [[UILabel alloc]initWithFrame:CGRectMake(10, (healthyHeaderCellH-30)/2.0, 60, 30)];
    sectionTitleLb.text = self.sectionTitles[section];
    [sectionHeaderV addSubview:sectionTitleLb];
//
//    UILabel *totalRL = [[UILabel alloc]initWithFrame:CGRectMake(70, 0, 80, 30)];
//    totalRL.textAlignment = NSTextAlignmentRight;
//    totalRL.text = @"(111千卡)";
//    [sectionHeaderV addSubview:totalRL];
    
    UIButton *addItemBt = [UIButton buttonWithType:UIButtonTypeCustom];
    addItemBt.frame = CGRectMake(screenW-30-10, sectionTitleLb.frame.origin.y, 30, 30);
    addItemBt.tag = section;
    [addItemBt setImage:[UIImage imageNamed:@"add"] forState:UIControlStateNormal];
    [addItemBt addTarget:self action:@selector(addNewItem:) forControlEvents:UIControlEventTouchUpInside];
    [sectionHeaderV addSubview:addItemBt];
    UITapGestureRecognizer *tp = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(sectionClick:)];
    [sectionHeaderV addGestureRecognizer:tp];
    return sectionHeaderV;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    FoodData *f;
    if (indexPath.section == 0) {
        f = self.breakFastArr[indexPath.row];
    }else if(indexPath.section == 1){
        f = self.lunchArr[indexPath.row];
    }else{
        f = self.dinnerArr[indexPath.row];
    }
    self.tabBarController.tabBar.hidden = YES;
    [self popCoverview];
    [UIView animateWithDuration:2 animations:^{
    
    _foodDetailView = [[FoodDetailView alloc]init];
    _foodDetailView.foodData = f;
    [self.view addSubview:_foodDetailView];
    [_foodDetailView makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(49);
        make.height.equalTo(400);
        make.left.right.equalTo(0);
    }];
}];
    
}
-(void)addNewItem:(UIButton *)sender{
    if (sender.tag == 0) {
        
    }else if(sender.tag == 1){
        
    }else if(sender.tag == 2){
        
    }
    SearchFoodController *searchVc = [[SearchFoodController alloc]init];
    searchVc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:searchVc animated:YES];
    
}
-(void)sectionClick:(UITapGestureRecognizer *)tap{
    NSInteger section = tap.view.tag;
    if ([self.flagsArr[section] intValue] == 0) {
        [self.flagsArr replaceObjectAtIndex:section withObject:@"1"];
    }else
        [self.flagsArr replaceObjectAtIndex:section withObject:@"0"];
    NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:section];
    [self.healthyTable reloadSections:indexSet withRowAnimation:UITableViewRowAnimationFade];
//    self.flagsArr[tap.view.tag] = !self.flagsArr[tap.view.tag];
}
- (void)popCoverview{
    
    
    //设置蒙版
    
    self.coverView = [[UIView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    
    self.coverView.backgroundColor = [UIColor blackColor];
    
    self.coverView.alpha =0.6;
    
    //实现弹出方法
    UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(bigMap:)];
    recognizer.delegate = self;
    [self.coverView addGestureRecognizer:recognizer];
    
    [self.view addSubview:self.coverView];
    
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    self.tabBarController.tabBar.hidden = NO;
    if ([touch.view isDescendantOfView:self.coverView]) {
        [self.foodDetailView removeFromSuperview];
        [self.coverView removeFromSuperview];
        return NO;
    }
    return YES;
}
@end
