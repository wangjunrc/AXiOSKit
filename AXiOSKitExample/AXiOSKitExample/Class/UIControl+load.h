//
//  UIControl+load.h
//  AXiOSKitExample
//
//  Created by 小星星吃KFC on 2020/9/10.
//  Copyright © 2020 liuweixing. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIControl (load)
- (void)user_sendAction:(SEL)action to:(nullable id)target forEvent:(nullable UIEvent *)event;
@end

NS_ASSUME_NONNULL_END
