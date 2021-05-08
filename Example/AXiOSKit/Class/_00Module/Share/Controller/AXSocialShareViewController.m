//
//  AXShareUIViewController.m
//  AXiOSKitExample
//
//  Created by 小星星吃KFC on 2021/4/30.
//  Copyright © 2021 axinger. All rights reserved.
//

#import "AXSocialShareViewController.h"
#import "AXSocialShareView.h"
#import "AXShareOption.h"
#import "AXShareService.h"
#import <AXViewControllerTransitioning/AXViewControllerTransitioning.h>

@interface AXSocialShareViewController ()

AX_REDEFINE_CONTROLLER_VIEW_INTER(AXSocialShareView);

@property(nonatomic, strong) NSArray<AXShareTarget > *typesArray;

@end

@implementation AXSocialShareViewController

AX_REDEFINE_CONTROLLER_VIEW_IMPL(AXSocialShareView);

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        [self ax_alertObserver:^(AXAlertTransitioningObserver *observer) {
            observer.alertControllerStyle = AXAlertControllerStyleUpward;
        }];
        
    }
    return self;
}


-(instancetype )initWithShareType:(NSArray<AXShareTarget >*)types {
    if ([self init]) {
        self.typesArray = types;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self _initData];
    
}

-(void)_initData {
    
    NSMutableArray<AXShareOption *> *__block array = NSMutableArray.array;
    __weak typeof(self) weakSelf = self;
    [self.typesArray enumerateObjectsUsingBlock:^(AXShareTarget type, NSUInteger idx, BOOL * _Nonnull stop) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        
        if ([type isEqualToString:AXShareTargetWeiChatSession]) {
            /// 微信会话
            AXShareOption *__block option = AXShareOption.alloc.init;
            option.title = @"微信";
            option.appName = @"微信";
            option.appLink = @"";
            option.type = type;
            option.iconName = @"微信";;
            __block typeof(option)weakOption = option;
            option.didBlock = ^(AXShareTarget type) {
                [strongSelf dismissViewControllerAnimated:YES completion:^{
                    [AXShareService.sharedService  shareDownloadLinkOption:weakOption];
                }];
            };
            [array addObject:option];
        }else if ([type isEqualToString:AXShareTargetWeiChatTimeLine]) {
            /// 微信朋友圈
            AXShareOption * option = AXShareOption.alloc.init;
            option.title = @"朋友圈";
            option.appName =@"微信";;
            option.appLink = @"";
            option.type = type;
            option.iconName = @"朋友圈";
            __block typeof(option)weakOption = option;
            option.didBlock = ^(AXShareTarget type) {
                [strongSelf dismissViewControllerAnimated:YES completion:^{
                    [AXShareService.sharedService  shareDownloadLinkOption:weakOption];
                }];
                
            };
            [array addObject:option];
        }else if ([type isEqualToString:AXShareTargetSinaWeibo]) {
            /// 新浪微博
            AXShareOption *option = AXShareOption.alloc.init;
            option.title =  @"微博";
            option.appName = @"微博";
            option.appLink = @"";
            option.type = type;
            option.iconName =  @"微博";
            __block typeof(option)weakOption = option;
            option.didBlock = ^(AXShareTarget type) {
                [strongSelf dismissViewControllerAnimated:YES completion:^{
                    [AXShareService.sharedService  shareDownloadLinkOption:weakOption];
                }];
            };
            [array addObject:option];
        }else if ([type isEqualToString:AXShareTargetQQFriends]) {
            /// QQ会话
            AXShareOption *option = AXShareOption.alloc.init;
            option.title = @"QQ";
            option.appName = @"QQ";
            option.appLink = @"";
            option.type = type;
            option.iconName = @"QQ";
            __block typeof(option)weakOption = option;
            option.didBlock = ^(AXShareTarget type) {
                [strongSelf dismissViewControllerAnimated:YES completion:^{
                    [AXShareService.sharedService  shareDownloadLinkOption:weakOption];
                }];
            };
            [array addObject:option];
        }else if ([type isEqualToString:AXShareTargetPhoneMessage]) {
            /// 短信
            AXShareOption *option = AXShareOption.alloc.init;
            option.title = @"短信";
            option.type =  @"短信";
            option.iconName =  @"短信";
            __block typeof(option)weakOption = option;
            option.didBlock = ^(AXShareTarget type) {
                [strongSelf dismissViewControllerAnimated:YES completion:^{
                    [AXShareService.sharedService shareDownloadLinkOption:weakOption];
                }];
            };
            [array addObject:option];
        }else if  ([type isEqualToString:AXShareTargetQRCode]){
            /// 二维码
            AXShareOption *option = AXShareOption.alloc.init;
            option.title = @"支付宝";
            option.type =  @"支付宝";
            option.iconName =  @"支付宝";
            __block typeof(option)weakOption = option;
            option.didBlock = ^(AXShareTarget type) {
                [strongSelf dismissViewControllerAnimated:YES completion:^{
                    [AXShareService.sharedService shareDownloadLinkOption:weakOption];
                }];
                
            };
            [array addObject:option];
        }
        
    }];
    
    self.view.dataArray = array.copy;
    [self.view.cancelButton addTarget:self action:@selector(cancelAction:) forControlEvents:UIControlEventTouchUpInside];
    
}


-(void)cancelAction:(UIButton *)btn {
    [self dismiss];
}

-(void)dismiss {
    [self dismissViewControllerAnimated:YES completion:nil];
}

/// 调用者自控制是否点击空白页面 消失
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch* touch = [touches anyObject];
    UIView* view = [touch view];
    if (view == self.view) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

- (NSArray<NSString *> *)typesArray {
    if (!_typesArray) {
        _typesArray =  @[
            /// 微信会话
            AXShareTargetWeiChatSession,
            /// 微信朋友圈
            AXShareTargetWeiChatTimeLine,
            /// 新浪微博
            AXShareTargetSinaWeibo,
            /// QQ会话
            AXShareTargetQQFriends,
            /// 短信
            AXShareTargetPhoneMessage,
            /// 二维码
            AXShareTargetQRCode,
        ];
    }
    return _typesArray;
}
@end
