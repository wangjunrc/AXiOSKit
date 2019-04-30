//
//  AXDataModel.m
//  AXKit
//
//  Created by AXing on 2018/11/17.
//  Copyright © 2018 liuweixing. All rights reserved.
//

#import "AXDataModel.h"

@implementation AXDataModel

- (NSMutableArray *)dataSourceArray {
    if (nil == _dataSourceArray) {
        _dataSourceArray = [[NSMutableArray alloc]init];
    }
    return _dataSourceArray;
}
@end
