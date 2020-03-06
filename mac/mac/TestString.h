//
//  TestString.h
//  mac
//
//  Created by liuweixing on 2020/3/6.
//  Copyright © 2020 liuweixing. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TestString : NSObject


@property(nonatomic, strong) NSString *strongStr;

@property(nonatomic, copy) NSString *copyedStr;


@property(nonatomic, strong) NSMutableString *strongStrM;

@property(nonatomic, copy) NSMutableString *copyedStrM;


@end

NS_ASSUME_NONNULL_END
