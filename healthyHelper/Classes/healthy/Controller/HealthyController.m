//
//  HealthyController.m
//  healthyHelper
//
//  Created by snow on 2017/12/29.
//  Copyright © 2017年 snow. All rights reserved.
//

#import "HealthyController.h"

@interface HealthyController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)UITableView *healthyTable;
@property (nonatomic,strong)NSArray *sectionTitles;
@property (nonatomic,strong)NSMutableArray *flagsArr;
@end

@implementation HealthyController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.sectionTitles = @[@"早餐",@"加早餐",@"午餐",@"加午餐",@"晚餐",@"加晚餐",@"运动"];
    self.flagsArr = [NSMutableArray arrayWithObjects:@"1",@"1",@"1",@"1",@"1",@"1",@"1", nil];
    self.healthyTable = [[UITableView alloc]initWithFrame:CGRectMake(0, 44+20, screenW, screenH-44-20) style:UITableViewStyleGrouped];
    self.healthyTable.delegate = self;
    self.healthyTable.dataSource = self;
    self.healthyTable.sectionHeaderHeight = 0;
    [self.view addSubview:self.healthyTable];
    [self initWithTableHeaderView];

}
-(void)initWithTableHeaderView{
    UIView *tableHeadreV = [[UIView alloc]initWithFrame:CGRectMake(0, 0, screenW, 150)];
    tableHeadreV.backgroundColor = [UIColor yellowColor];
    self.healthyTable.tableHeaderView = tableHeadreV;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"healthyCell"];
    cell.clipsToBounds = YES;
    cell.textLabel.text = @"测试";
    return cell;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.sectionTitles.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (([self.flagsArr[section] intValue])==1)  {
        return 3;
    }
    return 0;
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
@end
