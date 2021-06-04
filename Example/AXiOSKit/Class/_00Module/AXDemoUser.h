//
//  AXDemoUser.h
//  AXiOSKit_Example
//
//  Created by 小星星吃KFC on 2021/6/4.
//  Copyright © 2021 axinger. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AXiOSKit/AXMacros_instance.h>
NS_ASSUME_NONNULL_BEGIN

@interface AXDemoUser : NSObject

AX_SINGLETON_INTER(User)

+ (AXDemoUser *)testName;



@end

NS_ASSUME_NONNULL_END
