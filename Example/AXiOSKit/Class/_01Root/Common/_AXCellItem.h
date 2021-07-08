//
//  _AXCellItem.h
//  AXiOSKit
//
//  Created by 小星星吃KFC on 2021/5/27.
//  Copyright © 2021 axinger. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface _AXCellItem : NSObject

@property(nonatomic, copy) NSString *title;
@property(nonatomic, copy) NSString *detail;
@property(nonatomic, copy) NSString *imgName;
@property(nonatomic, copy) void(^action)(void);

@end

NS_ASSUME_NONNULL_END
