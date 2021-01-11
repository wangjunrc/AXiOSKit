//
//  _25FlowLayoutVC4.m
//  AXiOSKit_Example
//
//  Created by 小星星吃KFC on 2021/1/6.
//  Copyright © 2021 axinger. All rights reserved.
//

#import "_25CompLayoutVC3.h"
#import <Masonry/Masonry.h>
#import <AXiOSKit/AXiOSKit.h>

@interface _25CompLayoutVC3 ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property(nonatomic,strong)UICollectionView *collectionView;

@property (nonatomic, copy) NSArray *sectionTitles;

@end

@implementation _25CompLayoutVC3

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"类似 App Store";
    self.view.backgroundColor = UIColor.whiteColor;
    self.sectionTitles = @[@"强烈推荐", @"热门App", @"大家都在用", @"今天看什么", @"新鲜App", @"给小朋友", @"热门类别", @"生活微记录", @"合影不受限", @"付费App排行", @"免费App排行", @"快速链接"];
    
    
    [self.collectionView reloadData];
    
    self.collectionView.backgroundColor = UIColor.groupTableViewBackgroundColor;
    [self.view addSubview:self.collectionView];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
    
}


- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return self.sectionTitles.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 8;
}


- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell =  [collectionView  dequeueReusableCellWithReuseIdentifier:@"cellID" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor ax_randomColor];
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{

    if([kind isEqualToString:UICollectionElementKindSectionHeader]){
        UICollectionReusableView *h = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"head" forIndexPath:indexPath];
        UILabel *l = [h viewWithTag:1000];
        if(!l){
            l = [UILabel new];
            l.frame = h.bounds;
            l.tag = 1000;
            [h addSubview:l];
        }
        l.text = self.sectionTitles[indexPath.section];
        return h;
    } else {
        return nil;
        
    }
}

