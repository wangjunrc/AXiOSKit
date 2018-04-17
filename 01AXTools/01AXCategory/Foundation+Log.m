
#import <Foundation/Foundation.h>

//#define USER_TYPE_ONE 1


@implementation NSDictionary (Log)


#if USER_TYPE_ONE

- (NSString *)descriptionWithLocale:(id)locale{
    NSMutableString *str = [NSMutableString string];
    
    [str appendString:@"{\n"];
    
    // 遍历字典的所有键值对
    [self enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        [str appendFormat:@"\t%@ = %@,\n", key, obj];
    }];
    
    [str appendString:@"}"];
    
    // 查出最后一个,的范围
    NSRange range = [str rangeOfString:@"," options:NSBackwardsSearch];
    if (range.length) {
        // 删掉最后一个,
        [str deleteCharactersInRange:range];
    }
    
    return str;
}

#else

- (NSString *)descriptionWithLocale:(nullable id)locale{
    NSString *output;
    @try {
        NSData *data = [NSJSONSerialization dataWithJSONObject:self options:NSJSONWritingPrettyPrinted error:nil];
        output=[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        output = [output stringByReplacingOccurrencesOfString:@"\\/" withString:@"/"];
    }
    @catch (NSException *exception) {
        
        output = self.description;
        
    } @finally {
        
    }
    return output;
}

#endif

@end


@implementation NSArray (Log)

#if USER_TYPE_ONE

- (NSString *)descriptionWithLocale:(id)locale{
    NSMutableString *str = [NSMutableString string];
    [str appendString:@"[\n"];
    
    // 遍历数组的所有元素
    [self enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [str appendFormat:@"%@,\n", obj];
    }];
    
    [str appendString:@"]"];
    // 查出最后一个,的范围
    NSRange range = [str rangeOfString:@"," options:NSBackwardsSearch];
    if (range.length) {
        // 删掉最后一个,
        [str deleteCharactersInRange:range];
    }
    return str;
}

#else

- (NSString *)descriptionWithLocale:(nullable id)locale{
    NSString *output;
    @try {
        NSData *data = [NSJSONSerialization dataWithJSONObject:self options:NSJSONWritingPrettyPrinted error:nil];
        output=[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        output = [output stringByReplacingOccurrencesOfString:@"\\/" withString:@"/"];
    }
    @catch (NSException *exception) {
        output = self.description;
    } @finally {
        
    }
    return output;
}

#endif

@end
