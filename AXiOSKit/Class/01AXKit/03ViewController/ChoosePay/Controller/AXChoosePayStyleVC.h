//
//  AXChoosePayStyleVC.h
//  AXiOSKitDemo
//
//  Created by liuweixing on 2018/8/20.
//  Copyright © 2018年 liuweixing. All rights reserved.
//

#import "AXViewController.h"
#import "AXChoosePayModel.h"

@interface AXChoosePayStyleVC : AXViewController

@property(nonatomic,assign)NSInteger selectIndex;

@property(nonatomic,strong)NSArray <AXChoosePayModel *>*dataArray;

@property(nonatomic,copy)void(^didSelectBlock)(NSInteger row);


@end
