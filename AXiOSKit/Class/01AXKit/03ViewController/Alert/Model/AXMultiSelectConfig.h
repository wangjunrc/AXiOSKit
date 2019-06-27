//
//  AXMultiSelectConfig.h
//  AXiOSKit
//
//  Created by AXing on 2019/6/27.
//  Copyright © 2019 liu.weixing. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AXMultiSelectConfig : NSObject

/// 列数 默认1列
@property(nonatomic, assign) NSUInteger column;

/// 是否多选 默认 YES
@property(nonatomic, assign,getter=isAllowsMultipleSelection) BOOL allowsMultipleSelection;

/// Section 区 是否多选 默认NO
@property(nonatomic, assign,getter=isAllowsSectionSelection) BOOL allowsSectionSelection;

/// 是否需要分区 头  默认 YES
@property(nonatomic, assign,getter=isNeedSectionHeader) BOOL needSectionHeader;

/// 是否可以选择空 默认 YES
@property(nonatomic, assign,getter=isAllowsSelectionEmpty) BOOL allowsSelectionEmpty;

@end

NS_ASSUME_NONNULL_END
