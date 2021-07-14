//
//  AANavigationController.h
//  AXiOSKitExample
//
//  Created by liuweixing on 2019/12/5.
//  Copyright © 2019 liu.weixing. All rights reserved.
//

//#import <RTRootNavigationController/RTRootNavigationController.h>
#import <UIKit/UIKit.h>
//#import <QMUIKit/QMUIKit.h>
NS_ASSUME_NONNULL_BEGIN
/// 如果有底部栏，在root根视图里面 继承 RTContainerNavigationController ,别继承错了
/// RTContainerNavigationController是RTRootNavigationController导航栏的类
///
@interface DemoNavigationController : UINavigationController

@end

NS_ASSUME_NONNULL_END
