//
//  NSObject+performSelector.h
//  AXiOSKit_Example
//
//  Created by 小星星吃KFC on 2020/10/26.
//  Copyright © 2020 axinger. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (performSelector)
- (id)performSelector:(SEL)selector withObjects:(NSArray *)objects;

@end

NS_ASSUME_NONNULL_END
