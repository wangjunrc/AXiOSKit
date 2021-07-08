//
//  _30TimeLineModel.m
//  AXiOSKit_Example
//
//  Created by 小星星吃KFC on 2020/11/24.
//  Copyright © 2020 axinger. All rights reserved.
//

#import "_30TimeLineModel.h"


@implementation _30TimeLineModel

-(id<NSObject>)diffIdentifier{
    return self;
}
-(BOOL)isEqualToDiffableObject:(id<IGListDiffable>)object{
    return [self isEqual:object];
}


@end
