//
//  AXShareUIViewController.h
//  DLAppStore
//
//  Created by 小星星吃KFC on 2021/4/30.
//  Copyright © 2021 axinger. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AXShareType.h"
#import "AXUserSwiftImport.h"
NS_ASSUME_NONNULL_BEGIN

@interface AXShareUIViewController : UIViewController


/// 分享类型 DLSharePopActionType ,init默认全部
/// @param types DLSharePopActionType 
-(instancetype )initWithShareType:(NSArray<AXShareType >*)types;

//-(void)test:(DLShareAllType *)type;

@end

NS_ASSUME_NONNULL_END
