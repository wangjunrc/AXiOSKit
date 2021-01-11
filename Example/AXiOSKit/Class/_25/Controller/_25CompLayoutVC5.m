//
//  _25CompLayoutVC5.m
//  AXiOSKit_Example
//
//  Created by 小星星吃KFC on 2021/1/8.
//  Copyright © 2021 axinger. All rights reserved.
//

#import "_25CompLayoutVC5.h"

@interface _25CompLayoutVC5 ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property(nonatomic,strong)UICollectionView *collectionView;

@end

@implementation _25CompLayoutVC5

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"25-5 NSCollectionLayoutGroupCustomItem";
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
            
            NSCollectionLayoutSize *groupSize = [NSCollectionLayoutSize sizeWithWidthDimension:[NSCollectionLayoutDimension fractionalWidthDimension:1.0] heightDimension:[NSCollectionLayoutDimension absoluteDimension:200]];

            CGFloat width = [UIScreen mainScreen].bounds.size.width/3.0;
            CGFloat height = 200/3.0;
            //无法横向滚动
            NSCollectionLayoutGroup *group = [NSCollectionLayoutGroup customGroupWithLayoutSize:groupSize itemProvider:^NSArray<NSCollectionLayoutGroupCustomItem *> * _Nonnull(id<NSCollectionLayoutEnvironment>  _Nonnull layoutEnvironment) {
                //UICollectionView的每个section走一次
                //这里想象空间很大，自己爱咋放咋放
                NSMutableArray *arr = [NSMutableArray arrayWithCapacity:8];
                CGFloat x = 0 , y = 0;
                for(NSInteger i = 0; i < 8; i++){
                    NSCollectionLayoutGroupCustomItem *customItem = [NSCollectionLayoutGroupCustomItem customItemWithFrame:CGRectMake(x, y, width, height) zIndex:1000+i];
                    [arr addObject:customItem];
                    x += width;
                    if(i > 0 && i % 3 == 0){
                        x = 0;
                        y += height;
                    }
                }
                return arr.copy;
            }];
            
            NSCollectionLayoutSection *section = [NSCollectionLayoutSection sectionWithGroup:group];
            
            UICollectionViewCompositionalLayoutConfiguration *config = [UICollectionViewCompositionalLayoutConfiguration new];
            config.interSectionSpacing = 20;//不同section之间的间距
            
            UICollectionViewCompositionalLayout *layout = [[UICollectionViewCompositionalLayout alloc]initWithSection:section configuration:config];

            subLayout = layout;
        }else{
            
        }
        
        
        _collectionView = [UICollectionView.alloc initWithFrame:CGRectZero collectionViewLayout:subLayout];
        
        [_collectionView registerClass:UICollectionViewCell.class forCellWithReuseIdentifier:@"cellID"];
        
        
    }
    return _collectionView;
}

@end
