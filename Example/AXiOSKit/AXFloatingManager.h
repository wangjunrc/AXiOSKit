//
//  AXFloatingManager.h
//  AXiOSKit_Example
//
//  Created by 小星星吃KFC on 2020/12/21.
//  Copyright © 2020 axinger. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AXiOSKit/AXiOSKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface AXFloatingManager : NSObject

axShared_H(Manager)

- (void)start;

- (void)startInWindow:(UIWindow *_Nullable)window;

@end

NS_ASSUME_NONNULL_END
