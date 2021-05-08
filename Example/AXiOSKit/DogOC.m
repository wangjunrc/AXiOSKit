//
//  DogOC.m
//  AXiOSKit
//
//  Created by 小星星吃KFC on 2021/3/19.
//  Copyright © 2021 axinger. All rights reserved.
//

#import "DogOC.h"
#import "AXUserSwiftImport.h"
@implementation DogOC

-(void)show {
    NSLog(@"DogOC");
}

-(void)showSwift {
    DogSwift *dog = [DogSwift.alloc init];
    [dog show];
}

@end
