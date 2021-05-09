//
//  AXSharePlatform.h
//  AXiOSKitExample
//
//  Created by 小星星吃KFC on 2021/5/8.
//  Copyright © 2021 axinger. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NSString*const AXSharePlatform;

/// 微信会话
FOUNDATION_EXTERN AXSharePlatform AXSharePlatformWeiChatSession;
/// 微信朋友圈
FOUNDATION_EXTERN AXSharePlatform AXSharePlatformWeiChatTimeLine;
/// 新浪微博
FOUNDATION_EXTERN AXSharePlatform AXSharePlatformSinaWeibo;
/// QQ好友 friends
FOUNDATION_EXTERN AXSharePlatform AXSharePlatformQQFriends;
/// 短信
FOUNDATION_EXTERN AXSharePlatform AXSharePlatformPhoneMessage;
/// 二维码
FOUNDATION_EXTERN AXSharePlatform AXSharePlatformQRCode;


