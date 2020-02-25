
#import <Foundation/Foundation.h>

#pragma mark - NSDictionary

@implementation NSDictionary (AXLog)

- (NSString *)description {
    return [self ax_descriptionWithLevel:1];
}

- (NSString *)descriptionWithLocale:(nullable id)locale {
    return [self ax_descriptionWithLevel:1];
}
- (NSString *)descriptionWithLocale:(nullable id)locale indent:(NSUInteger)level {
    return [self ax_descriptionWithLevel:(int)level];
}

/**
 * 非字典时，会引发崩溃
 */
- (NSString *)ax_getUTF8String {
    if ([self isKindOfClass:[NSDictionary class]] == NO) {
        return @"";
    }
    NSError *error = nil;
    NSData *data = [NSJSONSerialization dataWithJSONObject:self options:NSJSONWritingPrettyPrinted error:&error];
    if (error) {
        return @"";
    }
    NSString *str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    return str;
}


/**
 将字典转化成字符串，文字格式UTF8,并且格式化
 
 @param level 当前字典的层级，最少为 1，代表最外层字典
 @return 格式化的字符串
 */
- (NSString *)ax_descriptionWithLevel:(int)level {
    NSString *subSpace = [self ax_getSpaceWithLevel:level];
    NSString *space = [self ax_getSpaceWithLevel:level - 1];
    NSMutableString *retString = [[NSMutableString alloc] init];
    // 1、添加 {
    [retString appendString:[NSString stringWithFormat:@"{"]];
    // 2、添加 key : value;
    [self enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[NSString class]]) {
            NSString *value = (NSString *)obj;
            
//            value = [value stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            // utf 解码
           value =  value.stringByRemovingPercentEncoding;
            
            NSString *subString = [NSString stringWithFormat:@"\n%@\"%@\" : \"%@\",", subSpace, key, value];
            [retString appendString:subString];
        } else if ([obj isKindOfClass:[NSDictionary class]]) {
            NSDictionary *dic = (NSDictionary *)obj;
            NSString *str = [dic ax_descriptionWithLevel:level + 1];
            str = [NSString stringWithFormat:@"\n%@\"%@\" : %@,", subSpace, key, str];
            [retString appendString:str];
        } else if ([obj isKindOfClass:[NSArray class]]) {
            NSArray *arr = (NSArray *)obj;
            NSString *str = [arr descriptionWithLocale:nil indent:level + 1];
            str = [NSString stringWithFormat:@"\n%@\"%@\" : %@,", subSpace, key, str];
            [retString appendString:str];
        } else {
            NSString *subString = [NSString stringWithFormat:@"\n%@\"%@\" : %@,", subSpace, key, obj];
            [retString appendString:subString];
        }
    }];
    if ([retString hasSuffix:@","]) {
        [retString deleteCharactersInRange:NSMakeRange(retString.length-1, 1)];
    }
    // 3、添加 }
    [retString appendString:[NSString stringWithFormat:@"\n%@}", space]];
    return retString;
}


/**
 根据层级，返回前面的空格占位符
 
 @param level 字典的层级
 @return 占位空格
 */
- (NSString *)ax_getSpaceWithLevel:(int)level {
    NSMutableString *mustr = [[NSMutableString alloc] init];
    for (int i=0; i<level; i++) {
        [mustr appendString:@"\t"];
    }
    return mustr;
}


@end

#pragma mark - NSSet

@implementation NSSet (AXLog)


- (NSString *)description {
    return [self ax_descriptionWithLevel:1];
}

-(NSString *)descriptionWithLocale:(id)locale
{
    return [self ax_descriptionWithLevel:1];
}

- (NSString *)descriptionWithLocale:(nullable id)locale indent:(NSUInteger)level {
    return [self ax_descriptionWithLevel:(int)level];
}

/**
 将数组转化成字符串，文字格式UTF8,并且格式化
 
 @param level 当前数组的层级，最少为 1，代表最外层
 @return 格式化的字符串
 */
