//
//  NoteController.m
//  healthyHelper
//
//  Created by snow on 2017/12/29.
//  Copyright © 2017年 snow. All rights reserved.
//

#import "NoteBookController.h"
#import "NoteController.h"
#import "NoteBookCell.h"
#import "NoteBook.h"
@interface NoteBookController ()<UITableViewDelegate,UITableViewDataSource,UISearchControllerDelegate,UISearchResultsUpdating,UISearchBarDelegate>
@property (nonatomic,strong)UITableView *noteTable;
@property (nonatomic,strong)UISearchController *searchVc;
@property (nonatomic,strong)UITableView *srTable;
@property (nonatomic,strong)NSMutableArray *noteBookArr;
@property (nonatomic,strong)UIView *tableHeaderView;
@property (nonatomic,strong)NSMutableArray *searchResultArr;//这里必须用 strong，如果是 copy 那么重写 setter 方法时候就会 copy，从而导致变成不可变数组，从而不能移除 object,想保留一份不可变副本的时候用 copy
@end

@implementation NoteBookController
-(NSMutableArray *)noteBookArr{
    if (!_noteBookArr) {
        _noteBookArr = [NSMutableArray array];
        [_noteBookArr addObject:@"笔记本1"];
        [_noteBookArr addObject:@"笔记本2"];
    }
    return _noteBookArr;
}

-(NSMutableArray *)searchResultArr{
    if (!_searchResultArr) {
        _searchResultArr = [NSMutableArray array];
    }
    return _searchResultArr;
}
-(UIView *)tableHeaderView{
    if (!_tableHeaderView) {
        _noteTable.tableHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, screenW, 60)];
        UIView *tableHeaderV = [[UIView alloc]initWithFrame:CGRectMake(0, 0, screenW, 60)];
        UIImageView *notesImgV = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"allNoteBook"]];
        notesImgV.frame = CGRectMake(15, (_noteTable.tableHeaderView.frame.size.height-20)/2.0, 20, 20);
        [tableHeaderV addSubview:notesImgV];
        UILabel *allLable = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(notesImgV.frame)+20, (_noteTable.tableHeaderView.frame.size.height-20)/2.0, 150, 20)];
        allLable.text = @"全部笔记本";
        [tableHeaderV addSubview:allLable];
        _tableHeaderView = tableHeaderV;
        
    }
    return _tableHeaderView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self initSearchTable];
    [self initNoteTable];
}
-(void)addNote{
    UIAlertController *alertVc = [UIAlertController alertControllerWithTitle:@"" message:@"" preferredStyle:UIAlertControllerStyleAlert];
    [alertVc addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"请输入笔记本名";
    }];
    UIAlertAction *cancleActoion = [UIAlertAction actionWithTitle:@"取消" style: UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    UIAlertAction *okActoion = [UIAlertAction actionWithTitle:@"确定" style: UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        UITextField *tf = alertVc.textFields.firstObject;
        [self.noteBookArr insertObject:tf.text atIndex:0];
        [self.noteTable reloadData];
    }];
    
    [alertVc addAction:cancleActoion];
    [alertVc addAction:okActoion];
    [self presentViewController:alertVc animated:YES completion:nil];
    
}
- (void)initSearchTable{
    self.searchVc = [[UISearchController alloc]initWithSearchResultsController:nil];
    self.searchVc.delegate = self;
    self.searchVc.searchResultsUpdater = self;
    self.searchVc.searchBar.delegate = self;
    //隐藏系统默认的灰色蒙版
    self.searchVc.dimsBackgroundDuringPresentation = NO;
    //禁止SearchBar获取焦点后会往上移动消失
    self.searchVc.hidesNavigationBarDuringPresentation = NO;
    self.navigationItem.titleView =self.searchVc.searchBar;
}
- (void)initNoteTable{
    UITableView *noteTable = [[UITableView alloc]initWithFrame:CGRectMake(0, 20+44, self.view.frame.size.width, self.view.frame.size.height-20-44-49) style:UITableViewStylePlain];
    noteTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    noteTable.delegate = self;
    noteTable.dataSource = self;
    self.noteTable = noteTable;
    [self.view addSubview:_noteTable];
    self.noteTable.tableHeaderView = self.tableHeaderView;
}

