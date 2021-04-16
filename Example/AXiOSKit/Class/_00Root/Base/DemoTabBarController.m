//
//  DemoTabBarController.m
//  AXiOSKit_Example
//
//  Created by 小星星吃KFC on 2021/4/14.
//  Copyright © 2021 axinger. All rights reserved.
//

#import "DemoTabBarController.h"

#import <SDWebImageWebPCoder/SDImageWebPCoder.h>
#import <SDWebImage/SDImageCodersManager.h>
#import "_01RootVC.h"
#import "DemoNavigationController.h"
#import "DemoTabBarController.h"
#import <AXiOSKit/AXConfigureManager.h>
#import "_02RootVC.h"
#import "AXTabBarController.h"
#import "_03RootVC.h"
#import <ReactiveObjC/ReactiveObjC.h>

@interface DemoTabBarController ()<UITabBarControllerDelegate, CYLTabBarControllerDelegate>

@property(nonatomic, strong) NSArray<NSDictionary<NSString *,UIViewController *> *> *dataArray;
@end

@implementation DemoTabBarController


- (instancetype)init {
    /**
     * 以下两行代码目的在于手动设置让TabBarItem只显示图标，不显示文字，并让图标垂直居中。
     * 等 效于在 `-tabBarItemsAttributesForController` 方法中不传 `CYLTabBarItemTitle` 字段。
     * 更推荐后一种做法。
     */
    UIEdgeInsets imageInsets = UIEdgeInsetsZero;//UIEdgeInsetsMake(4.5, 0, -4.5, 0);
    UIOffset titlePositionAdjustment = UIOffsetMake(0, -3.5);
    if (self = [super initWithViewControllers:[self viewControllersForTabBar]
                        tabBarItemsAttributes:[self tabBarItemsAttributesForTabBar]
                                  imageInsets:imageInsets
                      titlePositionAdjustment:titlePositionAdjustment
                                      context:@"AAA"
                ]) {
//        [self customizeTabBarAppearanceWithTitlePositionAdjustment:titlePositionAdjustment];
        self.delegate = self;
        self.navigationController.navigationBar.hidden = YES;
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupTitle];
}
#pragma mark - 主题字体颜色等
- (void)setupTitle{
    NSDictionary *normalDict= @{NSForegroundColorAttributeName : [UIColor grayColor]};
    NSDictionary *selectedDict= @{NSForegroundColorAttributeName : [UIColor redColor]};
    
//    [[UITabBarItem appearance] setTitleTextAttributes:noDic forState:UIControlStateNormal];
//    [[UITabBarItem appearance] setTitleTextAttributes:seDic forState:UIControlStateSelected];
    //    [self.tabBarItem setTitleTextAttributes:noDic forState:UIControlStateNormal];
    //    [self.tabBarItem setTitleTextAttributes:seDic forState:UIControlStateSelected];
    

    
    
    if (@available(iOS 13.0, *)) {
        UITabBarItemAppearance *inlineLayoutAppearance = [[UITabBarItemAppearance  alloc] init];
        
        // set the text Attributes
        // 设置文字属性
        [inlineLayoutAppearance.normal setTitleTextAttributes:normalDict];
        [inlineLayoutAppearance.selected setTitleTextAttributes:selectedDict];

        UITabBarAppearance *standardAppearance = [[UITabBarAppearance alloc] init];
        standardAppearance.stackedLayoutAppearance = inlineLayoutAppearance;
        standardAppearance.backgroundColor = [UIColor orangeColor];
        //shadowColor和shadowImage均可以自定义颜色, shadowColor默认高度为1, shadowImage可以自定义高度.
        standardAppearance.shadowColor = [UIColor redColor];
        // standardAppearance.shadowImage = [[self class] imageWithColor:[UIColor cyl_systemGreenColor] size:CGSizeMake([UIScreen mainScreen].bounds.size.width, 1)];
        self.tabBar.standardAppearance = standardAppearance;
    } else {
        // Override point for customization after application launch.
        // set the text Attributes
        // 设置文字属性
        UITabBarItem *tabBar = [UITabBarItem appearance];
        [tabBar setTitleTextAttributes:normalDict forState:UIControlStateNormal];
        [tabBar setTitleTextAttributes:selectedDict forState:UIControlStateSelected];
        
        // This shadow image attribute is ignored if the tab bar does not also have a custom background image.So at least set somthing.
        [[UITabBar appearance] setBackgroundImage:[[UIImage alloc] init]];
//        [[UITabBar appearance] setShadowImage:[[self class] imageWithColor:[UIColor cyl_systemGreenColor] size:CGSizeMake([UIScreen mainScreen].bounds.size.width, 1)]];
   
        self.tabBar.tintColor = [UIColor greenColor];
        self.tabBar.unselectedItemTintColor = [UIColor purpleColor];
        /// 背景色
        [self.tabBar setBarTintColor:UIColor.orangeColor];
        
    }
    
}

