//
//  _25LayoutViewController.m
//  AXiOSKitExample
//
//  Created by 小星星吃KFC on 2020/10/16.
//  Copyright © 2020 liuweixing. All rights reserved.
//

#import "_25LayoutViewController.h"
#import <Masonry/Masonry.h>
#import <AXiOSKit/AXiOSKit.h>
#import "_25CollectionViewCell.h"
#import "_25DataModel.h"
#import "_25Layout.h"

@interface _25LayoutViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property(nonatomic,strong)UICollectionView *collectionView;

@property(nonatomic, strong) NSMutableArray<_25DataModel *> *dataArray;

@end

@implementation _25LayoutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    UICollectionViewListCell *cell = nil;
    
    
    [self.dataArray removeAllObjects];
    for (NSInteger index=0; index<30; index++) {
        _25DataModel *model = [[_25DataModel alloc]init];
        model.title = [NSString stringWithFormat:@"insex = %ld",index];
        [self.dataArray addObject:model];
    }
    
    [self.collectionView reloadData];
    
    self.collectionView.backgroundColor = UIColor.redColor;
    [self.collectionView registerClass:_25CollectionViewCell.class forCellWithReuseIdentifier:@"cellID"];
    [self.view addSubview:self.collectionView];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
    
//        self.editButtonItem.possibleTitles = [NSSet setWithObjects:@"编辑", @"完成", nil];
    self.editButtonItem.title = @"编辑";
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

//点击编辑按钮
- (void)setEditing:(BOOL)editing
          animated:(BOOL)animated{
    [super setEditing:editing animated:animated];
    
    if (editing) {
        self.editButtonItem.title = @"完成";
    } else {
        self.editButtonItem.title = @"编辑";
    }
    [self.navigationItem setHidesBackButton:editing animated:YES];
    [self.collectionView reloadData];
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return  self.dataArray.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    _25CollectionViewCell *cell =  [collectionView  dequeueReusableCellWithReuseIdentifier:@"cellID" forIndexPath:indexPath];
    _25DataModel *model =  self.dataArray[indexPath.item];
    model.editing = self.isEditing;
    cell.model =model;
    __weak typeof(self) weakSelf = self;
    cell.gestureHandler = ^(UIGestureRecognizer * _Nonnull gesture) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        if (strongSelf.isEditing) {
            [strongSelf handlelongGesture:gesture];
        }
    };
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    _25DataModel *model =  self.dataArray[indexPath.item];
    [self ax_showAlertByTitle:model.title];
}

-(BOOL)collectionView:(UICollectionView *)collectionView canMoveItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return self.isEditing;
    
}
-(void)collectionView:(UICollectionView *)collectionView moveItemAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath{
    if (sourceIndexPath.section == 0) {
        [CATransaction setDisableActions:YES];
        [self.dataArray exchangeObjectAtIndex:sourceIndexPath.item withObjectAtIndex:destinationIndexPath.item];
        NSIndexSet *set = [NSIndexSet indexSetWithIndex:sourceIndexPath.section];
        [collectionView reloadSections:set];
        [CATransaction commit];
    }
}

/**
 *  拖动手势事件
 */
- (void)handlelongGesture:(UIGestureRecognizer *)longGesture {
    
    static NSInteger index = 0;    // 记录section，防止跨section移动
    switch (longGesture.state) {
        case UIGestureRecognizerStateBegan:{
            NSIndexPath *AindexPath = [self.collectionView indexPathForItemAtPoint:[longGesture locationInView:self.collectionView]];
            index = AindexPath.section;
            if(index==0){
                
                [self.collectionView beginInteractiveMovementForItemAtIndexPath:AindexPath];
                
            }
        }
            break;
        case UIGestureRecognizerStateChanged:{
            NSIndexPath *BindexPath = [self.collectionView indexPathForItemAtPoint:[longGesture locationInView:self.collectionView]];
            if (index == BindexPath.section) {
                [self.collectionView updateInteractiveMovementTargetPosition:[longGesture locationInView:self.collectionView]];
            }
            
            break;
        }
            break;
        case UIGestureRecognizerStateEnded:
            // 移动完成关闭cell移动
            [self.collectionView endInteractiveMovement];
            break;
            
        default:
            [self.collectionView endInteractiveMovement];
            break;
    }
}


- (UICollectionView *)collectionView {
    if (!_collectionView) {
        _25Layout *layout = [[_25Layout alloc]initWithArrays:@[@"1",@"2",@"3"]];
        _collectionView = [UICollectionView.alloc initWithFrame:CGRectZero collectionViewLayout:layout];
    }
    return _collectionView;
}

- (NSMutableArray<_25DataModel *> *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}
@end
