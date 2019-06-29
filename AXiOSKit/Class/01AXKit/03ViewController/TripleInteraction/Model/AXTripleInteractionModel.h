//
//  AXTripleInteractionModel.h
//  AXiOSKit
//
//  Created by AXing on 2019/6/29.
//  Copyright © 2019 liu.weixing. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AXTripleInteractionModel : NSObject

@property(nonatomic, copy) NSString *code;

@property(nonatomic, copy) NSString *name;

@end

@interface AXTripleIndexPath : NSObject

+ (instancetype)indexPathForType:(NSInteger)type
                     firsSubject:(NSInteger)firsSubject
                   secondSubject:(NSInteger)secondSubject;


@property (nonatomic, readonly) NSInteger type;

@property (nonatomic, readonly) NSInteger firsSubject;

@property (nonatomic, readonly) NSInteger secondSubject;

@end


///三级
@interface AXTripleInteractionThirdLevelModel : AXTripleInteractionModel

@end

///二级科目
@interface AXTripleInteractionSecondLevelModel : AXTripleInteractionModel

///三级 Array
@property(nonatomic, strong) NSArray<AXTripleInteractionSecondLevelModel *> *secondLevel;

@end

/// 一级
@interface AXTripleInteractionFirstLevelModel : AXTripleInteractionModel

///二级 Array
@property(nonatomic, strong) NSArray<AXTripleInteractionSecondLevelModel *> *firstLevel;

@end



NS_ASSUME_NONNULL_END
