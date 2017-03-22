//
//  NSArray+AXCatch.m
//  ZBP2P
//
//  Created by Mole Developer on 2017/2/22.
//  Copyright © 2017年 mole. All rights reserved.
//

#import "NSArray+AXCatch.h"
#import <objc/runtime.h>  

@implementation NSArray (AXCatch)

+ (void)load{
    [super load];
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
  
        Method oldObjectAtIndex = class_getInstanceMethod(objc_getClass("__NSArrayI"), @selector(objectAtIndex:));
        Method newObjectAtIndex = class_getInstanceMethod(objc_getClass("__NSArrayI"), @selector(catch_objectAtIndex:));
        method_exchangeImplementations(oldObjectAtIndex, newObjectAtIndex);
  
    });
}

- (id)catch_objectAtIndex:(NSUInteger)index{
     
    if (index > self.count - 1 || !self.count){
        @try {
            return [self catch_objectAtIndex:index];
            
        } @catch (NSException *exception) {
            return nil;
//            return self.lastObject;
        } @finally {
            
        }
    }
    else{
        return [self catch_objectAtIndex:index];
    }
}




@end
