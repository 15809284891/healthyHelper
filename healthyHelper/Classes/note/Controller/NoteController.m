//
//  NoteController.m
//  healthyHelper
//
//  Created by snow on 2017/12/29.
//  Copyright © 2017年 snow. All rights reserved.
//

#import "NoteController.h"
#import "NoteDetailController.h"
#import "NoteCell.h"
#import "AddNoteView.h"
#import "Note.h"
@interface NoteController()<UITableViewDelegate,UIImagePickerControllerDelegate,UISearchControllerDelegate,UISearchBarDelegate>
@property (nonatomic,copy)NSMutableArray *noteArr;
@property (nonatomic,strong)UISearchController *searchVc;
@property (nonatomic,strong)NSMutableArray *searchResultArr;
@property (nonatomic,assign)NSInteger type;
@end
@implementation NoteController

-(NSMutableArray *)noteArr{
    if (!_noteArr) {
        _noteArr = [NSMutableArray array];
        [_noteArr addObject:@"笔记1"];
        [_noteArr addObject:@"笔记2"];
    }
    return _noteArr;
}
-(NSMutableArray *)searchResultArr{
    if (!_searchResultArr) {
        _searchResultArr = [NSMutableArray array];
    }
    return _searchResultArr;
}
-(void)viewDidLoad{
    [super viewDidLoad];
    [self initRightBarItem];
    [self initTableV];
    [self initSearchVC];
}
-(void)initTableV{
    self.tableView.frame = CGRectMake(0, 44+20, screenW, screenH-20-44-49);
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = bacColor;
    self.tableView.tableHeaderView.frame = CGRectMake(0, 0, screenW, 70);
}
-(void)initSearchVC{
    self.searchVc = [[UISearchController alloc]initWithSearchResultsController:nil];
    //禁止SearchBar获取焦点后会往上移动消失
    self.searchVc.hidesNavigationBarDuringPresentation = NO;
    self.searchVc.delegate = self;
    self.searchVc.searchBar.delegate = self;
    self.searchVc.searchBar.placeholder = [NSString stringWithFormat:@"在%@搜索",self.title];
    self.tableView.tableHeaderView = self.searchVc.searchBar;
}
- (void)initRightBarItem{
    UIButton *addButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [addButton setImage:[UIImage imageNamed:@"add.png"] forState:UIControlStateNormal];
    [addButton addTarget:self action:@selector(addNote) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:addButton];
}
-(void)addNote{
    NoteDetailController *noteDetailVc = [[NoteDetailController alloc]init];
    self.hidesBottomBarWhenPushed= YES;
    [self.navigationController pushViewController:noteDetailVc animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self setHidesBottomBarWhenPushed:NO];
    if (self.searchVc.active) {
        self.searchVc.active = NO;
        [self.searchVc.searchBar removeFromSuperview];
    }
}
#pragma mark - UITableViewDataSource
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (self.searchVc.active) {
        return self.searchResultArr.count;
    }
    return self.noteArr.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NoteCell  *cell = [NoteCell addNoteCellWithTableView:tableView];
    Note *note = [[Note alloc]init];
    if (self.searchVc.active) {
        note.NoteName = self.searchResultArr[indexPath.row];
    }else{
        note.NoteName = _noteArr[indexPath.row];
    }
    cell.note = note;
    return cell;
}
#pragma mark - UITableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    Note *note = [[Note alloc]init];
    if (self.searchVc.active) {
        note.NoteName = self.searchResultArr[indexPath.row];
    }else{
        note.NoteName = _noteArr[indexPath.row];
    }
    NoteDetailController *noteDetailVc = [[NoteDetailController alloc] init];
    noteDetailVc.note = note;
    self.hidesBottomBarWhenPushed= YES;
    [self.navigationController pushViewController:noteDetailVc animated:YES];
}
-(BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.noteArr removeObjectAtIndex:indexPath.row];
    [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    [self.tableView reloadData];
}
-(void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar{
    self.searchVc.dimsBackgroundDuringPresentation = YES;
}
-(void)searchBarTextDidEndEditing:(UISearchBar *)searchBar{
    [self.searchResultArr removeAllObjects];
    NSPredicate *searchPredicate = [NSPredicate predicateWithFormat:@"SELF CONTAINS[c] %@", self.searchVc.searchBar.text];
    self.searchResultArr = [[self.noteArr filteredArrayUsingPredicate:searchPredicate] mutableCopy];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tableView reloadData];
    });
}

@end
