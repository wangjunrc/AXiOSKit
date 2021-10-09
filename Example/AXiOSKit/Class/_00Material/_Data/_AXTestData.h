//
//  _AXTestData.h
//  AXiOSKit_Example
//
//  Created by axinger on 2021/10/9.
//  Copyright © 2021 axinger. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface _AXImgModel : NSObject

@property(nonatomic, copy) NSString *title;
@property(nonatomic, copy) NSString *url;

@end


@interface _AXTestData : NSObject

+(NSArray<_AXImgModel *> *)imgModelsWithCount:(NSInteger )count;

@end

NS_ASSUME_NONNULL_END