- (NSCollectionLayoutSection *)generateSectionForSection:(NSInteger)section
API_AVAILABLE(ios(13.0)){
    
    NSCollectionLayoutGroup *group;
    NSDirectionalEdgeInsets sectionInsets = NSDirectionalEdgeInsetsMake(0, 0, 0, 0);
    
    UICollectionLayoutSectionOrthogonalScrollingBehavior behavior = UICollectionLayoutSectionOrthogonalScrollingBehaviorContinuous;
    switch (section) {
        case 0:
        case 5:
        {
            //顶部banner item
            //效果：paging by cell 看起来cell距离屏幕左右各20像素
            sectionInsets = NSDirectionalEdgeInsetsMake(0, 15, 0, 15);
            /*
            UICollectionLayoutSectionOrthogonalScrollingBehaviorContinuous 正常连续滚动
            UICollectionLayoutSectionOrthogonalScrollingBehaviorPaging 正常分页轮播（页宽等于UICollectionView的宽度)
            UICollectionLayoutSectionOrthogonalScrollingBehaviorContinuousGroupLeadingBoundary 停止滚动时一定会停留在group的边界处
            UICollectionLayoutSectionOrthogonalScrollingBehaviorGroupPaging 按group的尺寸进行分页
            UICollectionLayoutSectionOrthogonalScrollingBehaviorGroupPagingCentered 也是按group的尺寸进行分页，但会沿正交轴增加首尾间距让其居中
             */
            behavior = UICollectionLayoutSectionOrthogonalScrollingBehaviorGroupPaging;//完美的paging by cell效果
            
            CGFloat bannerSize = [UIScreen mainScreen].bounds.size.width - 30;//原本占screenwidth-30
            
            NSCollectionLayoutSize *bannerItemSize = [NSCollectionLayoutSize sizeWithWidthDimension:[NSCollectionLayoutDimension fractionalWidthDimension:1.0] heightDimension:[NSCollectionLayoutDimension fractionalHeightDimension:1.0]];
            NSCollectionLayoutItem *bannerItem = [NSCollectionLayoutItem itemWithLayoutSize:bannerItemSize];
            bannerItem.contentInsets = NSDirectionalEdgeInsetsMake(0, 5, 0, 5);//左右各收缩5像素 占screenwidth-40

            NSCollectionLayoutSize *bannerGroupSize = [NSCollectionLayoutSize sizeWithWidthDimension:[NSCollectionLayoutDimension absoluteDimension:bannerSize] heightDimension:[NSCollectionLayoutDimension absoluteDimension:bannerSize]];
            group = [NSCollectionLayoutGroup horizontalGroupWithLayoutSize:bannerGroupSize subitem:bannerItem count:1];//水平
            break;
        }
        case 1:
        case 2:
        case 4:
        case 7:
        case 9:
        case 10:
        {
            //每列三行的cell样式
            sectionInsets = NSDirectionalEdgeInsetsMake(0, 15, 0, 15);
            behavior = UICollectionLayoutSectionOrthogonalScrollingBehaviorGroupPaging;//完美的paging by cell效果

            CGFloat oneThirdWidth = [UIScreen mainScreen].bounds.size.width - 30;
            CGFloat oneThirdHeight = 80;
            NSCollectionLayoutSize *oneThirdItemSize = [NSCollectionLayoutSize sizeWithWidthDimension:[NSCollectionLayoutDimension fractionalWidthDimension:1.0] heightDimension:[NSCollectionLayoutDimension fractionalHeightDimension:1.0/3.0]];
            NSCollectionLayoutItem *oneThirdItem = [NSCollectionLayoutItem itemWithLayoutSize:oneThirdItemSize];
            oneThirdItem.contentInsets = NSDirectionalEdgeInsetsMake(0, 5, 0, 5);

            NSCollectionLayoutSize *oneThirdGroupSize = [NSCollectionLayoutSize sizeWithWidthDimension:[NSCollectionLayoutDimension absoluteDimension:oneThirdWidth] heightDimension:[NSCollectionLayoutDimension absoluteDimension:oneThirdHeight * 3.0]];
            group = [NSCollectionLayoutGroup verticalGroupWithLayoutSize:oneThirdGroupSize subitem:oneThirdItem count:3];//垂直
            
            break;
        }
        case 3:
        {
            //今天看什么banner
            sectionInsets = NSDirectionalEdgeInsetsMake(0, 15, 0, 15);
            behavior = UICollectionLayoutSectionOrthogonalScrollingBehaviorGroupPaging;//完美的paging by cell效果

            CGFloat bannerWidth = [UIScreen mainScreen].bounds.size.width - 150;
            CGFloat bannerHeight = 180;
            NSCollectionLayoutSize *bannerItemSize = [NSCollectionLayoutSize sizeWithWidthDimension:[NSCollectionLayoutDimension fractionalWidthDimension:1.0] heightDimension:[NSCollectionLayoutDimension fractionalHeightDimension:1.0]];
            NSCollectionLayoutItem *bannerItem = [NSCollectionLayoutItem itemWithLayoutSize:bannerItemSize];
            bannerItem.contentInsets = NSDirectionalEdgeInsetsMake(0, 5, 0, 5);

            NSCollectionLayoutSize *bannerGroupSize = [NSCollectionLayoutSize sizeWithWidthDimension:[NSCollectionLayoutDimension absoluteDimension:bannerWidth] heightDimension:[NSCollectionLayoutDimension absoluteDimension:bannerHeight]];
            group = [NSCollectionLayoutGroup horizontalGroupWithLayoutSize:bannerGroupSize subitem:bannerItem count:1];//水平
            
            break;
        }
        case 6:
        {
            //热门类别
            sectionInsets = NSDirectionalEdgeInsetsMake(0, 20, 0, 20);
//
//            behavior = UICollectionLayoutSectionOrthogonalScrollingBehaviorGroupPaging;//完美的paging by cell效果
//            sectionInsets = NSDirectionalEdgeInsetsMake(0, 0, 0, 0  );
            CGFloat cellWidth = [UIScreen mainScreen].bounds.size.width - 40;
            CGFloat cellHeight = 50;
            
            NSCollectionLayoutSize *itemSize = [NSCollectionLayoutSize sizeWithWidthDimension:[NSCollectionLayoutDimension fractionalWidthDimension:1.0] heightDimension:[NSCollectionLayoutDimension fractionalHeightDimension:1.0]];
            
            
            NSCollectionLayoutItem *item = [NSCollectionLayoutItem itemWithLayoutSize:itemSize];
            
//            item.contentInsets = NSDirectionalEdgeInsetsMake(0, 20, 0, 20);
            
            NSCollectionLayoutSize *groupSize = [NSCollectionLayoutSize sizeWithWidthDimension:[NSCollectionLayoutDimension fractionalWidthDimension:1.0] heightDimension:[NSCollectionLayoutDimension absoluteDimension:cellHeight * 8]];
            
            group = [NSCollectionLayoutGroup verticalGroupWithLayoutSize:groupSize subitem:item count:8];//垂直
            
            
//            group.contentInsets= NSDirectionalEdgeInsetsMake(0, 20, 0, 20);
            break;
        }
        case 8:
        {
            //每列两行的cell样式
            sectionInsets = NSDirectionalEdgeInsetsMake(0, 15, 0, 15);
            behavior = UICollectionLayoutSectionOrthogonalScrollingBehaviorGroupPaging;//完美的paging by cell效果
            
            CGFloat oneSecondWidth = [UIScreen mainScreen].bounds.size.width - 30;
            CGFloat oneSecondHeight = 120;
            NSCollectionLayoutSize *oneSecondItemSize = [NSCollectionLayoutSize sizeWithWidthDimension:[NSCollectionLayoutDimension fractionalWidthDimension:1.0] heightDimension:[NSCollectionLayoutDimension fractionalHeightDimension:1.0/2.0]];
            NSCollectionLayoutItem *oneSecondItem = [NSCollectionLayoutItem itemWithLayoutSize:oneSecondItemSize];
            oneSecondItem.contentInsets = NSDirectionalEdgeInsetsMake(0, 5, 0, 5);

            NSCollectionLayoutSize *oneSecondGroupSize = [NSCollectionLayoutSize sizeWithWidthDimension:[NSCollectionLayoutDimension absoluteDimension:oneSecondWidth] heightDimension:[NSCollectionLayoutDimension absoluteDimension:oneSecondHeight * 2.0]];
            group = [NSCollectionLayoutGroup verticalGroupWithLayoutSize:oneSecondGroupSize subitem:oneSecondItem count:2];//垂直
            break;
        }
        case 11:
        {
            //快速链接
            sectionInsets = NSDirectionalEdgeInsetsMake(0, 20, 0, 20);

            CGFloat cellWidth = [UIScreen mainScreen].bounds.size.width - 40;
            CGFloat cellHeight = 50;
            NSCollectionLayoutSize *itemSize = [NSCollectionLayoutSize sizeWithWidthDimension:[NSCollectionLayoutDimension fractionalWidthDimension:1.0] heightDimension:[NSCollectionLayoutDimension fractionalHeightDimension:1.0]];
            NSCollectionLayoutItem *item = [NSCollectionLayoutItem itemWithLayoutSize:itemSize];
            
            NSCollectionLayoutSize *groupSize = [NSCollectionLayoutSize sizeWithWidthDimension:[NSCollectionLayoutDimension absoluteDimension:cellWidth] heightDimension:[NSCollectionLayoutDimension absoluteDimension:cellHeight * 8]];
            group = [NSCollectionLayoutGroup verticalGroupWithLayoutSize:groupSize subitem:item count:8];//垂直
            break;
            break;
        }
    }
    
    NSCollectionLayoutSection *layoutSection = [NSCollectionLayoutSection sectionWithGroup:group];
    layoutSection.orthogonalScrollingBehavior = behavior;
    layoutSection.contentInsets = sectionInsets;
    
    
    if(section == 0){
        layoutSection.visibleItemsInvalidationHandler = ^(NSArray<id<NSCollectionLayoutVisibleItem>> * _Nonnull visibleItems, CGPoint contentOffset, id<NSCollectionLayoutEnvironment>  _Nonnull layoutEnvironment) {
            //这里可以判断哪个cell滚动到了屏幕中心
        };
    }
    
    //配置组头组尾
    NSCollectionLayoutSize *headerSize = [NSCollectionLayoutSize sizeWithWidthDimension:[NSCollectionLayoutDimension fractionalWidthDimension:1.0] heightDimension:[NSCollectionLayoutDimension estimatedDimension:44]];
    
    
    NSCollectionLayoutBoundarySupplementaryItem *headerItem = [NSCollectionLayoutBoundarySupplementaryItem boundarySupplementaryItemWithLayoutSize:headerSize elementKind:UICollectionElementKindSectionHeader alignment:NSRectAlignmentTop];
    
    layoutSection.boundarySupplementaryItems = @[headerItem];
    
    return layoutSection;
}


- (UICollectionView *)collectionView {
    if (!_collectionView) {
        
        __kindof UICollectionViewLayout *subLayout = nil;
        
        
        if (@available(iOS 13.0, *)) {
           
            UICollectionViewCompositionalLayoutConfiguration *config = [UICollectionViewCompositionalLayoutConfiguration.alloc init];
            
            config.interSectionSpacing = 30;//不同section之间的间距
            
            UICollectionViewCompositionalLayout *layout = [[UICollectionViewCompositionalLayout alloc]initWithSectionProvider:^NSCollectionLayoutSection * _Nullable(NSInteger section, id<NSCollectionLayoutEnvironment> environment) {
                return [self generateSectionForSection:section];
            } configuration:config];
            
            subLayout = layout;
        }else{
            
        }
        
        
        _collectionView = [UICollectionView.alloc initWithFrame:CGRectZero collectionViewLayout:subLayout];
        
        [_collectionView registerClass:UICollectionViewCell.class forCellWithReuseIdentifier:@"cellID"];
        [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:@"Badge" withReuseIdentifier:@"custom"];
        [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"head"];
        [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"foot"];
        
    }
    return _collectionView;
}

@end
