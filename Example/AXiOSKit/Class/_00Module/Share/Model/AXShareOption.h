//
//  DLSharePopAction.h
//  DLAppStore
//
//  Created by 小星星吃KFC on 2021/4/30.
//  Copyright © 2021 axinger. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AXShareType.h"

NS_ASSUME_NONNULL_BEGIN

@interface AXShareOption : NSObject

@property(nonatomic, copy) NSString *title;

@property(nonatomic, copy) NSString *appName;

/// 下载地址
@property(nonatomic, copy) NSString *appLink;

@property(nonatomic, copy) NSString *iconName;

@property(nonatomic, copy) AXShareType type;

@property(nonatomic, copy) void(^didBlock)(AXShareType type);


@end

NS_ASSUME_NONNULL_END
