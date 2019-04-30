//
//  NSError+AXTool.h
//  AXiOSKit
//
//  Created by AXing on 2019/2/28.
//  Copyright © 2019 liu.weixing. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSError (AXTool)

+(instancetype)ax_errorWithDescription:(NSString *)description;

@end

NS_ASSUME_NONNULL_END
