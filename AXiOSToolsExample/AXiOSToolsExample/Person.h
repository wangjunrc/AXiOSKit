//
//  Person.h
//  AXiOSToolsExample
//
//  Created by AXing on 2019/2/28.
//  Copyright © 2019 liu.weixing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AXiOSTools.h"
#import "Student.h"

NS_ASSUME_NONNULL_BEGIN

@interface Person : NSObject
axSharedInstance_H
axSharedCancel_H

/**<#description#>*/
@property (nonatomic, strong) Student *student;


@end

NS_ASSUME_NONNULL_END
