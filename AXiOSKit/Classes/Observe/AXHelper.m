//
//  AXHelper.m
//  AXKit
//
//  Created by liuweixing on 2018/11/17.
//  Copyright © 2018 liuweixing. All rights reserved.
//

#import "AXHelper.h"
#import <UIKit/UIKit.h>

@implementation AXHelper
/// 一定要用 instancetype 方便继承
+(instancetype )helper{
    return [[self alloc]init];
}

/**
 isiPhone 模式回调
 */
- (AXHelper *(^)(void(^)(void)))isiPhone {

    __weak typeof(self) weakSelf = self;
    return ^AXHelper *(void (^block)(void)) {
        __strong typeof(weakSelf) self = weakSelf;
        if (UI_USER_INTERFACE_IDIOM() != UIUserInterfaceIdiomPad) {
            if (block) {
                block();
            }
        }
        return self;
    };
}

/**
 isiPad 模式回调
 */
- (AXHelper *(^)(void(^)(void)))isiPad {

    __weak typeof(self) weakSelf = self;
    return ^AXHelper *(void (^block)(void)) {
        __strong typeof(weakSelf) self = weakSelf;

        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
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
- (AXHelper *(^)(void(^)(void)))isDebug {

    __weak typeof(self) weakSelf = self;
    return ^AXHelper *(void (^block)(void)) {
        __strong typeof(weakSelf) self = weakSelf;
#ifdef DEBUG
        NSLog(@"%s", __func__);
        if (block) {
            block();
        }
#endif
        return self;
    };
}

/**
 Release 模式回调
 */
- (AXHelper *(^)(void(^)(void)))isRelease {

    __weak typeof(self) weakSelf = self;
    return ^AXHelper *(void (^block)(void)) {
        __strong typeof(weakSelf) self = weakSelf;
        
#ifndef DEBUG
        NSLog(@"Release 模式回调");
        if (block) {
            block();
        }
#endif
        return self;
    };
}

///**
// isiPhone 模式回调
// */
//+ (AXHelper *(^)(void(^)(void)))isiPhone {
//
//    __weak typeof(self) weakSelf = self;
//    return ^AXHelper *(void (^block)(void)){
//        __strong typeof(weakSelf) self = weakSelf;
//        if( UI_USER_INTERFACE_IDIOM() != UIUserInterfaceIdiomPad ){
//            if (block) {
//                block();
//            }
//        }
//        return AXHelper.class;
//    };
//}
//
///**
// isiPad 模式回调
// */
//+ (AXHelper *(^)(void(^)(void)))isiPad {
//
//    __weak typeof(self) weakSelf = self;
//    return ^AXHelper *(void (^block)(void)){
//        __strong typeof(weakSelf) self = weakSelf;
//
//        if( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad ){
//            if (block) {
//                block();
//            }
//        }
//        return AXHelper.class;
//    };
//}
//
//
///**
// Debug 模式回调
// */
//+ (AXHelper *(^)(void(^)(void)))isDebug {
//
//    __weak typeof(self) weakSelf = self;
//    return ^AXHelper *(void (^block)(void)){
//        __strong typeof(weakSelf) self = weakSelf;
//#ifdef DEBUG
//        if (block) {
//            block();
//        }
//#else
//#endif
//        return AXHelper.class;
//    };
//}
//
///**
// Release 模式回调
// */
//+ (AXHelper *(^)(void(^)(void)))isRelease {
//
//    __weak typeof(self) weakSelf = self;
//    return ^AXHelper *(void (^block)(void)){
//        __strong typeof(weakSelf) self = weakSelf;
//
//#ifdef DEBUG
//#else
//        if (block) {
//            block();
//        }
//#endif
//        return AXHelper.class;
//    };
//}

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
