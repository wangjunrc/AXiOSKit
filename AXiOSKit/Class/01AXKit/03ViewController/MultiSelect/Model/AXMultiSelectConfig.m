//
//  AXMultiSelectConfig.m
//  AXiOSKit
//
//  Created by AXing on 2019/6/27.
//  Copyright © 2019 liu.weixing. All rights reserved.
//

#import "AXMultiSelectConfig.h"

@implementation AXMultiSelectConfig

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.column = 1;
        self.allowsMultipleSelection = YES;
        self.allowsSectionSelection = NO;
        self.needSectionHeader = YES;
        self.allowsSelectionEmpty = YES;
    }
    return self;
}

@end
