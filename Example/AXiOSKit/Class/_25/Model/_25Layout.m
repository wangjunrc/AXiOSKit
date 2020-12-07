//
//  _25Layout.m
//  AXiOSKit_Example
//
//  Created by 小星星吃KFC on 2020/12/7.
//  Copyright © 2020 axinger. All rights reserved.
//

#import "_25Layout.h"

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
//    self.scrollDirection =UICollectionViewScrollDirectionHorizontal;//滚动方向
    /// ios10 api
//    self.estimatedItemSize = UICollectionViewFlowLayoutAutomaticSize;
    
    
    
//    self.itemSize = UICollectionViewFlowLayoutAutomaticSize;
//    estimatedItemSize = UICollectionViewFlowLayoutAutomaticSize;
//    self.estimatedItemSize = CGSizeMake(self.collectionView.bounds.size.width, UICollectionViewFlowLayoutAutomaticSize.height);
    self.itemSize = CGSizeMake(self.collectionView.bounds.size.width*0.5-20, 150);
//    self.itemSize = UICollectionViewFlowLayoutAutomaticSize;
}


@end