- (NSString *)ax_descriptionWithLevel:(int)level {
    NSString *subSpace = [self ax_getSpaceWithLevel:level];
    NSString *space = [self ax_getSpaceWithLevel:level - 1];
    NSMutableString *retString = [[NSMutableString alloc] init];
    // 1、添加 [
    [retString appendString:[NSString stringWithFormat:@"["]];
    // 2、添加 value
    [self enumerateObjectsUsingBlock:^(id  _Nonnull obj, BOOL * _Nonnull stop) {
        
        if ([obj isKindOfClass:[NSString class]]) {
            NSString *value = (NSString *)obj;
//            value = [value stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            value =  value.stringByRemovingPercentEncoding;
            NSString *subString = [NSString stringWithFormat:@"\n%@\"%@\",", subSpace, value];
            [retString appendString:subString];
        } else if ([obj isKindOfClass:[NSArray class]]) {
            NSSet *arr = (NSSet *)obj;
            NSString *str = [arr ax_descriptionWithLevel:level + 1];
            str = [NSString stringWithFormat:@"\n%@%@,", subSpace, str];
            [retString appendString:str];
        } else if ([obj isKindOfClass:[NSDictionary class]]) {
            NSDictionary *dic = (NSDictionary *)obj;
            NSString *str = [dic descriptionWithLocale:nil indent:level + 1];
            str = [NSString stringWithFormat:@"\n%@%@,", subSpace, str];
            [retString appendString:str];
        } else {
            NSString *subString = [NSString stringWithFormat:@"\n%@%@,", subSpace, obj];
            [retString appendString:subString];
        }
    }];
    if ([retString hasSuffix:@","]) {
        [retString deleteCharactersInRange:NSMakeRange(retString.length-1, 1)];
    }
    // 3、添加 ]
    [retString appendString:[NSString stringWithFormat:@"\n%@]", space]];
    return retString;
}


/**
 根据层级，返回前面的空格占位符
 
 @param level 层级
 @return 占位空格
 */
- (NSString *)ax_getSpaceWithLevel:(int)level {
    NSMutableString *mustr = [[NSMutableString alloc] init];
    for (int i=0; i<level; i++) {
        [mustr appendString:@"\t"];
    }
    return mustr;
}

@end


#pragma mark - NSArray

@implementation NSArray (AXLog)


- (NSString *)description {
    return [self ax_descriptionWithLevel:1];
}

-(NSString *)descriptionWithLocale:(id)locale{
    return [self ax_descriptionWithLevel:1];
}

- (NSString *)descriptionWithLocale:(nullable id)locale indent:(NSUInteger)level {
    return [self ax_descriptionWithLevel:(int)level];
}

/**
 将数组转化成字符串，文字格式UTF8,并且格式化
 
 @param level 当前数组的层级，最少为 1，代表最外层
 @return 格式化的字符串
 */
- (NSString *)ax_descriptionWithLevel:(int)level {
    
    NSString *subSpace = [self ax_getSpaceWithLevel:level];
    NSString *space = [self ax_getSpaceWithLevel:level - 1];
    NSMutableString *retString = [[NSMutableString alloc] init];
    // 1、添加 [
    [retString appendString:[NSString stringWithFormat:@"["]];
    // 2、添加 value
    [self enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[NSString class]]) {
            NSString *value = (NSString *)obj;
//            value = [value stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            value =  value.stringByRemovingPercentEncoding;
            NSString *subString = [NSString stringWithFormat:@"\n%@\"%@\",", subSpace, value];
            [retString appendString:subString];
        } else if ([obj isKindOfClass:[NSArray class]]) {
            NSArray *arr = (NSArray *)obj;
            NSString *str = [arr ax_descriptionWithLevel:level + 1];
            str = [NSString stringWithFormat:@"\n%@%@,", subSpace, str];
            [retString appendString:str];
        } else if ([obj isKindOfClass:[NSDictionary class]]) {
            NSDictionary *dic = (NSDictionary *)obj;
            NSString *str = [dic descriptionWithLocale:nil indent:level + 1];
            str = [NSString stringWithFormat:@"\n%@%@,", subSpace, str];
            [retString appendString:str];
        } else {
            NSString *subString = [NSString stringWithFormat:@"\n%@%@,", subSpace, obj];
            [retString appendString:subString];
        }
    }];
    if ([retString hasSuffix:@","]) {
        [retString deleteCharactersInRange:NSMakeRange(retString.length-1, 1)];
    }
    // 3、添加 ]
    [retString appendString:[NSString stringWithFormat:@"\n%@]", space]];
    return retString;
}


/**
 根据层级，返回前面的空格占位符
 
 @param level 层级
 @return 占位空格
 */
- (NSString *)ax_getSpaceWithLevel:(int)level {
    NSMutableString *mustr = [[NSMutableString alloc] init];
    for (int i=0; i<level; i++) {
        [mustr appendString:@"\t"];
    }
    return mustr;
}

