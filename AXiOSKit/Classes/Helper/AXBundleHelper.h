//
//  AXBundleHelper.h
//  AXBundleHelper
//
//  Created by 小星星吃KFC on 2021/9/2.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AXBundleHelper : NSObject

+ (UIImage *)imageNamed:(NSString *)imageName;

+ (NSBundle *)bundleWithName:(NSString *)name;

@property(nonatomic, strong, readonly, class) UIViewController *currentViewController;

@end

NS_ASSUME_NONNULL_END
