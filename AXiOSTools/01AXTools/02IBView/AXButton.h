//
//  AXButton.h
//  Example
//
//  Created by AXing on 2019/1/17.
//  Copyright © 2019 liu.weixing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIButton+AXTool.h"
IB_DESIGNABLE

NS_ASSUME_NONNULL_BEGIN

@interface AXButton : UIButton

/**图片位置*/
@property (nonatomic, assign)IBInspectable AXButtonImagePosition imagePosition;

@end

NS_ASSUME_NONNULL_END
