//
//  NSBundle+SPTCashRedEnvelope.m
//  SPTCashRedEnvelope
//
//  Created by AXing on 2018/12/28.
//  Copyright © 2018 SPT. All rights reserved.
//

#import "NSBundle+SPTCashRedEnvelope.h"

/**
 增加这个私有类，目的是不想导入其他的类
 */
@interface SPTCashRedEnvelopeBundle : NSObject

+ (NSBundle *)spt_cashRedEnvelope_bundle;

@end


@implementation SPTCashRedEnvelopeBundle

+ (NSBundle *)spt_cashRedEnvelope_bundle {
    NSBundle *bundle = [NSBundle bundleForClass:[self class]];
    NSString *bundlePath = [bundle pathForResource:@"SPTCashRedEnvelope" ofType:@"bundle"];
    NSBundle *imageBundle = [NSBundle bundleWithPath:bundlePath];
    return imageBundle;
}

@end

@implementation NSBundle (SPTCashRedEnvelope)

+ (NSBundle *)spt_cashRedEnvelope_bundle {
    return [SPTCashRedEnvelopeBundle spt_cashRedEnvelope_bundle];
}

@end
