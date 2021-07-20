//
//  NSString+AXURL.m
//  AXiOSKit
//
//  Created by 小星星吃KFC on 2021/6/29.
//

#import "NSString+AXURL.h"

@implementation NSString (AXURL)

-(NSDictionary<NSString*,NSString*>  *)ax_URLComponents {
    NSString *url = self;
    /// 编解码中文等特殊字符
    url= [url stringByAddingPercentEncodingWithAllowedCharacters:NSCharacterSet.URLQueryAllowedCharacterSet];
    NSMutableDictionary<NSString*,NSString*>  *dict = [NSMutableDictionary dictionary];
    NSURLComponents *components = [NSURLComponents componentsWithString:url];
    [components.queryItems enumerateObjectsUsingBlock:^(NSURLQueryItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        dict[obj.name] = obj.value;
    }];
    return dict;
}

/// 添加URL参数,返回url 字符串
/// @param params 参数
-(NSString *)ax_addingURLParams:(NSDictionary<NSString*,NSString*>*)params {
    NSString *url = self;
    NSURLComponents *components =  [NSURLComponents componentsWithString:url];
    NSMutableArray<NSURLQueryItem *> *tempArray = NSMutableArray.array;
    [tempArray addObjectsFromArray:components.queryItems];
    /// 移除 已经存在的,会被替换
    [tempArray enumerateObjectsUsingBlock:^(NSURLQueryItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (params[obj.name]) {
            [tempArray removeObject:obj];
        }
    }];
    [params enumerateKeysAndObjectsUsingBlock:^(NSString *name, id value, BOOL *stop) {
        value = [value description];
        value = [value stringByAddingPercentEncodingWithAllowedCharacters:NSCharacterSet.URLQueryAllowedCharacterSet];
        NSURLQueryItem *item = [NSURLQueryItem queryItemWithName:name value:value];
        [tempArray addObject:item];
    }];
    components.queryItems = tempArray.copy;
    return components.URL.absoluteString;
}

@end