/// 三、跟视图为UITabBarController(在UITabBarController中设置)

//6.0之后系统调用该方法

//- (BOOL)shouldAutorotate{
//
//    //返回顶层视图的设置（顶层控制器需要覆盖shouldAutorotate方法）
//
//    UINavigationController *nav = (UINavigationController *)[self.viewControllers objectAtIndex:self.selectedIndex];
//
//    return nav.topViewController.shouldAutorotate;
//
////    return NO;
//}
//
//
//
////6.0之后系统调用该方法
//
//-(UIInterfaceOrientationMask )supportedInterfaceOrientations{
//
//    //返回顶层视图支持的旋转方向
//
//    UINavigationController *nav = (UINavigationController *)[self.viewControllers objectAtIndex:self.selectedIndex];
//
//    return nav.topViewController.supportedInterfaceOrientations;
//}

- (NSArray *)viewControllersForTabBar {
    
    return [[self.dataArray.rac_sequence map:^id _Nullable(NSDictionary<NSString *,UIViewController *> * _Nullable value) {
            DemoNavigationController *nav = [DemoNavigationController.alloc initWithRootViewController:value[@"vc"]];

            return nav;
    }]array];
    
}

- (NSArray *)tabBarItemsAttributesForTabBar {
//    NSDictionary *dic1 = @{
//        CYLTabBarItemTitle : @"Root1",
//        CYLTabBarItemImage : [UIImage imageNamed:@"home_normal"],
//        CYLTabBarItemSelectedImage : [UIImage imageNamed:@"home_highlight"],
//        CYLTabBarLottieURL : [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"green_lottie_tab_home" ofType:@"json"]],
//    };
//    NSDictionary *dic2 = @{
//        CYLTabBarItemTitle : @"Root2",
//        CYLTabBarItemImage : [UIImage imageNamed:@"fishpond_normal"],
//        CYLTabBarItemSelectedImage :[UIImage imageNamed:@"fishpond_highlight"],
//        CYLTabBarLottieURL : [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"green_lottie_tab_home" ofType:@"json"]],
//
//    };
//    NSDictionary *dic3 = @{
//        CYLTabBarItemTitle : @"Root3",
//        CYLTabBarItemImage : [UIImage imageNamed:@"message_normal"],
//        CYLTabBarItemSelectedImage :[UIImage imageNamed:@"message_highlight"],
//        CYLTabBarLottieURL : [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"green_lottie_tab_home" ofType:@"json"]],
//
//    };
    return self.dataArray;
}


/**
 *  更多TabBar自定义设置：比如：tabBarItem 的选中和不选中文字和背景图片属性、tabbar 背景图片属性等等
 */
