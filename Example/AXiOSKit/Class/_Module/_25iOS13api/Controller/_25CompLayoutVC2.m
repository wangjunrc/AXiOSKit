//
//  _25FlowLayoutVC3.m
//  AXiOSKit_Example
//
//  Created by 小星星吃KFC on 2021/1/6.
//  Copyright © 2021 axinger. All rights reserved.
//

#import "_25CompLayoutVC2.h"
#import <Masonry/Masonry.h>
#import <AXiOSKit/AXiOSKit.h>
#import "_25CompLayoutCell.h"

@interface _25CompLayoutVC2 ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property(nonatomic,strong)UICollectionView *collectionView;

@end

@implementation _25CompLayoutVC2

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"25-2 垂直滚动，一个大cell + 两个小cell 交替";
    self.view.backgroundColor = UIColor.whiteColor;
    
    
    [self.collectionView reloadData];
    
    self.collectionView.backgroundColor = UIColor.groupTableViewBackgroundColor;
  
     
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
    return 8;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    _25CompLayoutCell *cell =  [collectionView  dequeueReusableCellWithReuseIdentifier:@"cellID" forIndexPath:indexPath];
    
    cell.contentView.backgroundColor = [UIColor ax_randomColor];
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{

    if([kind isEqualToString:UICollectionElementKindSectionHeader]){
        UICollectionReusableView *h = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"head" forIndexPath:indexPath];
        h.backgroundColor = UIColor.redColor;
        return h;
    } else if([kind isEqualToString:UICollectionElementKindSectionFooter]){
        UICollectionReusableView *f = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"foot" forIndexPath:indexPath];
        f.backgroundColor = UIColor.greenColor;
        return f;
    } else if([kind isEqualToString:@"Badge"]){

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
        
        __kindof UICollectionViewLayout *subLayout = nil;
        
        
        if (@available(iOS 13.0, *)) {
            
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
                
                // 二区,两个水平排布
                NSCollectionLayoutSize *bottomItemSize = [NSCollectionLayoutSize sizeWithWidthDimension:[NSCollectionLayoutDimension fractionalWidthDimension:0.5] heightDimension:[NSCollectionLayoutDimension fractionalHeightDimension:1.0]];
                
                NSCollectionLayoutItem *bottomItem = [NSCollectionLayoutItem itemWithLayoutSize:bottomItemSize supplementaryItems:@[badge]];
                
                
                /// 和 前面的 有间距,到达居中效果
//                bottomItem.edgeSpacing = [NSCollectionLayoutEdgeSpacing spacingForLeading:nil top:nil trailing:[NSCollectionLayoutSpacing fixedSpacing:10] bottom:nil];//【相对于group居中对齐】
                
//                bottomItem.contentInsets = NSDirectionalEdgeInsetsMake(8, 0, 8, 0);
                
//                bottomItem.contentInsets = NSDirectionalEdgeInsetsMake(0, 0, 0, 10);
                
                //底部group
                NSCollectionLayoutSize *bottomGroupSize = [NSCollectionLayoutSize sizeWithWidthDimension:[NSCollectionLayoutDimension fractionalWidthDimension:1.0] heightDimension:[NSCollectionLayoutDimension fractionalWidthDimension:0.5]];
                
                
            //    NSCollectionLayoutGroup *bottomGroup = [NSCollectionLayoutGroup horizontalGroupWithLayoutSize:bottomGroupSize subitems:@[bottomItem, bottomItem]];//该api放两个相同的item是不起效的
                
                NSCollectionLayoutGroup *bottomGroup = [NSCollectionLayoutGroup horizontalGroupWithLayoutSize:bottomGroupSize subitem:bottomItem count:2];//会在这个分组中放入两个相同的item。并且这里设置了2，即使bottomItemSize width设置比较大，依然会平分
                
                bottomGroup.contentInsets = NSDirectionalEdgeInsetsMake(8, 0, 8, 0);
                
                
                [subitems addObject:bottomGroup];
                
            }
            
            /// 上下 组合一个group
            NSCollectionLayoutSize *groupSize = [NSCollectionLayoutSize sizeWithWidthDimension:[NSCollectionLayoutDimension fractionalWidthDimension:1.0] heightDimension:[NSCollectionLayoutDimension fractionalWidthDimension:9.0/16.0 + 0.5]];
            
            NSCollectionLayoutGroup *group = [NSCollectionLayoutGroup verticalGroupWithLayoutSize:groupSize subitems:subitems];//NSCollectionLayoutGroup继承自NSCollectionLayoutItem
//            group.contentInsets = NSDirectionalEdgeInsetsMake(0, 20, 0, 20);
            
            //虽然一个section只能指定一个group，但可以group中可以组合item和其他group
            NSCollectionLayoutSection *section = [NSCollectionLayoutSection sectionWithGroup:group];
            /// section 内容间距 包含 头 和 group 
            section.contentInsets = NSDirectionalEdgeInsetsMake(0, 20, 0, 20);
            
            section.orthogonalScrollingBehavior = UICollectionLayoutSectionOrthogonalScrollingBehaviorNone;
            
            
        //    section.orthogonalScrollingBehavior = UICollectionLayoutSectionOrthogonalScrollingBehaviorContinuous;
            {
                
                
                //配置组头组
                NSCollectionLayoutSize *headerSize = [NSCollectionLayoutSize sizeWithWidthDimension:[NSCollectionLayoutDimension fractionalWidthDimension:1.0] heightDimension:[NSCollectionLayoutDimension estimatedDimension:44]];
                NSCollectionLayoutBoundarySupplementaryItem *headerItem = [NSCollectionLayoutBoundarySupplementaryItem boundarySupplementaryItemWithLayoutSize:headerSize elementKind:UICollectionElementKindSectionHeader alignment:NSRectAlignmentTop];
            //    headerItem.pinToVisibleBounds = YES;
                
                //配置组头组尾
                NSCollectionLayoutSize *footerSize = [NSCollectionLayoutSize sizeWithWidthDimension:[NSCollectionLayoutDimension fractionalWidthDimension:1.0] heightDimension:[NSCollectionLayoutDimension estimatedDimension:60]];
                
                NSCollectionLayoutBoundarySupplementaryItem *footerItem = [NSCollectionLayoutBoundarySupplementaryItem boundarySupplementaryItemWithLayoutSize:footerSize elementKind:UICollectionElementKindSectionFooter alignment:NSRectAlignmentBottom];
                
                section.boundarySupplementaryItems = @[headerItem, footerItem];
            }
            
            UICollectionViewCompositionalLayoutConfiguration *config = [UICollectionViewCompositionalLayoutConfiguration.alloc init];
            config.scrollDirection = UICollectionViewScrollDirectionVertical;
            
            UICollectionViewCompositionalLayout *layout = [[UICollectionViewCompositionalLayout alloc]initWithSection:section configuration:config];

            subLayout = layout;
        }else{
            
        }
        
        
        _collectionView = [UICollectionView.alloc initWithFrame:CGRectZero collectionViewLayout:subLayout];
        
        [_collectionView registerClass:_25CompLayoutCell.class forCellWithReuseIdentifier:@"cellID"];
        [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:@"Badge" withReuseIdentifier:@"custom"];
        [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"head"];
        [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"foot"];
        
    }
    return _collectionView;
}

@end
