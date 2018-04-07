//
//  WeekSelector.m
//  healthyHelper
//
//  Created by snow on 2018/2/26.
//  Copyright © 2018年 snow. All rights reserved.
//

#import "WeekSelector.h"
#import "UIButton+FillButton.h"
#import "CollectionViewCell.h"
@interface WeekSelector()<UICollectionViewDelegate,
                         UICollectionViewDataSource,
                         UICollectionViewDelegateFlowLayout>;
@property (nonatomic,strong)UIButton *identifierBt;
@property (nonatomic,strong)NSMutableArray *allWeekArr;
@property (nonatomic,strong)NSMutableArray *singleWeekArr;
@property (nonatomic,strong)NSMutableArray *doubleWeekArr;
@property (nonatomic,strong)NSMutableArray *selecterArr;
@end
static NSString *const identifier = @"weekSelectorCell";
static NSString *const HWeekSelectorHeader = @"HWeekSelectorHeader";
static NSString *const HWeekSelectorFooter = @"HWeekSelectorFooter";
@implementation WeekSelector
-(instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    if (self = [super initWithFrame:frame collectionViewLayout:flowLayout]) {
        self.allWeekArr = [NSMutableArray array];
        self.singleWeekArr = [NSMutableArray array];
        self.doubleWeekArr = [NSMutableArray array];
        self.selecterArr = [NSMutableArray array];
        for (int i = 1; i<=24; i++) {

            if (i%2) {
               [self.singleWeekArr addObject:[NSString stringWithFormat:@"%d",i]];
            }else if(!(i%2)){
                [self.doubleWeekArr addObject:[NSString stringWithFormat:@"%d",i]];
            }
            [self.allWeekArr addObject:[NSString stringWithFormat:@"%d",i]];
            [self.selecterArr addObject:[NSString stringWithFormat:@"%d",i]];
        }
        
        self.delegate = self;
        self.dataSource = self;
        self.bounces = NO;
        [self registerClass:[CollectionViewCell class] forCellWithReuseIdentifier:identifier];
        [self registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:HWeekSelectorHeader];
        [self registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:HWeekSelectorFooter];
    }
    return self;
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.allWeekArr.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    cell.btTitle = self.allWeekArr[indexPath.row];
    cell.selectorBt.tag = indexPath.row+1;
    cell.selectorBt.selected = NO;
    if ([self.selecterArr containsObject:[NSString stringWithFormat:@"%ld",cell.selectorBt.tag]]) {
        cell.selectorBt.selected = YES;
    }
    return cell;
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    return CGSizeMake(self.frame.size.width, (self.frame.size.height-3)/6);
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    return CGSizeMake(self.frame.size.width, (self.frame.size.height-3)/6);
}
-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        UICollectionReusableView *headerV = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:HWeekSelectorHeader forIndexPath:indexPath];
        headerV.backgroundColor = [UIColor whiteColor];
        CGFloat width = (self.frame.size.width-2)/3.0;
        CGFloat height = 50;
        CGFloat dis = 1;
        NSArray * titleArr = @[@"单周",@"双周",@"全周"];
        for (int i = 0; i<3;i++) {
            
            HorizontalButton *bt = [HorizontalButton buttonWithType:UIButtonTypeCustom];
            bt.tag = 100+i;
            if (bt.tag == 102) {
                bt.selected = YES;
                self.identifierBt = bt;
            }else{
                bt.selected = NO;
            }
           
            [bt setImage:[UIImage imageNamed:@"未选中"] forState: UIControlStateNormal];
            [bt setImage:[UIImage imageNamed:@"选中"] forState: UIControlStateSelected];
            bt.titleLabel.textAlignment = NSTextAlignmentCenter;
            bt.frame = CGRectMake(i*width+i*dis, 0, width, height);
            [bt setTitle:titleArr[i] forState:UIControlStateNormal];
            [bt setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [bt addTarget:self action:@selector(chooseWeek:) forControlEvents:UIControlEventTouchUpInside];
            
            [headerV addSubview:bt];
            
            UIView *lineV = [[UIView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(bt.frame), 0, 1, bt.frame.size.height)];
            lineV.backgroundColor = bacColor;
            bt.imageViewFrame = CGRectMake(3, (bt.frame.size.height-30)/2.0, 30,30);
            bt.titleLbFrame = CGRectMake(30+3*2, 0, bt.frame.size.width-bt.imageViewFrame.size.width-3*3, bt.frame.size.height);
            [headerV addSubview:lineV];
            NSLog( @"button 的 frame：  %@",NSStringFromCGRect(lineV.frame));
        }
        UIView *lineVB = [[UIView alloc]initWithFrame:CGRectMake(0,CGRectGetMaxY(headerV.frame)-1,headerV.frame.size.width , 1)];
        lineVB.backgroundColor = bacColor;
        [headerV addSubview:lineVB];
        return headerV;
    }else{
        UICollectionReusableView *footerV = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:HWeekSelectorFooter forIndexPath:indexPath];
        CGFloat width = self.frame.size.width/2.0;
        CGFloat height = 50;
        NSArray * titleArr = @[@"取消",@"确定"];
        for (int i = 0; i<2;i++) {
            UIButton *bt = [UIButton buttonWithType:UIButtonTypeCustom];
            bt.tag = 200+i;
            bt.frame = CGRectMake(i*width, 0, width, height);
            [bt setTitle:titleArr[i] forState:UIControlStateNormal];
            [bt setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [bt addTarget:self action:@selector(chooseResult:) forControlEvents:UIControlEventTouchUpInside];
            UIView *lineV = [[UIView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(bt.frame)-1, 0, 1, bt.frame.size.height)];
            lineV.backgroundColor = bacColor;
            [bt addSubview:lineV];
            [footerV addSubview:bt];
        }
        footerV.backgroundColor = [UIColor grayColor];
        return footerV;
    }
}

