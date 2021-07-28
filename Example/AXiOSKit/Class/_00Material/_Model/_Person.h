//
//  _Person.h
//  AXiOSKit
//
//  Created by 小星星吃KFC on 2021/7/28.
//  Copyright © 2021 axinger. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface _Person : NSObject<NSMutableCopying,NSCopying>

@property (nonatomic, copy) NSString *name;
@property (nonatomic, assign) NSInteger age;


@end

NS_ASSUME_NONNULL_END
