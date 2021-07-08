//
//  RouterManager.h
//  AXiOSKitExample
//
//  Created by 小星星MacBook on 2020/8/22.
//  Copyright © 2020 liuweixing. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

static NSString *const routeNameWith01ViewController = @"MGJ://Test1/_01ViewController";

@interface RouterManager : NSObject

+ (void)openURL:(NSString *)URL withUserInfo:(NSDictionary *)userInfo completion:(void (^)(id result))completion;

@end

NS_ASSUME_NONNULL_END
