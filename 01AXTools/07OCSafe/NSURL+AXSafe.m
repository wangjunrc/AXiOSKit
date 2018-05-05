//
//  NSURL+AXSafe.m
//  AXiOSTools
//
//  Created by liuweixing on 2018/5/5.
//

#import "NSURL+AXSafe.h"

#import <objc/runtime.h>

@implementation NSURL (AXSafe)


/**
 放置 url 拼接出现 // 无法访问
 */
+ (void)load{
    
    //-initWithString
    Method originalinit = class_getInstanceMethod(self, @selector(initWithString:));
    Method swizzledinit = class_getInstanceMethod(self, @selector(safe_initWithString:));
    method_exchangeImplementations(originalinit, swizzledinit);

  
    //+URLWithString
    Method originalURLWith = class_getClassMethod(self, @selector(URLWithString:));
    Method swizzledURLWith = class_getClassMethod(self, @selector(safe_URLWithString:));
    method_exchangeImplementations(originalURLWith, swizzledURLWith);

}

-(instancetype)safe_initWithString:(NSString *)aString{
    
    NSString *str = aString;
    
    NSString *temp  = nil;
    if ( [str hasPrefix:@"https://"]) {
        NSString *lastStr = [str componentsSeparatedByString:@"https://"].lastObject;
        lastStr = [lastStr stringByReplacingOccurrencesOfString:@"//" withString:@"/"];
        temp = [@"https://" stringByAppendingString:lastStr];
    }else if  ( [str hasPrefix:@"http://"]) {
        
        NSString *lastStr = [str componentsSeparatedByString:@"http://"].lastObject;
        lastStr = [lastStr stringByReplacingOccurrencesOfString:@"//" withString:@"/"];
        temp = [@"http://" stringByAppendingString:lastStr];
        
    }else{
        temp = str;
    }
    return [[NSURL alloc]initWithString:temp];
    
}

+ (instancetype)safe_URLWithString:(NSString *)aString{
    
    NSString *str = aString;
    
    NSString *temp  = nil;
    if ( [str hasPrefix:@"https://"]) {
        NSString *lastStr = [str componentsSeparatedByString:@"https://"].lastObject;
        lastStr = [lastStr stringByReplacingOccurrencesOfString:@"//" withString:@"/"];
        temp = [@"https://" stringByAppendingString:lastStr];
    }else if  ( [str hasPrefix:@"http://"]) {
        
        NSString *lastStr = [str componentsSeparatedByString:@"http://"].lastObject;
        lastStr = [lastStr stringByReplacingOccurrencesOfString:@"//" withString:@"/"];
        temp = [@"http://" stringByAppendingString:lastStr];
        
    }else{
        temp = str;
    }
    return [NSURL safe_URLWithString:temp];
    
}

@end
