//
//  AXiOSToolsEnum.h
//  AXiOSTools
//
//  Created by AXing on 2019/1/17.
//  Copyright © 2019 liu.weixing. All rights reserved.
//

#ifndef AXiOSToolsEnum_h
#define AXiOSToolsEnum_h

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

#endif /* AXiOSToolsEnum_h */
