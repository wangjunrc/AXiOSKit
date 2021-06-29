//
//  AXiOSKitTests.m
//  AXiOSKitTests
//
//  Created by axinger on 10/21/2020.
//  Copyright (c) 2020 axinger. All rights reserved.
//
// https://github.com/kiwi-bdd/Kiwi
#import "AXTestViewController.h"

SPEC_BEGIN(InitialTests)

describe(@"My initial tests", ^{
    
//    context(@"will fail", ^{
//
//        it(@"can do maths", ^{
//            [[@1 should] equal:@2];
//        });
//
//        it(@"can read", ^{
//            [[@"number" should] equal:@"string"];
//        });
//
//        it(@"will wait and fail", ^{
//            NSObject *object = [[NSObject alloc] init];
//            [[expectFutureValue(object) shouldEventually] receive:@selector(autoContentAccessingProxy)];
//        });
//    });
//
//    context(@"will pass", ^{
//
//        it(@"can do maths", ^{
//            [[@1 should] beLessThan:@23];
//        });
//
//        it(@"can read", ^{
//            [[@"team" shouldNot] containString:@"I"];
//        });
//    });
//
    
    
    context(@"will pass", ^{
        
        //当前scope内部的所有的其他block运行之前调用一次
        beforeAll(^{
        });
        
        //当前scope内部的所有的其他block运行之后调用一次
        afterAll(^{
        });
        
        __block AXTestViewController*vc = nil;
        //在scope内的每个it之前调用一次，对于context的配置代码应该写在这里
        beforeEach(^{
            vc = [AXTestViewController new];
        });
        
        //在scope内的每个it之后调用一次，用于清理测试后的代码
        afterEach(^{
            vc = nil;
        });
        
        //测试代码写在这里
        it(@"test message addA andB", ^{
            [[theValue([vc addA:1 andB:2]) should] equal: theValue(3)];
        });
        
    });
    
});

SPEC_END

