//
//  NSURLProtocol+AXDemo.h
//  AXiOSKit_Example
//
//  Created by 小星星吃KFC on 2021/5/24.
//  Copyright © 2021 axinger. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSURLProtocol (AXDemo)

+ (void)wk_registerScheme:(NSString*)scheme;

+ (void)wk_unregisterScheme:(NSString*)scheme;

@end

NS_ASSUME_NONNULL_END
