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

@property(nonatomic, strong) NSArray<AXSharePlatform > *typesArray;

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


-(instancetype )initWithShareType:(NSArray<AXSharePlatform >*)types {
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
    [self.typesArray enumerateObjectsUsingBlock:^(AXSharePlatform type, NSUInteger idx, BOOL * _Nonnull stop) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        
        if ([type isEqualToString:AXSharePlatformWeiChatSession]) {
            /// 微信会话
            AXShareOption *__block option = AXShareOption.alloc.init;
            option.title = @"微信";
            option.appName = @"微信";
            option.appLink = @"";
            option.type = type;
            option.iconName = @"微信";;
            __block typeof(option)weakOption = option;
            option.didBlock = ^(AXSharePlatform type) {
                [strongSelf dismissViewControllerAnimated:YES completion:^{
                    [AXShareService.sharedService  shareDownloadLinkOption:weakOption];
                }];
            };
            [array addObject:option];
        }else if ([type isEqualToString:AXSharePlatformWeiChatTimeLine]) {
            /// 微信朋友圈
            AXShareOption * option = AXShareOption.alloc.init;
            option.title = @"朋友圈";
            option.appName =@"微信";;
            option.appLink = @"";
            option.type = type;
            option.iconName = @"朋友圈";
            __block typeof(option)weakOption = option;
            option.didBlock = ^(AXSharePlatform type) {
                [strongSelf dismissViewControllerAnimated:YES completion:^{
                    [AXShareService.sharedService  shareDownloadLinkOption:weakOption];
                }];
                
            };
            [array addObject:option];
        }else if ([type isEqualToString:AXSharePlatformSinaWeibo]) {
            /// 新浪微博
            AXShareOption *option = AXShareOption.alloc.init;
            option.title =  @"微博";
            option.appName = @"微博";
            option.appLink = @"";
            option.type = type;
            option.iconName =  @"微博";
            __block typeof(option)weakOption = option;
            option.didBlock = ^(AXSharePlatform type) {
                [strongSelf dismissViewControllerAnimated:YES completion:^{
                    [AXShareService.sharedService  shareDownloadLinkOption:weakOption];
                }];
            };
            [array addObject:option];
        }else if ([type isEqualToString:AXSharePlatformQQFriends]) {
            /// QQ会话
            AXShareOption *option = AXShareOption.alloc.init;
            option.title = @"QQ";
            option.appName = @"QQ";
            option.appLink = @"";
            option.type = type;
            option.iconName = @"QQ";
            __block typeof(option)weakOption = option;
            option.didBlock = ^(AXSharePlatform type) {
                [strongSelf dismissViewControllerAnimated:YES completion:^{
                    [AXShareService.sharedService  shareDownloadLinkOption:weakOption];
                }];
            };
            [array addObject:option];
        }else if ([type isEqualToString:AXSharePlatformPhoneMessage]) {
            /// 短信
            AXShareOption *option = AXShareOption.alloc.init;
            option.title = @"短信";
            option.type =  @"短信";
            option.iconName =  @"短信";
            __block typeof(option)weakOption = option;
            option.didBlock = ^(AXSharePlatform type) {
                [strongSelf dismissViewControllerAnimated:YES completion:^{
                    [AXShareService.sharedService shareDownloadLinkOption:weakOption];
                }];
            };
            [array addObject:option];
        }else if  ([type isEqualToString:AXSharePlatformQRCode]){
            /// 二维码
            AXShareOption *option = AXShareOption.alloc.init;
            option.title = @"支付宝";
            option.type =  @"支付宝";
            option.iconName =  @"支付宝";
            __block typeof(option)weakOption = option;
            option.didBlock = ^(AXSharePlatform type) {
                [strongSelf dismissViewControllerAnimated:YES completion:^{
                    [AXShareService.sharedService shareDownloadLinkOption:weakOption];
                }];
                
            };
            [array addObject:option];
        }
        
    }];
    self.view.column = 4;
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
            AXSharePlatformWeiChatSession,
            /// 微信朋友圈
            AXSharePlatformWeiChatTimeLine,
            /// 新浪微博
            AXSharePlatformSinaWeibo,
            /// QQ会话
            AXSharePlatformQQFriends,
            /// 短信
            AXSharePlatformPhoneMessage,
            /// 二维码
            AXSharePlatformQRCode,
        ];
    }
    return _typesArray;
}
@end
