
#import <Foundation/Foundation.h>

@implementation NSDictionary (Log)
//- (NSString *)descriptionWithLocale:(id)locale
//{
//    NSMutableString *str = [NSMutableString string];
//    
//    [str appendString:@"{\n"];
//    
//    // 遍历字典的所有键值对
//    [self enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
//        [str appendFormat:@"\t%@ = %@,\n", key, obj];
//    }];
//    
//    [str appendString:@"}"];
//    
//    // 查出最后一个,的范围
//    NSRange range = [str rangeOfString:@"," options:NSBackwardsSearch];
//    if (range.length) {
//        // 删掉最后一个,
//        [str deleteCharactersInRange:range];
//    }
//    
//    return str;
//    
////    NSString *output;
////    @try {
////        output = [[NSString alloc] initWithData:[NSJSONSerialization dataWithJSONObject:self options:NSJSONWritingPrettyPrinted error:nil] encoding:NSUTF8StringEncoding];
////    } @catch (NSException *exception) {
////        output = self.description;
////    } @finally {
////        
////    }
////    return  output;
//}


- (NSString *)descriptionWithLocale:(nullable id)locale{
    NSString *logString;
    @try {
        logString=[[NSString alloc] initWithData:[NSJSONSerialization dataWithJSONObject:self options:NSJSONWritingPrettyPrinted error:nil] encoding:NSUTF8StringEncoding]; }
    @catch (NSException *exception) {
        NSString *reason = [NSString stringWithFormat:@"reason:%@",exception.reason];
        logString = [NSString stringWithFormat:@"转换失败:\n%@,\n转换终止,输出如下:\n%@",reason,self.description];
    } @finally {
        
    }
    return logString;
}


@end

@implementation NSArray (Log)
//- (NSString *)descriptionWithLocale:(id)locale
//{
//    NSMutableString *str = [NSMutableString string];
//    [str appendString:@"[\n"];
//    
//    // 遍历数组的所有元素
//    [self enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
//        [str appendFormat:@"%@,\n", obj];
//    }];
//    
//    [str appendString:@"]"];
//    // 查出最后一个,的范围
//    NSRange range = [str rangeOfString:@"," options:NSBackwardsSearch];
//    if (range.length) {
//        // 删掉最后一个,
//        [str deleteCharactersInRange:range];
//    }
//    
//    return str;
//    
//    
//}

- (NSString *)descriptionWithLocale:(nullable id)locale{
    NSString *logString;
    @try {
        logString=[[NSString alloc] initWithData:[NSJSONSerialization dataWithJSONObject:self options:NSJSONWritingPrettyPrinted error:nil] encoding:NSUTF8StringEncoding]; }
    @catch (NSException *exception) {
        NSString *reason = [NSString stringWithFormat:@"reason:%@",exception.reason];
        logString = [NSString stringWithFormat:@"转换失败:\n%@,\n转换终止,输出如下:\n%@",reason,self.description];
    } @finally {
        
    }
    return logString;
}


@end