#pragma mark - UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(50,50);
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 1.0;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 1.0;
}
#pragma mark - UICollectionViewDelegate
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
//    CollectionViewCell *[cell = [CollectionViewCell ]]
    UIButton *button = [collectionView viewWithTag:indexPath.row+1];
    button.selected = !button.selected;
    NSLog(@"--------------- %@",button.titleLabel.text);
    //如果这个 button 是被选中状态
    if (button.selected) {
        //先判断被选中数组中是否包含这个 button，如果不包含，就将其加入进去
        if (![self.selecterArr containsObject:button.titleLabel.text]) {
            NSLog(@"不包含");
            [self.selecterArr addObject:button.titleLabel.text];
        }
    } else{
        if([self.selecterArr containsObject:button.titleLabel.text]) {
//                NSLog(@"包含");
            [self.selecterArr removeObject:button.titleLabel.text];
        }
    }
    NSLog( @"%@",self.selecterArr);
    int jsC = 0;
    int osC = 0;
    UIButton *selectorBt;
    for (int i = 0; i<self.selecterArr.count; i++) {
        if ([self.selecterArr[i] intValue]%2) {
            NSLog(@"%@",self.selecterArr[i]);
            jsC++;
        }
        else{
            osC++;
        }
    }
    if ((jsC == 12)&&(osC == 0)) {
        selectorBt = [self viewWithTag:100];
        NSLog(@"奇数 %@",self.selecterArr);
    }else if((osC == 12)&&(jsC == 0)){
        selectorBt = [self viewWithTag:101];
        NSLog(@"偶数 %@",self.selecterArr);
    }else if((osC == 12)&&(jsC == 12)){
        selectorBt = [self viewWithTag:102];
    }else{
        selectorBt = nil;
        NSLog(@"一个也么有 %@",self.selecterArr);
    }
    NSLog(@"%@",selectorBt);
    _identifierBt.selected = !_identifierBt.selected;
    selectorBt.selected = !selectorBt.selected;
    _identifierBt = selectorBt;
}
-(void)chooseWeek:(HorizontalButton *)sender{
    _identifierBt.selected = !_identifierBt.selected;
    sender.selected = !sender.selected;
    _identifierBt = sender;
    if (self.identifierBt.tag == 100) {
        self.selecterArr = [self.singleWeekArr mutableCopy];
    }else if(self.identifierBt.tag == 101){
        self.selecterArr = [self.doubleWeekArr mutableCopy];
    }else if(self.identifierBt.tag == 102){
        self.selecterArr = [self.allWeekArr mutableCopy];
    }
    for (int i = 0; i<self.allWeekArr.count; i++) {
        int row = [self.allWeekArr[i] intValue] -1;
        NSIndexPath *indexpath = [NSIndexPath indexPathForRow:row inSection:0];
        [self reloadItemsAtIndexPaths:@[indexpath]];
        
    }
    
    NSLog(@"%ld",sender.tag);
}
-(void)chooseResult:(HorizontalButton *)sender{
    NSLog(@"%ld",sender.tag);
    if (sender.tag == 200) {
        NSLog(@"取消");
    }else{
//        NSLog(@"确定%@",self.selecterArr);
    }
    if (self.weekBlk) {
        self.weekBlk(self.selecterArr);
    }
}
@end
