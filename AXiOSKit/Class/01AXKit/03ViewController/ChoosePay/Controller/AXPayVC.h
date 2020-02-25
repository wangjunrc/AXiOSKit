//
//  AXPayVC.h
//  AXiOSKit
//
//  Created by AXing on 2019/5/29.
//  Copyright © 2019 liu.weixing. All rights reserved.
//

#import "AXBaseAlertVC.h"
#import "AXChoosePayModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface AXPayVC : AXBaseAlertVC

@property (nonatomic, strong) NSArray<AXChoosePayModel*>* dataArray;

@property (nonatomic, copy) NSString* orderMsgStr;

@property (nonatomic, assign) CGFloat amountFloat;

@property (nonatomic, copy) void (^confirmPayBlock)(AXChoosePayModel* payModel);

@end

NS_ASSUME_NONNULL_END
