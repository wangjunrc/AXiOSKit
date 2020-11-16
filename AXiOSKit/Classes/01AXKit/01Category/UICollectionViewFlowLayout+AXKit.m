//
//  UICollectionViewFlowLayout+AXKit.m
//  AXiOSKit
//
//  Created by 小星星吃KFC on 2020/11/16.
//

#import "UICollectionViewFlowLayout+AXKit.h"
@implementation AXFlowLayoutAdapter

@end

@implementation UICollectionViewFlowLayout (AXKit)

-(CGSize)ax_itemWithWidthCount:(CGFloat )colCount height:(CGFloat)height {
    CGRect _rect = CGRectMake(0, 0, self.collectionView.bounds.size.width, self.collectionView.bounds.size.height);
    CGFloat realWi = [self fixSlitWith:_rect colCount:colCount space:0].width;
    return CGSizeMake(realWi, height);
}

//只要itemSize的width的小数点后只有1位且最小为5也就是满足1px=0.5pt这个等式。
- (AXFlowLayoutAdapter *)fixSlitWith:(CGRect)rect colCount:(CGFloat)colCount space:(CGFloat)space {
    //    space = 0;
    CGFloat totalSpace = (colCount - 1) * space;//总共留出的距离
    CGFloat itemWidth = (rect.size.width - totalSpace) / colCount;// 按照真实屏幕算出的cell宽度 （iPhone6 375*667）93.75
    CGFloat fixValue = 1 / [UIScreen mainScreen].scale; //(6为1px=0.5pt,6Plus为3px=1pt)1个点有两个像素
    CGFloat realItemWidth = floor(itemWidth) + fixValue;//取整加fixValue  floor:如果参数是小数，则求最大的整数但不大于本身.
    if (realItemWidth < itemWidth) {// 有可能原cell宽度小数点后一位大于0.5
        realItemWidth += fixValue;
    }
    
    CGFloat realWidth = colCount * realItemWidth + totalSpace;//算出屏幕等分后满足`1px=0.5pt`实际的宽度
    CGFloat pointX = (realWidth - rect.size.width) / 2; //偏移距离
    rect.origin.x = -pointX;//向左偏移
    rect.size.width = realWidth;
    
    AXFlowLayoutAdapter *ad = AXFlowLayoutAdapter.alloc.init;
    ad.rect = rect;
    ad.width = realItemWidth;
    return ad;
    
//    _rect = rect;
    /// UICollectionView 初始化 要调用这个
//    _collectionView = [[UICollectionView alloc] initWithFrame:_rect collectionViewLayout:flowLayout];
//    return realItemWidth;//(rect.size.width - totalSpace) / colCount; //每个cell的真实宽度
}

@end
