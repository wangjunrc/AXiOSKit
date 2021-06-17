//
//  AXLogers.m
//  AXiOSKit
//
//  Created by 小星星吃KFC on 2021/6/17.
//

#import "AXLogers.h"

static const char *_dateChar() {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"yyyy-MM-dd HH:mm:ss.SSSSSSZ";
    const char *dateChar =
    [dateFormatter stringFromDate:[NSDate date]].UTF8String;
    return dateChar;
}

@implementation AXLogers

+(void)Info:(const char *)file
   function:(const char *)function
       line:(NSUInteger )line
     format:(NSString *)format, ...{

    __block va_list arg_list;
    va_start(arg_list, format);

    const char *dateChar = _dateChar();

    const char *formatChar =
    [[NSString alloc] initWithFormat:format arguments:arg_list].UTF8String;

    file = [NSString stringWithFormat:@"%s", file].lastPathComponent.UTF8String;

    printf("\n%s [%s 第%lu行]: %s\n%s\n", dateChar, file, (unsigned long)line,
           function, formatChar);
    va_end(arg_list);
}

+(void)PrefixLog:(NSString *)msg format:( NSString *)format, ...{
    __block va_list arg_list;
    va_start(arg_list, format);
    const char *dateChar = __dateChar();
    const char *msgChar = msg.UTF8String;
    const char *formatChar =
    [[NSString alloc] initWithFormat:format arguments:arg_list].UTF8String;
    printf("\n%s [%s] %s", dateChar, msgChar, formatChar);
    va_end(arg_list);
}
+(void)test {
    
    
}
@end
