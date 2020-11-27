//
//  AXPayVC.h
//  AXiOSKit
//
//  Created by AXing on 2019/5/29.
//  Copyright © 2019 liu.weixing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AXChoosePayModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface AXPayVC : UIViewController

@property (nonatomic, strong) NSArray<AXChoosePayModel*>* dataArray;

@property(nonatomic,copy)NSString *orderText;

@property(nonatomic,copy)NSString *amountText;

@property (nonatomic, copy) void (^confirmPayBlock)(AXChoosePayModel* payModel);

@end

NS_ASSUME_NONNULL_END