- (void)customizeTabBarAppearanceWithTitlePositionAdjustment:(UIOffset)titlePositionAdjustment {
    // Customize UITabBar height
    // 自定义 TabBar 高度
    // tabBarController.tabBarHeight = CYL_IS_IPHONE_X ? 65 : 40;
    
//    [self rootWindow].backgroundColor = [UIColor cyl_systemBackgroundColor];
    
    // set the text color for unselected state
    // 普通状态下的文字属性
    NSMutableDictionary *normalAttrs = [NSMutableDictionary dictionary];
    normalAttrs[NSForegroundColorAttributeName] = [UIColor blackColor];
    //normalAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:10];
    
    // set the text color for selected state
    // 选中状态下的文字属性
    NSMutableDictionary *selectedAttrs = [NSMutableDictionary dictionary];
    selectedAttrs[NSForegroundColorAttributeName] = [UIColor redColor];
    //selectedAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:10];

    // Set the dark color to selected tab (the dimmed background)
    // TabBarItem选中后的背景颜色
    // [self customizeTabBarSelectionIndicatorImage];
    
    // update TabBar when TabBarItem width did update
    // If your app need support UIDeviceOrientationLandscapeLeft or UIDeviceOrientationLandscapeRight，
    // remove the comment '//'
    // 如果你的App需要支持横竖屏，请使用该方法移除注释 '//'
//     [self updateTabBarCustomizationWhenTabBarItemWidthDidUpdate];
    
    // set background color
    // 设置 TabBar 背景
    // 半透明
//    [UITabBar appearance].translucent = YES;
    // [UITabBar appearance].barTintColor = [UIColor cyl_systemBackgroundColor];
    // [[UITabBar appearance] setBackgroundColor:[UIColor cyl_systemBackgroundColor]];
    
    
    //     [[UITabBar appearance] setBackgroundImage:[[self class] imageWithColor:[UIColor whiteColor] size:CGSizeMake([UIScreen mainScreen].bounds.size.width, tabBarController.tabBarHeight ?: (CYL_IS_IPHONE_X ? 65 : 40))]];
    //    [[UITabBar appearance] setUnselectedItemTintColor:[UIColor systemGrayColor]];
    
    //Three way to deal with shadow 三种阴影处理方式：
    // NO.3, without shadow : use -[[CYLTabBarController hideTabBarShadowImageView] in CYLMainRootViewController.m
    
    // NO.2，using layer to add shadow.
    //    CYLTabBarController *tabBarController = [self cyl_tabBarController];
    //    tabBarController.tabBar.layer.shadowColor = [UIColor blackColor].CGColor;
    //    tabBarController.tabBar.layer.shadowRadius = 15.0;
    //    tabBarController.tabBar.layer.shadowOpacity = 1;
    //    tabBarController.tabBar.layer.shadowOffset = CGSizeMake(0, 3);
    //    tabBarController.tabBar.layer.masksToBounds = NO;
    //    tabBarController.tabBar.clipsToBounds = NO;
    
    // NO.1，using Image note:recommended.推荐方式
    // set the bar shadow image
    // without shadow : use -[[CYLTabBarController hideTabBarShadowImageView] in CYLMainRootViewController.m
    if (@available(iOS 13.0, *)) {
        UITabBarItemAppearance *inlineLayoutAppearance = [[UITabBarItemAppearance  alloc] init];
        // fix https://github.com/ChenYilong/CYLTabBarController/issues/456
        inlineLayoutAppearance.normal.titlePositionAdjustment = titlePositionAdjustment;

        // set the text Attributes
        // 设置文字属性
        [inlineLayoutAppearance.normal setTitleTextAttributes:normalAttrs];
        [inlineLayoutAppearance.selected setTitleTextAttributes:selectedAttrs];

        UITabBarAppearance *standardAppearance = [[UITabBarAppearance alloc] init];
        standardAppearance.stackedLayoutAppearance = inlineLayoutAppearance;
        standardAppearance.backgroundColor = [UIColor orangeColor];
        //shadowColor和shadowImage均可以自定义颜色, shadowColor默认高度为1, shadowImage可以自定义高度.
        standardAppearance.shadowColor = [UIColor greenColor];
        // standardAppearance.shadowImage = [[self class] imageWithColor:[UIColor cyl_systemGreenColor] size:CGSizeMake([UIScreen mainScreen].bounds.size.width, 1)];
        self.tabBar.standardAppearance = standardAppearance;
    } else {
        // Override point for customization after application launch.
        // set the text Attributes
        // 设置文字属性
        UITabBarItem *tabBar = [UITabBarItem appearance];
        [tabBar setTitleTextAttributes:normalAttrs forState:UIControlStateNormal];
        [tabBar setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];
        
        // This shadow image attribute is ignored if the tab bar does not also have a custom background image.So at least set somthing.
        [[UITabBar appearance] setBackgroundImage:[[UIImage alloc] init]];
//        [[UITabBar appearance] setShadowImage:[[self class] imageWithColor:[UIColor cyl_systemGreenColor] size:CGSizeMake([UIScreen mainScreen].bounds.size.width, 1)]];
    }
}


