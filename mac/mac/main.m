//
//  main.m
//  mac
//
//  Created by liuweixing on 2020/1/1.
//  Copyright © 2020 liuweixing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TestString.h"
#import "Person.h"
#import "Person+a2.h"
#import "Person+a1.h"
void test1(){
    
    [Person add:@"1",@"2",nil ];
    
    
    TestString *test = [[TestString alloc]init];
    
    NSMutableString *testStr = [NSMutableString stringWithFormat:@"11"];
    /// 因为 NSMutableString 为子集,所以可以赋值给 NSString 不报错
    test.strongStr = testStr;
    test.copyedStr = testStr;
    
    NSLog(@"修改值前:");
    NSLog(@"testStr=%p,valyue = %@", testStr,testStr);
    
    NSLog(@"strongStr=%p,valyue = %@", test.strongStr,test.strongStr);
    
    NSLog(@"copyedStr=%p,valyue = %@", test.copyedStr,test.copyedStr);
    
    /// 通过可变集合方式修改值,地址不变
    [testStr appendString:@"22"];
    
    NSLog(@"修改值-可变集合修改:");
    /// testStr 为可变集合时候,通过可变集合修改,地址不变,值改变
    NSLog(@"testStr=%p,valyue = %@", testStr,testStr);
    /// strongStr ,因为是浅拷贝,通过可变集合修改,也会被同时修改
    NSLog(@"strongStr=%p,valyue = %@", test.strongStr,test.strongStr);
    /// copyedStr 因为是深拷贝,通过可变集合修改,不会被修改
    NSLog(@"copyedStr=%p,valyue = %@", test.copyedStr,test.copyedStr);
    
    /// testStr 为可变集合时候,直接赋值,重新新建地址
    testStr = @"22".copy;
    NSLog(@"修改值后-直接修改:");
    /// testStr 为可变集合时候,直接地址会改变
    NSLog(@"testStr=%p,valyue = %@", testStr,testStr);
    /// strongStr ,因为是浅拷贝,直接赋值,不会被改变
    NSLog(@"strongStr=%p,valyue = %@", test.strongStr,test.strongStr);
    /// copyedStr 因为是深拷贝,直接赋值,不会被改变
    NSLog(@"copyedStr=%p,valyue = %@", test.copyedStr,test.copyedStr);
}


void test2(){
    
    TestString *test = [[TestString alloc]init];
    
    NSString *testStr = [NSString stringWithFormat:@"11"];
    /// 因为 NSMutableString 为子集,所以可以赋值给 NSString 不报错
    test.strongStr = testStr;
    test.copyedStr = testStr;
    
    NSLog(@"修改值前:");
    NSLog(@"testStr=%p,valyue = %@", testStr,testStr);
    
    NSLog(@"strongStr=%p,valyue = %@", test.strongStr,test.strongStr);
    
    NSLog(@"copyedStr=%p,valyue = %@", test.copyedStr,test.copyedStr);
    
    /// 通过可变集合方式修改值,地址不变
    
    testStr = @"22";
    NSLog(@"修改值后:");
    /// testStr 为可变集合时候,通过可变集合修改,
    NSLog(@"testStr=%p,valyue = %@", testStr,testStr);
    /// strongStr ,因为是浅拷贝,也会被同时修改
    NSLog(@"strongStr=%p,valyue = %@", test.strongStr,test.strongStr);
    /// copyedStr 因为是深拷贝,不会被修改
    NSLog(@"copyedStr=%p,valyue = %@", test.copyedStr,test.copyedStr);
}



int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        //
        //        //                     NSString *testStr = [NSString stringWithFormat:@"123"];
        //
        //
        //        TestString *test = [[TestString alloc]init];
        //
        //        NSMutableString *testStr = [NSMutableString stringWithFormat:@"11"];
        //        /// 因为 NSMutableString 为子集,所以可以赋值给 NSString 不报错
        //        test.strongStr = testStr;
        //        test.copyedStr = testStr;
        //
        //        NSLog(@"修改值前:");
        //        NSLog(@"testStr=%p,valyue = %@", testStr,testStr);
        //
        //        NSLog(@"strongStr=%p,valyue = %@", test.strongStr,test.strongStr);
        //
        //        NSLog(@"copyedStr=%p,valyue = %@", test.copyedStr,test.copyedStr);
        //
        //        /// 通过可变集合方式i修改 值,
        //        [testStr appendString:@"22"];
        //
        //        NSLog(@"修改值后:");
        //        /// testStr 为可变集合时候,通过可变集合修改,
        //        NSLog(@"testStr=%p,valyue = %@", testStr,testStr);
        //        /// strongStr ,因为是浅拷贝,也会被同时修改
        //        NSLog(@"strongStr=%p,valyue = %@", test.strongStr,test.strongStr);
        //        /// copyedStr 因为是深拷贝,不会被修改
        //        NSLog(@"copyedStr=%p,valyue = %@", test.copyedStr,test.copyedStr);
        
        
        //        test1();
        //        test2();
        
        
        //        Person *person = [[Person alloc]init];
        //        person.name = @"a";
        //         NSLog(@"person %@",person.name);
        ////        Person *person2 = person.copy;
        //
        //        NSLog(@"person %@",person.name);
        //
        //        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        //        [dict setObject:@"a1" forKey:person];
        //         [dict setObject:@"a2" forKey:person];
        
        dispatch_queue_t queue1 =    dispatch_queue_create("com.wynter.customQueue", DISPATCH_QUEUE_PRIORITY_DEFAULT);
        
//        dispatch_queue_t queue1 =    dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        
//         NSLog(@"queue1 =  %@",queue1);
        
         
//         dispatch_barrier_async(queue1, ^{
//        　　 NSLog(@"async:5 %@",[NSThread currentThread]);
//         });
//
//
//        dispatch_async(queue1, ^{
//            NSLog(@"async:1 %@",[NSThread currentThread]);
//
//        });
//
//      NSLog(@"async:2 %@",[NSThread currentThread]);
//        dispatch_async(queue1, ^{
//            NSLog(@"async:3 %@",[NSThread currentThread]);
//        });
//        NSLog(@"async:4 %@",[NSThread currentThread]);
        
        
//        dispatch_queue_create("com.wynter.customQueue", DISPATCH_QUEUE_PRIORITY_DEFAULT);
   
        
        dispatch_queue_t concurrentQueue = dispatch_queue_create("my.concurrent.queue", DISPATCH_QUEUE_CONCURRENT);
        dispatch_async(concurrentQueue, ^(){
            NSLog(@"dispatch-1");
        });
        dispatch_async(concurrentQueue, ^(){
            NSLog(@"dispatch-2");
        });
        dispatch_barrier_async(concurrentQueue, ^(){
            NSLog(@"dispatch-barrier");
        });
        dispatch_async(concurrentQueue, ^(){
            NSLog(@"dispatch-3");
        });
        dispatch_async(concurrentQueue, ^(){
            NSLog(@"dispatch-4");
        });
        
        return 0;
        
//        dispatch_queue_t queue1 = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        
//         NSLog(@"queue1: %@",queue1);
        dispatch_sync(queue1 , ^{
               NSLog(@"async:1 %@",[NSThread currentThread]);
            });
        NSLog(@"sync:2");
        
        dispatch_queue_t queue2 = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
//
//             NSLog(@"queue2: %@",queue2);
        
        
        dispatch_sync(queue2, ^{
               NSLog(@"async:3 %@",[NSThread currentThread]);
            });
        NSLog(@"sync:4");

        
        
    }
    
    
    
    return 0;
}