@end

//
//#import <Foundation/Foundation.h>
//
////#define USER_TYPE_ONE
//
//#define descriptionWithLocale_TYPE_JSON \
//- (NSString *)descriptionWithLocale:(nullable id)locale{\
//    NSString *output;\
//    @try {\
//        NSData *data = [NSJSONSerialization dataWithJSONObject:self options:NSJSONWritingPrettyPrinted error:nil];\
//        output=[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding].description;\
//        output = [output stringByReplacingOccurrencesOfString:@"\\/" withString:@"/"];\
//    }\
//    @catch (NSException *exception) {\
//        output = self.description;\
//    } @finally {\
//    }\
//    return output;\
//}\
//
//
//
//@implementation NSDictionary (Log)
//
//#ifdef USER_TYPE_ONE
//
//- (NSString *)descriptionWithLocale:(id)locale indent:(NSUInteger)level{
//    NSMutableString *str = [NSMutableString string];
//    [str appendString:@"{\n"];
//    // 遍历字典的所有键值对
//    [self enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
//        [str appendFormat:@"\t%@ = %@,\n", key, obj];
//    }];
//
//    [str appendString:@"}"];
//    // 查出最后一个,的范围
//    NSRange range = [str rangeOfString:@"," options:NSBackwardsSearch];
//    if (range.length) {
//        // 删掉最后一个,
//        [str deleteCharactersInRange:range];
//    }
//    return str;
//}
//
//#else
//
////- (NSString *)descriptionWithLocale:(nullable id)locale indent:(NSUInteger)level{
////    NSString *output;
////    @try {
////        NSData *data = [NSJSONSerialization dataWithJSONObject:self options:NSJSONWritingPrettyPrinted error:nil];
////        output=[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding].description;
////        output = [output stringByReplacingOccurrencesOfString:@"\\/" withString:@"/"];
////    }
////    @catch (NSException *exception) {
////        output = self.description;
////    } @finally {
////
////    }
////    return output;
////}
//descriptionWithLocale_TYPE_JSON
//#endif
//
//@end
//
//@implementation NSSet (Log)
//
//#ifdef USER_TYPE_ONE
//
//- (NSString *)descriptionWithLocale:(id)locale{
//    NSMutableString *str = [NSMutableString string];
//    [str appendString:@"[\n"];
//
//
//    [self enumerateObjectsUsingBlock:^(id  _Nonnull obj, BOOL * _Nonnull stop) {
//        [str appendFormat:@"%@,\n", obj];
//    }];
//
//
//    [str appendString:@"]"];
//    // 查出最后一个,的范围
//    NSRange range = [str rangeOfString:@"," options:NSBackwardsSearch];
//    if (range.length) {
//        // 删掉最后一个,
//        [str deleteCharactersInRange:range];
//    }
//    return str;
//}
//
//#else
//
////- (NSString *)descriptionWithLocale:(nullable id)locale{
////    NSString *output;
////    @try {
////
////        NSData *data = [NSJSONSerialization dataWithJSONObject:self options:NSJSONWritingPrettyPrinted error:nil];
////        output=[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding].description;
////
////        output = [output stringByReplacingOccurrencesOfString:@"\\/" withString:@"/"];
////    }
////    @catch (NSException *exception) {
////        output = self.description;
////    } @finally {
////
////    }
////    return output;
////}
//descriptionWithLocale_TYPE_JSON
//#endif
//@end
//
//@implementation NSArray (Log)
//
//#ifdef USER_TYPE_ONE
//
//- (NSString *)descriptionWithLocale:(id)locale{
//    NSMutableString *str = [NSMutableString string];
//    [str appendString:@"[\n"];
//
//    // 遍历数组的所有元素 enumerateObjectsUsingBlock
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
//    return str;
//}
//
//#else
//
////- (NSString *)descriptionWithLocale:(nullable id)locale{
////    NSString *output;
////    @try {
////
////        NSData *data = [NSJSONSerialization dataWithJSONObject:self options:NSJSONWritingPrettyPrinted error:nil];
////        output=[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding].description;
////
////        output = [output stringByReplacingOccurrencesOfString:@"\\/" withString:@"/"];
////    }
////    @catch (NSException *exception) {
////        output = self.description;
////    } @finally {
////
////    }
////    return output;
////}
//descriptionWithLocale_TYPE_JSON
//
//#endif
//
//@end
//

