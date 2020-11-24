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
@interface _25Layout : UICollectionViewFlowLayout

/** cell height arrays */
@property(nonatomic,strong)NSArray *cellHeightArrays;

/** attributes arrays */
@property(nonatomic,strong)NSMutableArray *attributesArrays;

/** cell array */
@property(nonatomic,strong)NSMutableArray *tempAttributesArrays;

-(instancetype)initWithArrays:(NSArray *)cellHeightArrays;

@end

@implementation _25Layout

-(instancetype)initWithArrays:(NSArray *)cellHeightArrays
{
    if (self = [super init]) {
        
        self.cellHeightArrays = cellHeightArrays;
    }
    
    return self;
}

- (void)invalidateLayout{
    [super invalidateLayout];
    [self setupLayout];
}

- (void)setupLayout{
    //    CGFloat space = 20;
    //    self.sectionInset = UIEdgeInsetsMake(0,space,0,space);//分区间的内边距
    //    //minimumLineSpacing = 0;这个是水平的间距 minimumInteritemSpacing
    //    self.minimumInteritemSpacing = 0;//列间距
    //    self.minimumLineSpacing = 0;//行间距
    //    self.estimatedItemSize = CGSizeMake(ax_screen_width()-space*2, ax_screen_height()-64-10);
    //    self.itemSize = CGSizeMake(ax_screen_width()-space*2, ax_screen_height()-64-10); //item尺寸
    //    self.scrollDirection =UICollectionViewScrollDirectionHorizontal;//滚动方向
    
    
    self.sectionInset = UIEdgeInsetsMake(0,0,0,0);//分区间的内边距
    //minimumLineSpacing = 0;这个是水平的间距 minimumInteritemSpacing
    self.minimumInteritemSpacing = 10;//列间距
    self.minimumLineSpacing = 10;//行间距
    
    NSLog(@"width == %lf",self.collectionView.bounds.size.width);
    NSLog(@"width == %lf",self.collectionView.bounds.size.width/4.0);
    
    //    self.itemSize = CGSizeMake(self.collectionView.bounds.size.width/4.0-40, 50); //item尺寸
    self.scrollDirection =UICollectionViewScrollDirectionVertical;//滚动方向
    /// ios10 api
    self.estimatedItemSize = UICollectionViewFlowLayoutAutomaticSize;
    
    
    
//    self.itemSize = UICollectionViewFlowLayoutAutomaticSize;
//    estimatedItemSize = UICollectionViewFlowLayoutAutomaticSize;
//    self.estimatedItemSize = CGSizeMake(self.collectionView.bounds.size.width, UICollectionViewFlowLayoutAutomaticSize.height);
//    self.itemSize = CGSizeMake(self.collectionView.bounds.size.width, UICollectionViewFlowLayoutAutomaticSize.height);
//    self.itemSize = UICollectionViewFlowLayoutAutomaticSize;
}


@end


@interface _25LayoutViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property(nonatomic,strong)UICollectionView *collectionView;

@end

@implementation _25LayoutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.collectionView];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
    [self.collectionView registerClass:_25CollectionViewCell.class forCellWithReuseIdentifier:@"cellID"];
    self.collectionView.backgroundColor = UIColor.redColor;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return  30;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    _25CollectionViewCell *cell =  [collectionView  dequeueReusableCellWithReuseIdentifier:@"cellID" forIndexPath:indexPath];
    cell.contentView.backgroundColor = UIColor.orangeColor;
    
    return cell;
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        _25Layout *layout = [[_25Layout alloc]initWithArrays:@[@"1",@"2",@"3"]];
        _collectionView = [UICollectionView.alloc initWithFrame:CGRectZero collectionViewLayout:layout];
    }
    return _collectionView;
}

@end
