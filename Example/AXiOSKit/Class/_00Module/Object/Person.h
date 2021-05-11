//
//  Person.h
//  RuntimeDemo
//
//  Created by apple on 2017/6/2.
//  Copyright © 2017年 ZY. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Person : NSObject
AX_SINGLETON_INTER(Sh);
@property(nonatomic, copy) NSString *name;
-(void)logShowTest;

@end