- (void)tabBarController:(UITabBarController *)tabBarController didSelectControl:(UIControl *)control {
//    UIView *animationView;
//    // 如果 PlusButton 也添加了点击事件，那么点击 PlusButton 后不会触发该代理方法。
//    if ([control isKindOfClass:[CYLExternPlusButton class]]) {
//        UIButton *button = CYLExternPlusButton;
//        animationView = button.imageView;
//    } else if ([control isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
//        for (UIView *subView in control.subviews) {
//            if ([subView isKindOfClass:NSClassFromString(@"UITabBarSwappableImageView")]) {
//                animationView = subView;
//            }
//        }
//    }
//
//    if ([self cyl_tabBarController].selectedIndex % 2 == 0) {
//        [self addScaleAnimationOnView:animationView];
//    } else {
//        [self addRotateAnimationOnView:animationView];
//    }
}

//缩放动画
- (void)addScaleAnimationOnView:(UIView *)animationView {
    //需要实现的帧动画，这里根据需求自定义
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
    animation.keyPath = @"transform.scale";
    animation.values = @[@1.0,@1.3,@0.9,@1.15,@0.95,@1.02,@1.0];
    animation.duration = 1;
    animation.calculationMode = kCAAnimationCubic;
    [animationView.layer addAnimation:animation forKey:nil];
}

//旋转动画
- (void)addRotateAnimationOnView:(UIView *)animationView {
    [UIView animateWithDuration:0.32 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        animationView.layer.transform = CATransform3DMakeRotation(M_PI, 0, 1, 0);
    } completion:nil];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:0.70 delay:0 usingSpringWithDamping:1 initialSpringVelocity:0.2 options:UIViewAnimationOptionCurveEaseOut animations:^{
            animationView.layer.transform = CATransform3DMakeRotation(2 * M_PI, 0, 1, 0);
        } completion:nil];
    });
}

- (NSArray<NSDictionary<NSString *,UIViewController *> *> *)dataArray {
    if (!_dataArray) {
        _dataArray =  @[
            @{
                @"vc":_01RootVC.alloc.init,
                CYLTabBarItemTitle : @"Root1",
                CYLTabBarItemImage : [UIImage imageNamed:@"home_normal"],
                CYLTabBarItemSelectedImage : [UIImage imageNamed:@"home_highlight"],
                CYLTabBarLottieURL : [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"green_lottie_tab_home" ofType:@"json"]],
                
            },
            @{@"vc":_02RootVC.alloc.init,
              CYLTabBarItemTitle : @"Root2",
              CYLTabBarItemImage : [UIImage imageNamed:@"fishpond_normal"],
              CYLTabBarItemSelectedImage :[UIImage imageNamed:@"fishpond_highlight"],
              CYLTabBarLottieURL : [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"green_lottie_tab_discover" ofType:@"json"]],
            },
            @{@"vc":_03RootVC.alloc.init,
              CYLTabBarItemTitle : @"Root3",
              CYLTabBarItemImage : [UIImage imageNamed:@"message_normal"],
              CYLTabBarItemSelectedImage :[UIImage imageNamed:@"message_highlight"],
              CYLTabBarLottieURL : [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"green_lottie_tab_mine" ofType:@"json"]],
              
            }
        ];
    }
    return _dataArray;
}
@end
