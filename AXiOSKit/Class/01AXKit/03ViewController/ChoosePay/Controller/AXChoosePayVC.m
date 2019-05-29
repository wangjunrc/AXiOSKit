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

@property (weak, nonatomic) IBOutlet UIImageView *payStyleImv;
@property (weak, nonatomic) IBOutlet UILabel *amountLabel;

@property (weak, nonatomic) IBOutlet UIButton *payBtn;

@property (weak, nonatomic) IBOutlet UIButton *closeBtn;


@property(nonatomic,assign)NSInteger selectIndex;


@end

@implementation AXChoosePayVC


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.orderMsgLabel.text = nil;
    self.amountLabel.text = @"0元";
    [self.closeBtn setImage:[UIImage axBundle_imageNamed:@"ax_close"] forState:UIControlStateNormal];
    self.payStyleImv.image = [UIImage axBundle_imageNamed:@"ax_to_left"];
    
    self.orderMsgLabel.text = self.orderMsgStr.length>0 ? self.orderMsgStr : @"暂无";
    
    if (self.amountFloat>0) {
        self.amountLabel.text = [NSString stringWithFormat:@"%.2lf元",self.amountFloat];;
    }
    
    [self func_payStyleText];
    
    UIImage *leftItmeIm = [UIImage axBundle_imageNamed:@"ax_close"];
     self.navigationItem.rightBarButtonItem =  [UIBarButtonItem ax_itemOriginalImage:leftItmeIm target:self action:@selector(closeBtnAction)];
    
}

- (void)func_payStyleText {
    
    AXChoosePayModel *payModel = self.dataArray[self.selectIndex];
    self.payStyleLabel.text = payModel.name;
}

- (IBAction)payBtnAction:(id)sender {
    
    // 这里需要添加 输入密码框 或者指纹识别,然后再回调
    if (self.confirmPayBlock) {
        self.confirmPayBlock(self.dataArray[self.selectIndex]);
    }
    
}
- (void)closeBtnAction{
    if (self.cancelBlock) {
        self.cancelBlock();
    }
}

- (IBAction)selectPayStyleAction:(id)sender {
    
    AXChoosePayStyleVC *payStyleVC = [AXChoosePayStyleVC ax_init];
    payStyleVC.dataArray = self.dataArray;
    payStyleVC.selectIndex = self.selectIndex;
    
    [self ax_pushVC:payStyleVC];
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
