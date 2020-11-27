//
//  AXAlertTransitioningObserver.h
//  AXiOSKit
//
//  Created by 小星星吃KFC on 2020/11/27.
//

#import <UIKit/UIKit.h>
#import "AXBaseAlertDefine.h"
NS_ASSUME_NONNULL_BEGIN

@interface AXAlertTransitioningObserver : NSObject<UIViewControllerTransitioningDelegate>

/**
 子vc重写此方法,更改 alertControllerStyle 样式

 @return AXAlertControllerStyle
 */
@property (nonatomic, assign)AXAlertControllerStyle alertControllerStyle;

@end

NS_ASSUME_NONNULL_END
