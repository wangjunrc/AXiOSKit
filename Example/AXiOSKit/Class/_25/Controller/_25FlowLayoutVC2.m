//
//  _25FlowLayoutVC2.m
//  AXiOSKit_Example
//
//  Created by 小星星吃KFC on 2021/1/6.
//  Copyright © 2021 axinger. All rights reserved.
//

#import "_25FlowLayoutVC2.h"

#import <Masonry/Masonry.h>
#import <AXiOSKit/AXiOSKit.h>
#import "_25CollectionViewCell.h"
#import "_25DataModel.h"
#import "_25Layout.h"


@interface _25FlowLayoutVC2 ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property(nonatomic,strong)UICollectionView *collectionView;

@property(nonatomic, strong) NSMutableArray<_25DataModel *> *dataArray;

@property (nonatomic, assign) NSInteger currentPage;

@end


@implementation _25FlowLayoutVC2

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"水平滚动，但cell大小交替变换，且cell居中对齐。 ";
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
    
    self.collectionView.backgroundColor = UIColor.groupTableViewBackgroundColor;
    [self.collectionView registerClass:UICollectionViewCell.class forCellWithReuseIdentifier:@"cellID"];
    [self.view addSubview:self.collectionView];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
        //
        //        make.top.left.right.mas_equalTo(0);
        //        make.height.mas_equalTo(200+38*2+20);
    }];
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell =  [collectionView  dequeueReusableCellWithReuseIdentifier:@"cellID" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor colorWithRed:arc4random()%255/255.f green:arc4random()%255/255.f blue:arc4random()%255/255.f alpha:1];
    return cell;
}



- (UICollectionView *)collectionView {
    if (!_collectionView) {
        
        NSMutableArray<NSCollectionLayoutItem*>*subitems = [NSMutableArray array];
        
        
        {
            
            
            NSCollectionLayoutSize *itemSize = [NSCollectionLayoutSize sizeWithWidthDimension:[NSCollectionLayoutDimension fractionalWidthDimension:0.5] heightDimension:[NSCollectionLayoutDimension fractionalHeightDimension:1.0]];
            NSCollectionLayoutItem *item = [NSCollectionLayoutItem itemWithLayoutSize:itemSize];
            
            [subitems addObject:item];
        }
        
        
        {
            
            NSCollectionLayoutSize *itemSize1 = [NSCollectionLayoutSize sizeWithWidthDimension:[NSCollectionLayoutDimension fractionalWidthDimension:0.25*0.5] heightDimension:[NSCollectionLayoutDimension fractionalHeightDimension:1.0]];
            
            NSCollectionLayoutItem *item1 = [NSCollectionLayoutItem itemWithLayoutSize:itemSize1];
            
            
            //        item1.contentInsets = NSDirectionalEdgeInsetsMake(20, 20, 20, 20);//内边距 会改变其size
            //        item1.edgeSpacing = [NSCollectionLayoutEdgeSpacing spacingForLeading:nil top:[NSCollectionLayoutSpacing flexibleSpacing:10] trailing:nil bottom:nil];//外边距，值可能会被优化 【相对于group底部对齐】
            
            /// 和 前面的 有间距,到达居中效果
            item1.edgeSpacing = [NSCollectionLayoutEdgeSpacing spacingForLeading:[NSCollectionLayoutSpacing flexibleSpacing:10] top:nil trailing:[NSCollectionLayoutSpacing flexibleSpacing:10] bottom:nil];//【相对于group居中对齐】
            
            [subitems addObject:item1];
            /// 再加一次
            [subitems addObject:item1];
        }
        
        //一个group可以指定多个item，指定多个，对应的cell会按items的样式依次布局
        
        /// heightDimension:[NSCollectionLayoutDimension fractionalWidthDimension:0.5]  高可以与宽约束
        
        NSCollectionLayoutSize *groupSize = [NSCollectionLayoutSize sizeWithWidthDimension:[NSCollectionLayoutDimension fractionalWidthDimension:1.0] heightDimension:[NSCollectionLayoutDimension fractionalHeightDimension:0.5]];
        
        
        NSCollectionLayoutGroup *group = [NSCollectionLayoutGroup horizontalGroupWithLayoutSize:groupSize subitems:subitems];
        
        
        //interItemSpacing对指定了多个subitems才有效
        // i.e. == 做对齐
        //    group.interItemSpacing = [NSCollectionLayoutSpacing fixedSpacing:10];
        
        // i.e. >= 右对齐
        //        group.interItemSpacing = [NSCollectionLayoutSpacing flexibleSpacing:10];
        
        //一个section只能指定一个group
        NSCollectionLayoutSection *section = [NSCollectionLayoutSection sectionWithGroup:group];
        //    section.contentInsets = NSDirectionalEdgeInsetsFromString(@"{5.0, 5.0, 5.0, 5.0}");
        
        section.contentInsets =  NSDirectionalEdgeInsetsMake(5, 5, 5, 5);
        
        
        //Orthogonal正交 在正交轴上怎么滚动？
        //    section.orthogonalScrollingBehavior = UICollectionLayoutSectionOrthogonalScrollingBehaviorGroupPaging;
        //    section.decorationItems =
        UICollectionViewCompositionalLayoutConfiguration *config = [UICollectionViewCompositionalLayoutConfiguration.alloc init];
        config.scrollDirection = UICollectionViewScrollDirectionHorizontal;//水平滚动
        //    config.interSectionSpacing = 50;
        
        
        //layout只能指定一个section
        UICollectionViewCompositionalLayout *layout = [[UICollectionViewCompositionalLayout alloc]initWithSection:section configuration:config];
        
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
