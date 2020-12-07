//
//  _25DataModel.h
//  AXiOSKit_Example
//
//  Created by 小星星吃KFC on 2020/12/7.
//  Copyright © 2020 axinger. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface _25DataModel : NSObject

@property(nonatomic, copy) NSString *title;

@property(nonatomic, assign,getter=isEditing) BOOL editing;

@end

NS_ASSUME_NONNULL_END
