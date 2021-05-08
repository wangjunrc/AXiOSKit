//
//  AXShareType.h
//  DLAppStore
//
//  Created by 小星星吃KFC on 2021/5/8.
//  Copyright © 2021 axinger. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NSString*const AXShareType;

/// 微信会话
FOUNDATION_EXTERN AXShareType AXShareTypeWeiChatSession;
/// 微信朋友圈
FOUNDATION_EXTERN AXShareType AXShareTypeWeiChatTimeLine;
/// 新浪微博
FOUNDATION_EXTERN AXShareType AXShareTypeSinaWeibo;
/// QQ好友 friends
FOUNDATION_EXTERN AXShareType AXShareTypeQQFriends;
/// 短信
FOUNDATION_EXTERN AXShareType AXShareTypePhoneMessage;
/// 二维码
FOUNDATION_EXTERN AXShareType AXShareTypeQRCode;


