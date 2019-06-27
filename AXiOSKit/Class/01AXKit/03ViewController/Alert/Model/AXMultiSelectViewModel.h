//
//  AXMultiSelectViewModel.h
//  AXiOSKit
//
//  Created by AXing on 2019/6/27.
//  Copyright © 2019 liu.weixing. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AXMultiSelectRowViewModel : NSObject

@property(nonatomic, copy) NSString *title;

@property(nonatomic, assign) BOOL selected;

@end

@interface AXMultiSelectViewModel : NSObject

@property(nonatomic, copy) NSString *sectionTitle;

@property(nonatomic, copy) NSArray <AXMultiSelectRowViewModel * > *rowArray;


@end

NS_ASSUME_NONNULL_END
