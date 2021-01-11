//
//  _25FlowLayoutVC5.m
//  AXiOSKit_Example
//
//  Created by 小星星吃KFC on 2021/1/6.
//  Copyright © 2021 axinger. All rights reserved.
//

#import "_25CompLayoutVC4.h"
@interface MyDecorateView : UICollectionReusableView

@end

@implementation MyDecorateView

- (instancetype)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame]){
        self.layer.cornerRadius = 10;
        self.layer.masksToBounds = YES;
        self.backgroundColor = [UIColor redColor];
        self.layer.borderWidth = 2;
        self.layer.borderColor = [UIColor lightGrayColor].CGColor;
    }
    return self;
}

@end

@interface _25CompLayoutVC4 ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property(nonatomic,strong)UICollectionView *collectionView;

@end

@implementation _25CompLayoutVC4

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"section 背景色";
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

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return  2;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 8;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell =  [collectionView  dequeueReusableCellWithReuseIdentifier:@"cellID" forIndexPath:indexPath];
    
    cell.contentView.backgroundColor = [UIColor ax_randomColor];
    return cell;
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        
        __kindof UICollectionViewLayout *subLayout = nil;
        
        
        if (@available(iOS 13.0, *)) {
          
            NSCollectionLayoutSize *itemSize = [NSCollectionLayoutSize sizeWithWidthDimension:[NSCollectionLayoutDimension fractionalWidthDimension:1.0] heightDimension:[NSCollectionLayoutDimension fractionalHeightDimension:1.0]];
            NSCollectionLayoutItem *item = [NSCollectionLayoutItem itemWithLayoutSize:itemSize];
            
            NSCollectionLayoutSize *groupSize = [NSCollectionLayoutSize sizeWithWidthDimension:[NSCollectionLayoutDimension fractionalWidthDimension:1.0] heightDimension:[NSCollectionLayoutDimension absoluteDimension:44]];
            NSCollectionLayoutGroup *group = [NSCollectionLayoutGroup verticalGroupWithLayoutSize:groupSize subitems:@[item]];
            
            NSCollectionLayoutSection *section = [NSCollectionLayoutSection sectionWithGroup:group];
            section.contentInsets = NSDirectionalEdgeInsetsMake(20, 20, 20, 20);
            
            //group加装饰背景
            /*
             1.创建NSCollectionLayoutDecorationItem 它是NSCollectionLayoutItem的子类，不能指定layoutSize。
             2.给NSCollectionLayoutSection的decorationItems赋值。
             3.在UICollectionViewCompositionalLayout上面注册decorationView，在这里注册的类实现样式的自定义。
             注意不是在collectionview上注册SupplementaryView
             */
            NSCollectionLayoutDecorationItem *backItem = [NSCollectionLayoutDecorationItem backgroundDecorationItemWithElementKind:@"background"];
            backItem.contentInsets = NSDirectionalEdgeInsetsMake(10, 10, 10, 10);
            section.decorationItems = @[backItem];
            
            UICollectionViewCompositionalLayoutConfiguration *config = [UICollectionViewCompositionalLayoutConfiguration new];
            config.interSectionSpacing = 20;//不同section之间的间距
            
            UICollectionViewCompositionalLayout *layout = [[UICollectionViewCompositionalLayout alloc]initWithSection:section configuration:config];
            [layout registerClass:[MyDecorateView class] forDecorationViewOfKind:@"background"];
            
            subLayout = layout;
        }else{
            
        }
        
        
        _collectionView = [UICollectionView.alloc initWithFrame:CGRectZero collectionViewLayout:subLayout];
        
        [_collectionView registerClass:UICollectionViewCell.class forCellWithReuseIdentifier:@"cellID"];
        
        
    }
    return _collectionView;
}

@end

