//
//  Person.m
//  mac
//
//  Created by liuweixing on 2020/1/1.
//  Copyright © 2020 liuweixing. All rights reserved.
//

#import "Person.h"

@implementation Person
-(void)logShowTest{
    NSLog(@"logShowTest>>>");
    
}

- (id)copyWithZone:(nullable NSZone *)zone {

//    Person *p = [[Person alloc]init];
//    p.name = self.name.copy;
//    return p;
    return self;;
    
}
@end
