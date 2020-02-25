//
//  AXChoosePayVC.h
//  AXiOSKitDemo
//
//  Created by mac on 2018/8/20.
//  Copyright © 2018年 liuweixing. All rights reserved.
//

#import "AXViewController.h"
#import "AXChoosePayModel.h"

@interface AXChoosePayVC : AXViewController

@property(nonatomic,strong)NSArray <AXChoosePayModel *>*dataArray;

@property(nonatomic,copy)NSString *orderMsgStr;

@property(nonatomic,assign)CGFloat amountFloat;

@property(nonatomic,copy)void(^confirmPayBlock)(AXChoosePayModel *payModel);

@property(nonatomic,copy)void(^cancelBlock)(void);

@end
