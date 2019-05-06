//
//  AXChoosePayVC.m
//  AXiOSKitDemo
//
//  Created by mac on 2018/8/20.
//  Copyright © 2018年 liuweixing. All rights reserved.
//

#import "AXChoosePayVC.h"
#import "AXiOSKit.h"
#import "AXChoosePayStyleVC.h"
#import "UIButton+AXKit.h"
#import "UIImage+AXBundle.h"
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
    self.axTouchesBeganDismiss = NO;
    self.orderMsgLabel.text = nil;
    self.amountLabel.text = @"0元";
    [self.closeBtn setImage:[UIImage axBundle_imageNamed:@"ax_close"] forState:UIControlStateNormal];
    
    if (self.orderMsgStr.length>0) {
        self.orderMsgLabel.text = self.orderMsgStr;
    }
    
    if (self.amountFloat>0) {
        self.amountLabel.text = [NSString stringWithFormat:@"%.2lf元",self.amountFloat];;
    }
    
    [self func_payStyleText];
}

- (void)func_payStyleText {
    
    AXChoosePayModel *payModel = self.dataArray[self.selectIndex];
    self.payStyleLabel.text = payModel.name;
}

- (IBAction)payBtnAction:(id)sender {
    if (self.confirmPayBlock) {
        self.confirmPayBlock(self.dataArray[self.selectIndex]);
    }
    
}
- (IBAction)closeBtnAction:(id)sender {
    
  [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)selectPayStyleAction:(id)sender {
    
    AXChoosePayStyleVC *payStyleVC = [AXChoosePayStyleVC ax_init];
    payStyleVC.dataArray = self.dataArray;
    payStyleVC.selectIndex = self.selectIndex;
    
    
    [self ax_showVC:payStyleVC];
    
    payStyleVC.didSelectBlock = ^(NSInteger row) {
        self.selectIndex = row;
        [self func_payStyleText];
    };
    
}

- (NSArray<AXChoosePayModel *> *)dataArray{
    if (!_dataArray) {
        
        AXChoosePayModel *model = [AXChoosePayModel ax_init];
        model.name = @"支付宝";
        model.imageName =@"ax_icon_zhifubao";
        
        AXChoosePayModel *model1 = [AXChoosePayModel ax_init];
        model1.name = @"微信";
        model1.imageName =@"ax_icon_weixin";
        
        _dataArray = @[model,model1];
    }
    return _dataArray;
}

@end
