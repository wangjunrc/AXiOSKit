//
//  ChatMessageModel.h
//  AXiOSKitExample
//
//  Created by liuweixing on 2020/1/5.
//  Copyright © 2020 liu.weixing. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ChatMessageModel : NSObject

@property(nonatomic,assign)NSInteger toUserId;
@property(nonatomic,assign)NSInteger userid;
@property(nonatomic,copy)NSString *content;

@end

NS_ASSUME_NONNULL_END
