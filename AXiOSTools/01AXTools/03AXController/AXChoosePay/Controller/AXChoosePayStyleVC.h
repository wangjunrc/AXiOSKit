//
//  AXChoosePayStyleVC.h
//  AXiOSToolsDemo
//
//  Created by liuweixing on 2018/8/20.
//  Copyright © 2018年 liuweixing. All rights reserved.
//

#import "AXBaseAlertVC.h"
#import "AXChoosePayModel.h"

@interface AXChoosePayStyleVC : AXBaseAlertVC


@property(nonatomic,assign)NSInteger selectIndex;

@property(nonatomic,strong)NSArray <AXChoosePayModel *>*dataArray;

@property (weak, nonatomic) IBOutlet UIView *contentView;

@end
