//
//  _25FlowLayoutVC3.m
//  AXiOSKit_Example
//
//  Created by 小星星吃KFC on 2021/1/6.
//  Copyright © 2021 axinger. All rights reserved.
//

#import "_25FlowLayoutVC3.h"
#import <Masonry/Masonry.h>
#import <AXiOSKit/AXiOSKit.h>
#import "_25CollectionViewCell.h"
#import "_25DataModel.h"
#import "_25Layout.h"

@interface _25FlowLayoutVC3 ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property(nonatomic,strong)UICollectionView *collectionView;

@property(nonatomic, strong) NSMutableArray<_25DataModel *> *dataArray;

@end

@implementation _25FlowLayoutVC3

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"垂直滚动，一个大cell + 两个小cell";
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

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
 
    if([kind isEqualToString:@"Badge"]){
        
        UICollectionReusableView *b = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"custom" forIndexPath:indexPath];
        b.backgroundColor = [UIColor blackColor];
        b.layer.cornerRadius = 10;
        b.layer.masksToBounds = YES;
        return b;
    }
    return nil;
}




- (UICollectionView *)collectionView {
    if (!_collectionView) {
        
        //配置装饰 Anchor 锚
        NSCollectionLayoutAnchor *badgeAnchor = [NSCollectionLayoutAnchor layoutAnchorWithEdges:NSDirectionalRectEdgeTop|NSDirectionalRectEdgeTrailing fractionalOffset:CGPointMake(0.5, -0.5)];//装饰视图中心点等于cell的右上角顶点
        
        ///Anchor 大小
        NSCollectionLayoutSize *badgeSize = [NSCollectionLayoutSize sizeWithWidthDimension:[NSCollectionLayoutDimension absoluteDimension:20] heightDimension:[NSCollectionLayoutDimension absoluteDimension:20]];
        
        NSCollectionLayoutSupplementaryItem *badge = [NSCollectionLayoutSupplementaryItem supplementaryItemWithLayoutSize:badgeSize elementKind:@"Badge" containerAnchor:badgeAnchor];

        
        NSMutableArray<NSCollectionLayoutItem *> *subitems = NSMutableArray.array;
        
        
        {
            //顶部item
            NSCollectionLayoutSize *topItemSize = [NSCollectionLayoutSize sizeWithWidthDimension:[NSCollectionLayoutDimension fractionalWidthDimension:1.0] heightDimension:[NSCollectionLayoutDimension fractionalWidthDimension:9.0/16.0]];
            
            NSCollectionLayoutItem *topItem = [NSCollectionLayoutItem itemWithLayoutSize:topItemSize];
            [subitems addObject:topItem];
            
        }
      
        
        
        {
            
            //底部item
            NSCollectionLayoutSize *bottomItemSize = [NSCollectionLayoutSize sizeWithWidthDimension:[NSCollectionLayoutDimension fractionalWidthDimension:0.5] heightDimension:[NSCollectionLayoutDimension fractionalHeightDimension:1.0]];
            
            NSCollectionLayoutItem *bottomItem = [NSCollectionLayoutItem itemWithLayoutSize:bottomItemSize supplementaryItems:@[badge]];
            
            bottomItem.contentInsets = NSDirectionalEdgeInsetsMake(8, 8, 8, 8);
            
            
            
            //底部group
            NSCollectionLayoutSize *bottomGroupSize = [NSCollectionLayoutSize sizeWithWidthDimension:[NSCollectionLayoutDimension fractionalWidthDimension:1.0] heightDimension:[NSCollectionLayoutDimension fractionalWidthDimension:0.5]];
            
            
        //    NSCollectionLayoutGroup *bottomGroup = [NSCollectionLayoutGroup horizontalGroupWithLayoutSize:bottomGroupSize subitems:@[bottomItem, bottomItem]];//该api放两个相同的item是不起效的
            
            NSCollectionLayoutGroup *bottomGroup = [NSCollectionLayoutGroup horizontalGroupWithLayoutSize:bottomGroupSize subitem:bottomItem count:2];//会在这个分组中放入两个相同的item。并且这里设置了2，即使bottomItemSize width设置比较大，依然会平分
            
            
            [subitems addObject:bottomGroup];
            
        }

     
        
        //组合group 🐂🍺 注意这里的尺寸一点要是组合的大小
        NSCollectionLayoutSize *fullGroupSize = [NSCollectionLayoutSize sizeWithWidthDimension:[NSCollectionLayoutDimension fractionalWidthDimension:1.0] heightDimension:[NSCollectionLayoutDimension fractionalWidthDimension:9.0/16.0 + 0.5]];
        
        NSCollectionLayoutGroup *nestedGroup = [NSCollectionLayoutGroup verticalGroupWithLayoutSize:fullGroupSize subitems:subitems];//NSCollectionLayoutGroup继承自NSCollectionLayoutItem

        
        
        
        //虽然一个section只能指定一个group，但可以group中可以组合item和其他group
        NSCollectionLayoutSection *section = [NSCollectionLayoutSection sectionWithGroup:nestedGroup];
    //    section.orthogonalScrollingBehavior = UICollectionLayoutSectionOrthogonalScrollingBehaviorContinuous;
        
        NSCollectionLayoutSize *headerSize = [NSCollectionLayoutSize sizeWithWidthDimension:[NSCollectionLayoutDimension fractionalWidthDimension:1.0] heightDimension:[NSCollectionLayoutDimension estimatedDimension:44]];
        NSCollectionLayoutBoundarySupplementaryItem *headerItem = [NSCollectionLayoutBoundarySupplementaryItem boundarySupplementaryItemWithLayoutSize:headerSize elementKind:UICollectionElementKindSectionHeader alignment:NSRectAlignmentTop];
    //    headerItem.pinToVisibleBounds = YES;
        
        //配置组头组尾
        NSCollectionLayoutSize *footerSize = [NSCollectionLayoutSize sizeWithWidthDimension:[NSCollectionLayoutDimension fractionalWidthDimension:1.0] heightDimension:[NSCollectionLayoutDimension estimatedDimension:60]];
        NSCollectionLayoutBoundarySupplementaryItem *footerItem = [NSCollectionLayoutBoundarySupplementaryItem boundarySupplementaryItemWithLayoutSize:footerSize elementKind:UICollectionElementKindSectionFooter alignment:NSRectAlignmentBottom];
        
        section.boundarySupplementaryItems = @[headerItem, footerItem];
        
        
        
        UICollectionViewCompositionalLayout *layout = [[UICollectionViewCompositionalLayout alloc]initWithSection:section];

        
        
        _collectionView = [UICollectionView.alloc initWithFrame:CGRectZero collectionViewLayout:layout];
        
        [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:@"Badge" withReuseIdentifier:@"custom"];
        
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
