//
//  AXChoosePayVC.m
//  AXiOSToolsDemo
//
//  Created by mac on 2018/8/20.
//  Copyright © 2018年 liuweixing. All rights reserved.
//

#import "AXChoosePayVC.h"
#import "AXToolsHeader.h"
#import "AXChoosePayStyleVC.h"

@interface AXChoosePayVC ()

@property (weak, nonatomic) IBOutlet UILabel *orderMsgLabel;

@property (weak, nonatomic) IBOutlet UILabel *payStyleLabel;

@property (weak, nonatomic) IBOutlet UILabel *amountLabel;


@property (weak, nonatomic) IBOutlet UIButton *payBtn;

@property (weak, nonatomic) IBOutlet UIButton *closeBtn;

@property (weak, nonatomic) IBOutlet UIView *contentView;

@property(nonatomic,assign)NSInteger selectIndex;


@end

@implementation AXChoosePayVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.axContentView = self.contentView;
}


- (IBAction)payBtnAction:(id)sender {
    
    
}
- (IBAction)closeBtnAction:(id)sender {
    
    
}

- (IBAction)selectPayStyleAction:(id)sender {
    
    AXChoosePayStyleVC *payStyleVC = [AXChoosePayStyleVC ax_init];
    payStyleVC.dataArray = self.dataArray;
    payStyleVC.selectIndex = self.selectIndex;
    
    //        [UIView transitionFromView:self.view toView:self.payStyleVC.view duration:1 options:UIViewAnimationOptionTransitionFlipFromTop completion:^(BOOL finished) {
    //
    //        }];
    //        [UIView transitionFromView:self.payStyleVC.view toView:self.view duration:1 options:UIViewAnimationOptionTransitionFlipFromLeft completion:^(BOOL finished) {
    //
    //        }];
    
    
    [self ax_showVC:payStyleVC];
    
    
    
}

- (NSArray<AXChoosePayModel *> *)dataArray{
    if (!_dataArray) {
        
        AXChoosePayModel *model = [AXChoosePayModel ax_init];
        model.name = @"支付宝";
        model.imageName =@"支付宝";
        
        AXChoosePayModel *model1 = [AXChoosePayModel ax_init];
        model1.name = @"微信";
        model1.imageName =@"微信";
        
        _dataArray = @[model,model1];
    }
    return _dataArray;
}

@end
