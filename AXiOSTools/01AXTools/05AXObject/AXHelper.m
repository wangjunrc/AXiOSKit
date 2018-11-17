//
//  AXHelper.m
//  AXTools
//
//  Created by liuweixing on 2018/11/17.
//  Copyright © 2018 liuweixing. All rights reserved.
//

#import "AXHelper.h"
#import <UIKit/UIKit.h>

@implementation AXHelper

/**
 isIPhone 模式回调
 */
- (AXHelper *(^)(void(^)(void)))isIPhone {
    
    __weak typeof(self) weakSelf = self;
    return ^AXHelper *(void (^block)(void)){
        __strong typeof(weakSelf) self = weakSelf;
        if( UI_USER_INTERFACE_IDIOM() != UIUserInterfaceIdiomPad ){
            if (block) {
                block();
            }
        }
        return self;
    };
}

/**
 isIPad 模式回调
 */
- (AXHelper *(^)(void(^)(void)))isIPad {
    
    __weak typeof(self) weakSelf = self;
    return ^AXHelper *(void (^block)(void)){
        __strong typeof(weakSelf) self = weakSelf;
        
        if( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad ){
            if (block) {
                block();
            }
        }
        return self;
    };
}


/**
 Debug 模式回调
 */
- (AXHelper *(^)(void(^)(void)))axDebug {
    
    __weak typeof(self) weakSelf = self;
    return ^AXHelper *(void (^block)(void)){
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
- (AXHelper *(^)(void(^)(void)))axRelease {
    
    __weak typeof(self) weakSelf = self;
    return ^AXHelper *(void (^block)(void)){
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


//+(void)isDebug:(void(^)(void))bebug release:(void(^)(void))release{
//
//#ifdef DEBUG
//    if (bebug) {
//        bebug();
//    }
//#else
//    if (release) {
//        release();
//    }
//#endif
//
//}
//
//
//
//+(void)iPad:(void(^)(void))iPad iPhone:(void(^)(void))iPhone{
//
//    if( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad ){
//
//        if (iPad) {
//            iPad();
//        }
//
//    }else{
//        if (iPhone) {
//            iPhone();
//        }
//
//    }
//
//}


@end
