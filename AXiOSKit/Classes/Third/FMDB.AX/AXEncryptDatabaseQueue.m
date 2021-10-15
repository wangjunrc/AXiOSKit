//
//  AXEncryptDatabaseQueue.m
//  AXiOSKit
//
//  Created by axinger on 2021/10/15.
//

#import "AXEncryptDatabaseQueue.h"


@implementation AXEncryptDatabase
- (BOOL)open {
    BOOL res = [self open];
    res = [self setKey:@"abc123"];
    return res;
}
@end

@implementation AXEncryptDatabaseQueue

+ (Class)databaseClass{
    return [AXEncryptDatabase class];
}

@end
