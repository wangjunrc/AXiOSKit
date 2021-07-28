//
//  _Person.m
//  AXiOSKit
//
//  Created by 小星星吃KFC on 2021/7/28.
//  Copyright © 2021 axinger. All rights reserved.
//

#import "_Person.h"

@implementation _Person

- (NSString *)description {
    return [NSString stringWithFormat:@"{name=%@,age=%ld}",self.name,(long)self.age];
}
-(id)copyWithZone:(NSZone *)zone{
    _Person *model = [_Person allocWithZone:zone];
    model.name = [_name copy];
    model.age = _age;
    return model;
}
-(id)mutableCopyWithZone:(NSZone *)zone{
    _Person *model = [_Person allocWithZone:zone];
    model.name = [_name mutableCopy];
    model.age = _age;
    return model;
}
@end
