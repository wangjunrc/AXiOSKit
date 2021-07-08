//
//  AXKitEnum.h
//  Pods
//
//  Created by 小星星吃KFC on 2021/7/8.
//

#ifndef AXKitEnum_h
#define AXKitEnum_h

/**
 边框方向
 */
typedef NS_ENUM(NSInteger, AXBorderDirectionType) {
    AXBorderDirectionTop = 0,//顶部
    AXBorderDirectionLeft,//左边
    AXBorderDirectionBottom,//底部
    AXBorderDirectionRight,//右边
};

/**
 button 图片位置
 */
typedef NS_ENUM(NSInteger, AXButtonImagePosition) {
    AXButtonImagePositionLeft = 0,  // 图片在左，文字在右，默认
    AXButtonImagePositionRight,     // 图片在右，文字在左
    AXButtonImagePositionTop,       // 图片在上，文字在下
    AXButtonImagePositionBottom,    // 图片在下，文字在上
};

/// 方向,定向
typedef NS_ENUM(NSUInteger, AXOrientation) {
    AXOrientationTopToBottom,//从上到小
    AXOrientationLeftToRight,//从左到右
    AXOrientationUpleftToLowright,//左上到右下
    AXOrientationUprightToLowleft,//右上到左下
};

#endif /* AXKitEnum_h */
