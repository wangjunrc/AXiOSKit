//
//  AXKeyboardObserve.h
//  AXiOSKit
//
//  Created by axing on 2019/5/29.
//  Copyright © 2019 liu.weixing. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AXKeyboardObserve : NSObject

/**
 键盘弹出需要上移的view
 */
@property(nonatomic, weak) UIView *containerView;

/**
 偏移位置
 */
@property(nonatomic, assign) CGFloat offset;

/**
 配置键盘移动
 
 @param editView 键盘归属
 @return 返回配置
 */
- (id)initWithOwner:(UIView *)editView;

@end

NS_ASSUME_NONNULL_END
