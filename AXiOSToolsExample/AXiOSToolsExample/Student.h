//
//  Student.h
//  AXiOSToolsExample
//
//  Created by AXing on 2019/2/28.
//  Copyright © 2019 liu.weixing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Dog.h"


NS_ASSUME_NONNULL_BEGIN

@interface Student : NSObject
/**<#description#>*/
@property (nonatomic, copy) NSString *age;

@property (nonatomic, strong) Dog *dog;

@end

NS_ASSUME_NONNULL_END
