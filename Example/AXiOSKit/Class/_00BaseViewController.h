//
//  _00BaseViewController.h
//  AXiOSKit
//
//  Created by 小星星吃KFC on 2020/12/8.
//  Copyright © 2020 axinger. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AXiOSKit/AXiOSKit.h>
#import <Masonry/Masonry.h>
#import <ReactiveObjC/ReactiveObjC.h>

NS_ASSUME_NONNULL_BEGIN

@interface _00BaseViewController : UIViewController

@property(nonatomic, strong) UIView *containerView;

@property (nonatomic, strong) MASViewAttribute *bottomAttribute;

-(void )_p00ButtonTitle:(NSString *)title handler:(void(^)(void))handler;

/// 子约束最后调用一下
-(void)_loadBottomAttribute;

@end

NS_ASSUME_NONNULL_END
