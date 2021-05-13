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

@property(nonatomic, strong) NSMutableArray<NSMutableArray <_25DataModel *> *> *dataArray;

@property(nonatomic, strong) UILongPressGestureRecognizer *longPress;
@end

@implementation _25LayoutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.dataArray removeAllObjects];
    
    {
        NSMutableArray<_25DataModel *> *temp = [NSMutableArray array];
        for (NSInteger index=0; index<10; index++) {
            _25DataModel *model = [[_25DataModel alloc]init];
            NSString *uri =[NSString stringWithFormat:@"https://via.placeholder.com/200x200?text=icon%ld",index];
            model.iconUri = [uri ax_toEncoding];
            model.title = [NSString stringWithFormat:@"分区0 = %ld",index];
            [temp addObject:model];
        }
        
        [self.dataArray addObject:temp];
    }
    {
        NSMutableArray<_25DataModel *> *temp = [NSMutableArray array];
        for (NSInteger index=0; index<9; index++) {
            _25DataModel *model = [[_25DataModel alloc]init];
            NSString *uri =[NSString stringWithFormat:@"https://via.placeholder.com/200x200?text=icon%ld",index];
            model.iconUri = [uri ax_toEncoding];
            model.title = [NSString stringWithFormat:@"分区1 = %ld",index];
            [temp addObject:model];
        }
        [self.dataArray addObject:temp];
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
    self.longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handlelongGesture:)];
    self.longPress.minimumPressDuration = 0.2f;
    
}

//点击编辑按钮
- (void)setEditing:(BOOL)editing
          animated:(BOOL)animated{
    [super setEditing:editing animated:animated];
    
    if (editing) {
        self.editButtonItem.title = @"完成";
        [self.collectionView addGestureRecognizer: self.longPress];
    } else {
        self.editButtonItem.title = @"编辑";
        [self.collectionView removeGestureRecognizer:self.longPress];
    }
    [self.navigationItem setHidesBackButton:editing animated:YES];
    [self.collectionView reloadData];
}

-(NSInteger )numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.dataArray.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataArray[section].count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    _25CollectionViewCell *cell =  [collectionView  dequeueReusableCellWithReuseIdentifier:@"cellID" forIndexPath:indexPath];
    _25DataModel *model =  self.dataArray[indexPath.section][indexPath.item];
    model.editing = (indexPath.section ==0) && self.isEditing;
    cell.model =model;
    __weak typeof(self) weakSelf = self;
    cell.btnHandler = ^(UIButton * _Nonnull addBtn) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        [strongSelf ax_showAlertByTitle:[NSString stringWithFormat:@"按钮 %@",model.title]];
    };
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    _25DataModel *model =  self.dataArray[indexPath.section][indexPath.item];
    [self ax_showAlertByTitle:model.title];
}

-(BOOL)collectionView:(UICollectionView *)collectionView canMoveItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return (indexPath.section ==0) &&self.isEditing;
    
}

-(void)collectionView:(UICollectionView *)collectionView moveItemAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath{
    NSLog(@"sourceIndexPath.section = %ld,destinationIndexPath.section = %ld",sourceIndexPath.section,destinationIndexPath.section );
    
    if (sourceIndexPath.section == 0 && destinationIndexPath.section == 0) {
        [CATransaction setDisableActions:YES];
        
        [self.dataArray[sourceIndexPath.section] exchangeObjectAtIndex:sourceIndexPath.item withObjectAtIndex:destinationIndexPath.item];
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
                NSLog(@"AindexPath.sectio = %ld",AindexPath.section);
                [self.collectionView beginInteractiveMovementForItemAtIndexPath:AindexPath];
                
            }
            
        }
            break;
        case UIGestureRecognizerStateChanged:{
            
            
            NSIndexPath *BindexPath = [self.collectionView indexPathForItemAtPoint:[longGesture locationInView:self.collectionView]];
            
            if (index == BindexPath.section && BindexPath.section ==0) {
                NSLog(@"BindexPath.sectio = %ld",BindexPath.section);
                [self.collectionView updateInteractiveMovementTargetPosition:[longGesture locationInView:self.collectionView]];
            }else{
                [self.collectionView cancelInteractiveMovement];
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

- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

@end
