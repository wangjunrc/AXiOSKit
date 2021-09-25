//
//  UICollectionViewFlowLayout+AXKit.h
//  AXiOSKit
//
//  Created by 小星星吃KFC on 2020/11/16.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AXFlowLayoutAdapter : NSObject
 
@property(nonatomic, assign) CGFloat width;

/// CollectionView 初始化赋值
@property(nonatomic, assign) CGRect rect;

@end


@interface UICollectionViewFlowLayout (AXKit)
 
-(CGSize)ax_itemWithWidthCount:(CGFloat )colCount height:(CGFloat)height;

//只要itemSize的width的小数点后只有1位且最小为5也就是满足1px=0.5pt这个等式。
- (AXFlowLayoutAdapter *)fixSlitWith:(CGRect)rect colCount:(CGFloat)colCount space:(CGFloat)space;

@end

NS_ASSUME_NONNULL_END
