//
//  AXChoosePayVC.h
//  AXiOSKitDemo
//
//  Created by mac on 2018/8/20.
//  Copyright © 2018年 liuweixing. All rights reserved.
//

#import "AXBaseAlertVC.h"
#import "AXChoosePayModel.h"

@interface AXChoosePayVC : AXBaseAlertVC

@property(nonatomic,strong)NSArray <AXChoosePayModel *>*dataArray;

@property(nonatomic,copy)NSString *orderMsgStr;

@property(nonatomic,assign)CGFloat amountFloat;

@property(nonatomic,copy)void(^confirmPayBlock)(AXChoosePayModel *payModel);

@end
