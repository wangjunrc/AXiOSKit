//
//  _22LoginViewModel.h
//  AXiOSKit_Example
//
//  Created by 小星星吃KFC on 2021/7/9.
//  Copyright © 2021 axinger. All rights reserved.
//

#import <Foundation/Foundation.h>
@import ReactiveObjC;

NS_ASSUME_NONNULL_BEGIN

@interface _22LoginViewModel : NSObject

@property (nonatomic,copy) NSString *username;
@property (nonatomic,copy) NSString *password;
@property (nonatomic,readonly) RACCommand *loginCommand;




@end

NS_ASSUME_NONNULL_END
