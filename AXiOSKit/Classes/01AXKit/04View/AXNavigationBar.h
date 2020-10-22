//
//  AXNavigationBar.h
//  AXiOSKit
//
//  Created by AXing on 2019/6/27.
//  Copyright © 2019 liu.weixing. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AXNavigationBar : UINavigationBar

@property(nonatomic, copy) NSString *title;
@property(nonatomic, strong) UINavigationItem * navigationItem;

@end

NS_ASSUME_NONNULL_END
