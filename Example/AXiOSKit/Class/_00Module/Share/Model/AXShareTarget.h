//
//  AXShareTarget.h
//  AXiOSKitExample
//
//  Created by 小星星吃KFC on 2021/5/8.
//  Copyright © 2021 axinger. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NSString*const AXShareTarget;

/// 微信会话
FOUNDATION_EXTERN AXShareTarget AXShareTargetWeiChatSession;
/// 微信朋友圈
FOUNDATION_EXTERN AXShareTarget AXShareTargetWeiChatTimeLine;
/// 新浪微博
FOUNDATION_EXTERN AXShareTarget AXShareTargetSinaWeibo;
/// QQ好友 friends
FOUNDATION_EXTERN AXShareTarget AXShareTargetQQFriends;
/// 短信
FOUNDATION_EXTERN AXShareTarget AXShareTargetPhoneMessage;
/// 二维码
FOUNDATION_EXTERN AXShareTarget AXShareTargetQRCode;


