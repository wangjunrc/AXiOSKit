//
//  AXBundleHelper.m
//  MBProgressHUD_AX
//
//  Created by 小星星吃KFC on 2021/9/2.
//

#import "AXBundleHelper.h"

@implementation AXBundleHelper

NSString *const kAXBundleName = @"AXiOSKitMain";

+ (NSBundle *)mainBundle {
    static NSBundle *resourceBundle = nil;
    if (!resourceBundle) {
        NSBundle *mainBundle = [NSBundle bundleForClass:self];
        NSString *resourcePath = [mainBundle pathForResource:kAXBundleName ofType:@"bundle"];
        resourceBundle = [NSBundle bundleWithPath:resourcePath] ?: mainBundle;
    }
    return resourceBundle;
}

+ (NSBundle *)bundleWithName:(NSString *)name {
    NSBundle *bundle = [NSBundle bundleForClass:self.class];
    NSString *bundlePath = [bundle pathForResource:name ofType:@"bundle"];
    NSBundle *tempBundle = [NSBundle bundleWithPath:bundlePath];
    if (tempBundle == nil) {
        tempBundle = bundle;
    }
    return tempBundle;
}


+ (UIImage *)imageNamed:(NSString *)name {
    UIImage *image = [UIImage imageNamed:name inBundle:self.mainBundle compatibleWithTraitCollection:nil];
    return image;
}

/**
 * 当前控制器
 */
+(UIViewController *)currentViewController {
    UIViewController *resultVC = [self ax_topViewController:[[UIApplication sharedApplication].keyWindow rootViewController]];
    while (resultVC.presentedViewController) {
        resultVC = [self ax_topViewController:resultVC.presentedViewController];
    }
    return resultVC;
}

//多次循环遍历
+ (UIViewController *)ax_topViewController:(UIViewController *)vc {
    if ([vc isKindOfClass:[UINavigationController class]]) {
        return [self ax_topViewController:[(UINavigationController *)vc topViewController]];
    } else if ([vc isKindOfClass:[UITabBarController class]]) {
        return [self ax_topViewController:[(UITabBarController *)vc selectedViewController]];
    } else {
        return vc;
    }
    return nil;
}

@end
