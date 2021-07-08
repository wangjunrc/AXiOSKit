//
//  AXUserIp.h
//  AXiOSKit
//
//  Created by 小星星吃KFC on 2020/11/17.
//  Copyright © 2020 axinger. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AXUserLog.h"

NS_ASSUME_NONNULL_BEGIN
/// 嵌套对象,序列化json
@interface AXUserLog : NSObject

@property(nonatomic,assign)NSInteger logId;

@property(nonatomic,copy)NSString *ip;

@property(nonatomic,copy)NSString *address;

@end

NS_ASSUME_NONNULL_END
