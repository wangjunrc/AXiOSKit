//
//  AXFullLayout2.m
//  AXiOSKit
//
//  Created by liuweixing on 16/6/20.
//  Copyright © 2016年 liuweixing. All rights reserved.
//

#import "AXFullLayout2.h"
#import "AXiOSKit.h"
@implementation AXFullLayout2
//- (instancetype)init{
//    self = [super init];
//    if (self) {
//        [self setupLay];
//    }
//    return self;
//}
//
//- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder{
//    if (self = [super initWithCoder:aDecoder]) {
////        [self setupLay];
//    }
//    return self;
//}
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
    self.minimumInteritemSpacing = 0;//列间距
    self.minimumLineSpacing = 0;//行间距
    self.itemSize = CGSizeMake(ax_screen_width(), ax_screen_height()-64); //item尺寸
    self.scrollDirection =UICollectionViewScrollDirectionHorizontal;//滚动方向

}


@end
