//
//  AXSwitch.h
//  AXiOSKit_Example
//
//  Created by 小星星吃KFC on 2021/1/15.
//  Copyright © 2021 axinger. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AXSwitchView : UIControl


- (instancetype)initWithFrame:(CGRect)frame NS_DESIGNATED_INITIALIZER;      // This class enforces a size appropriate for the control, and so the frame size is ignored.

- (nullable instancetype)initWithCoder:(NSCoder *)coder NS_DESIGNATED_INITIALIZER;


@end

NS_ASSUME_NONNULL_END
