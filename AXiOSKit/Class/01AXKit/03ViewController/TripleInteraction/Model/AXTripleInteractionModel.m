//
//  AXTripleInteractionModel.m
//  AXiOSKit
//
//  Created by AXing on 2019/6/29.
//  Copyright © 2019 liu.weixing. All rights reserved.
//

#import "AXTripleInteractionModel.h"

@implementation AXTripleInteractionModel

@end


@interface AXTripleIndexPath ()

@property (nonatomic, readwrite) NSInteger type;

@property (nonatomic, readwrite) NSInteger firsSubject;

@property (nonatomic, readwrite) NSInteger secondSubject;


@end

@implementation AXTripleIndexPath

+ (instancetype)indexPathForType:(NSInteger)type
                     firsSubject:(NSInteger)firsSubject
                   secondSubject:(NSInteger)secondSubject {
    
    AXTripleIndexPath *path = [[self alloc]init];
    path.type = type;
    path.firsSubject = firsSubject;
    path.secondSubject = secondSubject;
    return  path;
}

@end


@implementation AXTripleInteractionThirdLevelModel

@end

@implementation AXTripleInteractionSecondLevelModel

@end

@implementation AXTripleInteractionFirstLevelModel

@end
