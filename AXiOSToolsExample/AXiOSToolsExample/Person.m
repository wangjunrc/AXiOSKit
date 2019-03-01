//
//  Person.m
//  AXiOSToolsExample
//
//  Created by AXing on 2019/2/28.
//  Copyright © 2019 liu.weixing. All rights reserved.
//

#import "Person.h"

@implementation Person
axSharedInstance_M
axSharedCancel_M

- (Student *)student {
    if (!_student) {
        _student = [[Student alloc]init];
    }
    return _student;
}
@end
