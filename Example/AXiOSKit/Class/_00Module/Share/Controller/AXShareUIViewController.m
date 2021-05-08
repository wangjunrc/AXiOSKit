//
//  AXShareUIViewController.m
//  DLAppStore
//
//  Created by 小星星吃KFC on 2021/4/30.
//  Copyright © 2021 axinger. All rights reserved.
//

#import "AXShareUIViewController.h"
#import "DLSharePopView.h"
#import "AXShareOption.h"
#import "AXShareService.h"
#import <AXViewControllerTransitioning/AXViewControllerTransitioning.h>

@interface AXShareUIViewController ()

DL_REDEFINE_CONTROLLER_VIEW_PROPERTY(DLSharePopView);

@property(nonatomic, strong) NSArray<AXShareType > *typesArray;

@end

@implementation AXShareUIViewController

DL_REDEFINE_CONTROLLER_VIEW_IMPL(DLSharePopView);

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        [self ax_alertObserver:^(DLAlertTransitioningObserver *observer) {
            observer.alertControllerStyle = DLAlertControllerStyleUpward;
        }];
        
    }
    return self;
}


-(instancetype )initWithShareType:(NSArray<AXShareType >*)types {
    if ([self init]) {
        self.typesArray = types;
    }
    return self;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        if (self.typesArray.count==0) {
            self.typesArray = @[
                /// 微信会话
                AXShareTypeWeiChatSession,
                /// 微信朋友圈
                AXShareTypeWeiChatTimeLine,
                /// 新浪微博
                AXShareTypeSinaWeibo,
                /// QQ会话
                AXShareTypeQQFriends,
                /// 短信
                AXShareTypePhoneMessage,
                /// 二维码
                AXShareTypeQRCode,
            ];
        }
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
    [self.typesArray enumerateObjectsUsingBlock:^(AXShareType type, NSUInteger idx, BOOL * _Nonnull stop) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        
        if ([type isEqualToString:AXShareTypeWeiChatSession]) {
            /// 微信会话
            AXShareOption *__block option = AXShareOption.alloc.init;
            option.title = STR_SHARE_WXIN;
            option.appName = STR_SHARE_WXIN;
            option.appLink = WEIBO_Client_LINK_DOWN;
            option.type = type;
            option.iconName = @"sns_icon_22";
            __block typeof(option)weakOption = option;
            option.didBlock = ^(AXShareType type) {
                NSLog(@"点击了 = %@",STR_SHARE_WXIN);
                [strongSelf dismissViewControllerAnimated:YES completion:^{
                    [AXShareService.sharedService  shareDownloadLinkOption:weakOption];
                }];
            };
            [array addObject:option];
        }else if ([type isEqualToString:AXShareTypeWeiChatTimeLine]) {
            /// 微信朋友圈
            AXShareOption * option = AXShareOption.alloc.init;
            option.title = STR_SHARE_WXFRIEND;
            option.appName = STR_SHARE_WXIN;
            option.appLink = WEIBO_Client_LINK_DOWN;
            option.type = type;
            option.iconName = @"sns_icon_23";
            __block typeof(option)weakOption = option;
            option.didBlock = ^(AXShareType type) {
                [strongSelf dismissViewControllerAnimated:YES completion:^{
                    [AXShareService.sharedService  shareDownloadLinkOption:weakOption];
                }];
                
            };
            [array addObject:option];
        }else if ([type isEqualToString:AXShareTypeSinaWeibo]) {
            /// 新浪微博
            AXShareOption *option = AXShareOption.alloc.init;
            option.title = STR_SHARE_SINA;
            option.appName = @"微博";
            option.appLink = WEIBO_Client_LINK_DOWN;
            option.type = type;
            option.iconName = @"sns_icon_1";
            __block typeof(option)weakOption = option;
            option.didBlock = ^(AXShareType type) {
                [strongSelf dismissViewControllerAnimated:YES completion:^{
                    [AXShareService.sharedService  shareDownloadLinkOption:weakOption];
                }];
            };
            [array addObject:option];
        }else if ([type isEqualToString:AXShareTypeQQFriends]) {
            /// QQ会话
            AXShareOption *option = AXShareOption.alloc.init;
            option.title = STR_SHARE_QQ;
            option.appName = STR_SHARE_QQ;
            option.appLink = QQClient_LINK_DOWN;
            option.type = type;
            option.iconName = @"sns_icon_24";
            __block typeof(option)weakOption = option;
            option.didBlock = ^(AXShareType type) {
                [strongSelf dismissViewControllerAnimated:YES completion:^{
//                    [AXShareService.sharedService  shareDownloadLinkOption:weakOption];
                    [DLThirdShareTool.sharedDLThirdShareTool  shareOption:weakOption];
                }];
            };
            [array addObject:option];
        }else if ([type isEqualToString:AXShareTypePhoneMessage]) {
            /// 短信
            AXShareOption *option = AXShareOption.alloc.init;
            option.title = STR_SHARE_SMS;
            option.type = type;
            option.iconName = @"sns_icon_19";
            __block typeof(option)weakOption = option;
            option.didBlock = ^(AXShareType type) {
                [strongSelf dismissViewControllerAnimated:YES completion:^{
                    [AXShareService.sharedService shareDownloadLinkOption:weakOption];
                }];
            };
            [array addObject:option];
        }else if  ([type isEqualToString:AXShareTypeQRCode]){
            /// 二维码
            AXShareOption *option = AXShareOption.alloc.init;
            option.title = STR_SHARE_QRCODE;
            option.type = type;
            option.iconName = @"sns_icon_ercode";
            __block typeof(option)weakOption = option;
            option.didBlock = ^(AXShareType type) {
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

@end
