//
//  AXNetManager+Group.h
//  BigApple
//
//  Created by Mole Developer on 2017/11/15.
//  Copyright © 2017年 MoleDeveloper. All rights reserved.
//

#import "AXNetManager.h"
#import "AXNetGroup.h"

@interface AXNetManager (Group)

+ (void)postGroup:(NSArray<AXNetGroup *> *)group complete:(void(^)(NSArray<AXNetGroupResult *> *results))complete isLog:(BOOL )log;

@end
