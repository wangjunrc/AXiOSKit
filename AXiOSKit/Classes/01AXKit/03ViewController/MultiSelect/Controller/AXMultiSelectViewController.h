//
//  AXMultiSelectViewController.h
//  AXiOSKit
//
//  Created by axing on 2019/6/27.
//  Copyright © 2019 liu.weixing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AXMultiSelectViewModel.h"
#import "AXMultiSelectConfig.h"

NS_ASSUME_NONNULL_BEGIN

@interface AXMultiSelectViewController : UIViewController

-(instancetype)initWithConfig:(AXMultiSelectConfig *)config
                   viewModels:(NSArray <AXMultiSelectViewModel *>*)viewModelArray
                 didSelectRow:(void(^)(NSArray<NSIndexPath *> *selectedItems))didSelectRow;

@end

NS_ASSUME_NONNULL_END
