//
//  VDPersonModel.h
//  TestMac
//
//  Created by 小星星吃KFC on 2021/7/8.
//

#import <Foundation/Foundation.h>
//#import "MTLModel.h"
//#import "MTLJSONAdapter.h"
//#import "MTLValueTransformer.h"
//#import "NSValueTransformer+MTLPredefinedTransformerAdditions.h"

#import <Mantle/Mantle.h>
NS_ASSUME_NONNULL_BEGIN

@interface VDPersonModel : MTLModel <MTLJSONSerializing>

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSDate *birthday;
@property (nonatomic) NSUInteger age;

@end

NS_ASSUME_NONNULL_END
