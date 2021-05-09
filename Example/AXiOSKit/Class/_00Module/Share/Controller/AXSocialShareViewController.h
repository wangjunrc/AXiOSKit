//
//  AXShareUIViewController.h
//  AXiOSKitExample
//
//  Created by 小星星吃KFC on 2021/4/30.
//  Copyright © 2021 axinger. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AXSharePlatform.h"
#import "AXUserSwiftImport.h"
NS_ASSUME_NONNULL_BEGIN

@interface AXSocialShareViewController : UIViewController


/// 分享类型 DLSharePopActionType ,init默认全部
/// @param types DLSharePopActionType 
-(instancetype )initWithShareType:(NSArray<AXSharePlatform >*)types;

//-(void)test:(DLShareAllType *)type;

@end

NS_ASSUME_NONNULL_END
