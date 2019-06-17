//
//  UIGestureRecognizer+AXKit.h
//  AXiOSKit
//
//  Created by AXing on 2019/6/17.
//  Copyright © 2019 liu.weixing. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^AXGestureBlock)(UIGestureRecognizer *ges);

@interface UIGestureRecognizer (AXKit)

+(instancetype )ax_gestureRecognizerWithActionBlock:(AXGestureBlock )block;

-(instancetype )initWithActionBlock:(AXGestureBlock )block;

@end

NS_ASSUME_NONNULL_END
