//
//  _25FlowLayout1.m
//  AXiOSKit_Example
//
//  Created by 小星星吃KFC on 2021/1/6.
//  Copyright © 2021 axinger. All rights reserved.
//

#import "_25FlowLayoutVC1.h"
#import <Masonry/Masonry.h>
#import <AXiOSKit/AXiOSKit.h>
#import "_25CollectionViewCell.h"
#import "_25DataModel.h"
#import "_25Layout.h"


@interface _25FlowLayoutVC1 ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property(nonatomic,strong)UICollectionView *collectionView;

@property(nonatomic, strong) NSMutableArray<_25DataModel *> *dataArray;

@property (nonatomic, assign) NSInteger currentPage;

@end

@implementation _25FlowLayoutVC1

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"左右间距,内容居中";
    self.view.backgroundColor = UIColor.whiteColor;
    
    [self.dataArray removeAllObjects];
    
    for (NSInteger index=0; index<10; index++) {
        _25DataModel *model = [[_25DataModel alloc]init];
        NSString *uri =[NSString stringWithFormat:@"https://via.placeholder.com/200x200?text=icon%ld",index];
        model.iconUri = [uri ax_toEncoding];
        model.title = [NSString stringWithFormat:@"分区0 = %ld",index];
        [self.dataArray addObject:model];
    }
    
    
    [self.collectionView reloadData];
    
    self.collectionView.backgroundColor = UIColor.redColor;
    [self.collectionView registerClass:_25CollectionViewCell.class forCellWithReuseIdentifier:@"cellID"];
    [self.view addSubview:self.collectionView];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        //        make.edges.mas_equalTo(UIEdgeInsetsZero);
        
        make.top.left.right.mas_equalTo(0);
        make.height.mas_equalTo(200+38*2+20);
    }];
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    _25CollectionViewCell *cell =  [collectionView  dequeueReusableCellWithReuseIdentifier:@"cellID" forIndexPath:indexPath];
    _25DataModel *model =  self.dataArray[indexPath.item];
    cell.model =model;
    
    return cell;
}


//paging by cell | paging with one cell at a time
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout*)self.collectionView.collectionViewLayout;
    CGFloat cellWidth = [UIScreen mainScreen].bounds.size.width - layout.sectionInset.left - layout.sectionInset.right;
    CGFloat cellPadding = layout.minimumLineSpacing;
    self.currentPage = (scrollView.contentOffset.x - cellWidth / 2) / (cellWidth + cellPadding) + 1;
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset
{
    UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout*)self.collectionView.collectionViewLayout;
    CGFloat cellWidth = scrollView.width - layout.sectionInset.left - layout.sectionInset.right;
    CGFloat cellPadding = layout.minimumLineSpacing;
    NSInteger page = (scrollView.contentOffset.x - cellWidth / 2) / (cellWidth + cellPadding) + 1;
    
    if (velocity.x > 0) page++;
    if (velocity.x < 0) page--;
    page = MAX(page, 0);
    
    //!!!!:此处注掉：会导致快速滑动会跨越多个cell
    NSInteger prePage = self.currentPage - 1;
    if(prePage > 0 && page < prePage){
        page = prePage;
    } else if (page > self.currentPage + 1){
        page = self.currentPage + 1;
    }
    
    self.currentPage = page;
    
    CGFloat newOffset = page * (cellWidth + cellPadding);
    targetContentOffset->x = newOffset;
}


/// 代理方法

///1、设置格子的大小

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat width = collectionView.bounds.size.width-38*2;
    
    return  CGSizeMake(width, 200);
}

///2、设置collectionView的四周边距

//- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
//    return UIEdgeInsetsMake(0, 38, 0, 38);
//}

///3、设置最小行间距

//       - (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section;

/// 4、设置最小列间距

//- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
//    return 10;
//}

/// 5、设置段头的尺寸

//       - (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section;

/// 6、设置段尾的尺寸

//      - (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section;



- (UICollectionView *)collectionView {
    if (!_collectionView) {
        
        UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        layout.sectionInset = UIEdgeInsetsMake(0, 38, 0, 38);
        layout.minimumLineSpacing = 10;
//        layout.itemSize = CGSizeMake([UIScreen mainScreen].bounds.size.width - 38 * 2, 200);
        _collectionView = [UICollectionView.alloc initWithFrame:CGRectZero collectionViewLayout:layout];
    }
    return _collectionView;
}


- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

@end