#pragma mark - UITableViewDatasource
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NoteBookCell *cell = [NoteBookCell addNoteBookCellWithTableView:_noteTable];
    NoteBook *noteBook = [[NoteBook alloc]init];
    if (self.searchVc.active) {
        noteBook.NoteBookName = self.searchResultArr[indexPath.row];
    } else {
        noteBook.NoteBookName = self.noteBookArr[indexPath.row];
    }
    cell.noteBook = noteBook;
        return cell;
    
}

/**在viewWillDisappear中要将UISearchController移除, 否则切换到下一个View中, 搜索框仍然会有短暂的存在
 解决从 搜索结果的 cell push 到下一个页面会出现：已经 push 过来了，但是还会继续划过一个页面
 */
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    if (self.searchVc.active) {
        self.searchVc.active = NO;
        [self.searchVc.searchBar removeFromSuperview];
    }
}
#pragma mark - UITableviewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (self.searchVc.active) {
        return self.searchResultArr.count;
    }
    return self.noteBookArr.count;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 60;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *sectionHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, screenW, 60)];
    sectionHeaderView.backgroundColor = [UIColor whiteColor];
    UILabel *allLable = [[UILabel alloc]initWithFrame:CGRectMake(15, (sectionHeaderView.frame.size.height-20)/2.0, 150, 20)];
    allLable.text = @"笔记本";
    [sectionHeaderView addSubview:allLable];
    UIButton *addButton = [UIButton buttonWithType:UIButtonTypeCustom];
    addButton.frame = CGRectMake(screenW-40, (sectionHeaderView.frame.size.height-30)/2.0, 30, 30);
    [addButton setImage:[UIImage imageNamed:@"add.png"] forState:UIControlStateNormal];
    [addButton addTarget:self action:@selector(addNote) forControlEvents:UIControlEventTouchUpInside];
    [sectionHeaderView addSubview:addButton];
    return sectionHeaderView;
}
#pragma mark - UITableviewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NoteController  *noteVC = [[NoteController alloc ]init];
    if (self.searchVc.active) {
        noteVC.title = self.searchResultArr[indexPath.row];
    }else{
        noteVC.title = self.noteBookArr[indexPath.row];
    }
     [self.navigationController pushViewController:noteVC animated:YES];
}
-(BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.searchVc.active) {
        return NO;
    }
    return YES;
}
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.noteBookArr removeObjectAtIndex:indexPath.row];
    [self.noteTable deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    [self.noteTable reloadData];
}

#pragma mark - UISearchResultsUpdating
-(void)updateSearchResultsForSearchController:(UISearchController *)searchController{
//    self.noteTable.tableHeaderView = nil;
    /*属性必须用 strong，不可用 copy,不然会变成不可变对象*/
    [self.searchResultArr removeAllObjects];
    NSPredicate *searchPredicate = [NSPredicate predicateWithFormat:@"SELF CONTAINS[c] %@", self.searchVc.searchBar.text];
    self.searchResultArr = [[self.noteBookArr filteredArrayUsingPredicate:searchPredicate] mutableCopy];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.noteTable reloadData];
    });
}

#pragma mark - UISearchBarDelegate
-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
//    [self.noteTable setContentOffset:CGPointMake(0, 60) animated:YES];
    NSLog(@"%@",searchText);
    self.noteTable.tableHeaderView = nil;

}
//-(void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar{
//    //这个方法会自动触发 scroller 滚动
////    [self.noteTable setContentOffset:CGPointMake(0, 60) animated:YES];
//    self.noteTable.tableHeaderView = nil;
//}
#pragma mark - UISearchControllerDelegate
//在 SearchVc 失去响应之后显示 tableView 的 tableHeaderView
- (void)didDismissSearchController:(UISearchController *)searchController{
    self.noteTable.tableHeaderView = self.tableHeaderView;
}
@end

