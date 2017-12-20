//
//  NSMutableDictionary+AXCatch.m
//  ZBP2P
//
//  Created by Mole Developer on 2017/2/22.
//  Copyright © 2017年 mole. All rights reserved.
//

#import "NSMutableDictionary+AXCatch.h"
#import <objc/runtime.h>
@implementation NSMutableDictionary (AXCatch)
+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
   
        Method fromMethod = class_getInstanceMethod(objc_getClass("__NSDictionaryM"), @selector(setObject:forKey:));
        Method toMethod = class_getInstanceMethod(objc_getClass("__NSDictionaryM"), @selector(catch_setObject:forKey:));
        method_exchangeImplementations(fromMethod, toMethod);
        
    });
}

- (void)catch_setObject:(id)emObject forKey:(NSString *)key {
    if (emObject == nil) {
        @try {
            [self catch_setObject:emObject forKey:key];
        }
        @catch (NSException *exception) {
            
            emObject = [NSString stringWithFormat:@""];
            [self catch_setObject:emObject forKey:key];
        }
        @finally {}
    }else {
        [self catch_setObject:emObject forKey:key];
    }
}
@end
