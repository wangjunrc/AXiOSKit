//
//  NSObject+AXLoger.m
//  AXiOSKit
//
//  Created by 小星星吃KFC on 2021/8/18.
//

#import "NSObject+AXLoger.h"

const char *__dateChar_() {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"yyyy-MM-dd HH:mm:ss.SSSSSSZ";
    const char *dateChar =
    [dateFormatter stringFromDate:[NSDate date]].UTF8String;
    return dateChar;
}

/**
 封装NSLog用printf 没有__FILE__ 和 __FILE__
 
 @param format NSLog样式 format
 @param ... NSLog样式 ...
 */
void AXLoger(NSString *format, ...) {
    
    __block va_list arg_list;
    va_start (arg_list, format);
    const char *dateChar = __dateChar_();
    const char *formatChar = [[NSString alloc] initWithFormat:format
                                                    arguments:arg_list].UTF8String;
    printf("%s %s\n",dateChar,formatChar);
    va_end(arg_list);
}

/**
 封装NSLog用printf 有__FILE__ 和 __FILE__
 
 @param file __FILE__
 @param function __FUNCTION__
 @param line __LINE__
 @param format format
 @param ... NSLog样式 ...
 */
void AXLogerInfo(const char *file, const char *function, NSUInteger line,
                 NSString *format, ...) {
    __block va_list arg_list;
    va_start(arg_list, format);
    
    const char *dateChar = __dateChar_();
    
    const char *formatChar =
    [[NSString alloc] initWithFormat:format arguments:arg_list].UTF8String;
    
    file = [NSString stringWithFormat:@"%s", file].lastPathComponent.UTF8String;
    
    printf("\n%s [%s 第%lu行]: %s\n%s\n", dateChar, file, (unsigned long)line,
           function, formatChar);
    va_end(arg_list);
}

void AXLogerMessage(NSString *msg, NSString *format, ...) {
    __block va_list arg_list;
    va_start(arg_list, format);
    const char *dateChar = __dateChar_();
    const char *msgChar = msg.UTF8String;
    const char *formatChar =
    [[NSString alloc] initWithFormat:format arguments:arg_list].UTF8String;
    printf("\n%s [%s] %s", dateChar, msgChar, formatChar);
    va_end(arg_list);
}

/**
 封装NSLog用printf 纯输出
 
 @param format NSLog样式 format
 @param ... NSLog样式 ...
 */
void AXNoMsgLog(NSString *format, ...) {
    __block va_list arg_list;
    va_start(arg_list, format);
    // log内容
    const char *formatChar =
    [[NSString alloc] initWithFormat:format arguments:arg_list].UTF8String;
    printf("%s\n", formatChar);
    va_end(arg_list);
}
void NSLog3(NSString *format, ...){
    
}
