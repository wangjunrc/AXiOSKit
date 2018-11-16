//
//  AXObject.m
//  BigApple
//
//  Created by liuweixing on 2016/12/5.
//  Copyright © 2016年 liuweixing All rights reserved.
//

#import "AXObject.h"
#import <UIKit/UIKit.h>

@implementation AXObject

+(void)isDebug:(void(^)(void))bebug release:(void(^)(void))release{
    
#ifdef DEBUG
    if (bebug) {
        bebug();
    }
#else
    if (release) {
        release();
    }
#endif
    
}



+(void)iPad:(void(^)(void))iPad iPhone:(void(^)(void))iPhone{
    
    if( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad ){
        
        if (iPad) {
            iPad();
        }
        
    }else{
        if (iPhone) {
            iPhone();
        }
        
    }
    
}

/**
 Debug 模式回调
 */
- (AXObject *(^)(void(^)(void)))axDebug {
    
    __weak typeof(self) weakSelf = self;
    return ^AXObject *(void (^block)(void)){
        __strong typeof(weakSelf) self = weakSelf;
#ifdef DEBUG
        if (block) {
            block();
        }
#else
#endif
        return self;
    };
}

/**
 Release 模式回调
 */
- (AXObject *(^)(void(^)(void)))axRelease {
    
    __weak typeof(self) weakSelf = self;
    return ^AXObject *(void (^block)(void)){
        __strong typeof(weakSelf) self = weakSelf;
        
#ifdef DEBUG
#else
        if (block) {
            block();
        }
#endif
        return self;
    };
}

@end
