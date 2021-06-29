//
//  NSString+AXURL.h
//  AXiOSKit
//
//  Created by 小星星吃KFC on 2021/6/29.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (AXURL)

/// url 解析参数
@property(nonatomic, strong,readonly)NSDictionary<NSString*,NSString*>  *ax_URLComponents;


/// 添加URL参数,返回url 字符串
/// @param params 参数
-(NSString *)ax_addingURLParams:(NSDictionary<NSString*,NSString*>*)params;


@end

NS_ASSUME_NONNULL_END
