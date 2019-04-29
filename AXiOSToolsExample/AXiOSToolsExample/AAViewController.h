//
//  AAViewController.h
//  AXiOSToolsExample
//
//  Created by AXing on 2019/2/15.
//  Copyright © 2019 liu.weixing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface AAViewController : UIViewController
/**description*/
@property (nonatomic, strong) ViewController *vc;

/**<#description#>*/
@property (nonatomic, copy) void(^did)(void);

@property (nonatomic, copy) NSString * (^didNameBlock)(void);


@end

NS_ASSUME_NONNULL_END
