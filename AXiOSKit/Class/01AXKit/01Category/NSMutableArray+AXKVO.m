//
//  NSMutableArray+AXKVO.m
//  AXiOSKit
//
//  Created by 小星星吃KFC on 2020/9/28.
//  Copyright © 2020 liu.weixing. All rights reserved.
//

#import "NSMutableArray+AXKVO.h"
#import <ReactiveObjC/ReactiveObjC.h>

@implementation NSMutableArray (AXKVO)

-(void)ax_addKVO:(void(^)(NSMutableArray *array))handler{
    
    /// add
    [self _ax_addSelector:@selector(addObject:) handler:handler];
    
    /// set
    [self _ax_addSelector:@selector(setObject:atIndexedSubscript:) handler:handler];
    
    
    /// insert
    [self _ax_addSelector:@selector(insertObject: atIndex:) handler:handler];
    [self _ax_addSelector:@selector(insertObject: atIndex:) handler:handler];
    
    ///replace
    [self _ax_addSelector:@selector(replaceObjectAtIndex: withObject:) handler:handler];
    
    /// remove
    [self _ax_addSelector:@selector(removeLastObject) handler:handler];
    [self _ax_addSelector:@selector(removeObject:) handler:handler];
    [self _ax_addSelector:@selector(removeAllObjects) handler:handler];
    [self _ax_addSelector:@selector(removeObjectAtIndex:) handler:handler];

}

-(void)_ax_addSelector:(SEL)selector handler:(void(^)(NSMutableArray *array))handler{
    
    __weak typeof(self) weakSelf = self;
    [[self rac_signalForSelector:selector] subscribeNext:^(id  _Nullable x) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        if (handler) {
            handler(strongSelf);
        }
    }];
}



@end
