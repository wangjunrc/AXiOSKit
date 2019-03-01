//
//  Student.m
//  AXiOSToolsExample
//
//  Created by AXing on 2019/2/28.
//  Copyright © 2019 liu.weixing. All rights reserved.
//

#import "Student.h"
#import "Person.h"
@implementation Student
- (instancetype)init
{
    self = [super init];
    if (self) {
       
    }
    return self;
}
- (void)dealloc{
    [Person sharedCancel];
    axLong_dealloc;
}
- (void)setAge:(NSString *)age{
    _age = age;
    if (self != [Person sharedInstance].student) {
         [Person sharedInstance].student.age = age.copy;
    }
   
}
@end
