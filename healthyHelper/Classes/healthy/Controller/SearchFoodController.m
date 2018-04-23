//
//  SearchFoodController.m
//  healthyHelper
//
//  Created by snow on 2018/4/16.
//  Copyright © 2018年 snow. All rights reserved.
//

#import "SearchFoodController.h"
#import "Food.h"
#import "FoodCell.h"
#import "FoodDetailView.h"
#import <Masonry/Masonry.h>
#import "ShowAnimationView.h"
@interface SearchFoodController ()<UIGestureRecognizerDelegate,UITableViewDelegate, UITableViewDataSource, UISearchResultsUpdating>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UISearchController *searchController;
// 数据源数组
@property (nonatomic, strong) NSMutableArray *datas;
// 搜索结果数组
@property (nonatomic, strong) NSMutableArray *results;
@property (nonatomic,strong)UIView *coverView;

@property (nonatomic,strong)FoodDetailView *foodDetailView;

@end

@implementation SearchFoodController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = bacColor;
    // Do any additional setup after loading the view.
    // 创建UISearchController, 这里使用当前控制器来展示结果
    UISearchController *search = [[UISearchController alloc]initWithSearchResultsController:nil];
    // 设置结果更新代理
    search.searchResultsUpdater = self;
    // 因为在当前控制器展示结果, 所以不需要这个透明视图
    search.dimsBackgroundDuringPresentation = NO;
    self.searchController = search;
    // 将searchBar赋值给tableView的tableHeaderView
    self.tableView.tableHeaderView = search.searchBar;
    self.tableView.backgroundColor = bacColor;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.definesPresentationContext = NO;
    
}

- (UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [self.view addSubview:_tableView];
    }
    
    return _tableView;
}

- (NSMutableArray *)datas {
    if (_datas == nil) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"food" ofType:@"plist"];
        _datas = [Food mj_objectArrayWithFile:path];
        
    }
    
    return _datas;
}

- (NSMutableArray *)results {
    if (_results == nil) {
        _results = [NSMutableArray arrayWithCapacity:0];
    }
    
    return _results;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    // 这里通过searchController的active属性来区分展示数据源是哪个
    if (self.searchController.active) {
        
        return self.results.count ;
    }
    
    return self.datas.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    FoodCell *cell = [FoodCell addFoodCellWithTableView:tableView];
    // 这里通过searchController的active属性来区分展示数据源是哪个
    Food *f;
    if (self.searchController.active ) {
        f = [self.results objectAtIndex:indexPath.row];
    } else {
        f = [self.datas objectAtIndex:indexPath.row];
    }
    cell.food = f;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.searchController.searchBar resignFirstResponder];
    Food *f;
    if (self.searchController.active) {
        f = [self.results objectAtIndex:indexPath.row];
        NSLog(@"选择了搜索结果中的%@", [self.results objectAtIndex:indexPath.row]);
    } else {
        f = [self.datas objectAtIndex:indexPath.row];
        NSLog(@"选择了列表中的%@", [self.datas objectAtIndex:indexPath.row]);
    }
    [self popCoverview];
    [UIView animateWithDuration:2 animations:^{
        
        
        _foodDetailView = [[FoodDetailView alloc]init];
        _foodDetailView.backgroundColor = [UIColor whiteColor];
        _foodDetailView.food = f;
        [self.view addSubview:_foodDetailView];
        [_foodDetailView makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(0);
            make.height.equalTo(400);
            make.left.right.equalTo(0);
        }];
    }];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}
#pragma mark - UISearchResultsUpdating
- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    
    NSString *inputStr = searchController.searchBar.text ;
    NSLog(@"---------");
    if (inputStr == nil) {
        self.results = _datas;
        [self.tableView reloadData];
        return;
    }else{
        NSPredicate *bPredicate = [NSPredicate predicateWithFormat:@"SELF.foodName contains[cd] %@",inputStr];
        self.results = [self.datas filteredArrayUsingPredicate:bPredicate];
        NSLog(@" HEARE %@",self.results);
        [self.tableView reloadData]; //整个表格重绘
    }
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
    
    if ([touch.view isDescendantOfView:self.coverView]) {
        [self.foodDetailView removeFromSuperview];
        [self.coverView removeFromSuperview];
        return NO;
    }
    return YES;
}
@end
