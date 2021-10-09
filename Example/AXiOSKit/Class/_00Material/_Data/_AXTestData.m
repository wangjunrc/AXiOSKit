//
//  _AXTestData.m
//  AXiOSKit_Example
//
//  Created by axinger on 2021/10/9.
//  Copyright © 2021 axinger. All rights reserved.
//

#import "_AXTestData.h"

@implementation _AXImgModel

@end

@implementation _AXTestData

+(NSArray<_AXImgModel *> *)imgModelsWithCount:(NSInteger )count  {
    
    NSMutableArray<_AXImgModel *> *temp = [NSMutableArray arrayWithCapacity:count];
    
    for (NSInteger idx = 0; idx<count; idx++) {
        
        _AXImgModel *model = _AXImgModel.alloc.init;
        [temp addObject:model];
        
        model.title = [NSString stringWithFormat:@"title_%ld",idx];
        model.url = [NSString stringWithFormat:@"https://via.placeholder.com/300x200/1296db?text=%@",model.title];
        
    }
    
    return temp;
}


@end
