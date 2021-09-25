//
//  NSError+AXKit.h
//  AXiOSKit
//
//  Created by axing on 2019/2/28.
//  Copyright © 2019 liu.weixing. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSError (AXKit)

+(instancetype)ax_errorWithDescription:(NSString *)description;

@end

NS_ASSUME_NONNULL_END
