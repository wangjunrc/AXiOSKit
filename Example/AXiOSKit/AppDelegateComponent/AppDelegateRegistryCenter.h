//
//  SOAComponentAppDelegate.h
//  AXiOSKit_Example
//
//  Created by 小星星吃KFC on 2020/10/26.
//  Copyright © 2020 axinger. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

extern id AppDelegateRegistry(SEL selector,NSArray *params );

/// SOA(面向服务的架构)
@interface AppDelegateRegistryCenter : NSObject

+ (instancetype)instance;


@property(nonatomic, strong) NSMutableSet *services;


@end

NS_ASSUME_NONNULL_END
