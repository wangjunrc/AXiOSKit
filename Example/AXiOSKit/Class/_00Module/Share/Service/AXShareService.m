//
//  AXShareService.m
//  AXiOSKitExample
//
//  Created by 小星星吃KFC on 2021/5/8.
//  Copyright © 2021 axinger. All rights reserved.
//

#import "AXShareService.h"
#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMailComposeViewController.h>
#import "AXUserSwiftImport.h"
#import <AXiOSKit/AXiOSKit.h>

@interface AXShareService ()<MFMessageComposeViewControllerDelegate>

@property (nonatomic, strong) AXShareBridge *shareBridge;

@end

@implementation AXShareService

AX_SINGLETON_IMPL(Service);

- (BOOL)handleOpenUrl:(NSURL *)url {
    return [self.shareBridge handleOpenWithUrl:url];
}

- (void)shareDownloadLinkOption:(AXShareOption *)option {
    AXSharePlatform type = option.type;
    
    if ([type isEqualToString:AXSharePlatformPhoneMessage]) {
        [self phoneMessage];
    } else if ([type isEqualToString:AXSharePlatformQRCode]) {
        [self shareQRCode];
    } else if ([type isEqualToString:AXSharePlatformSinaWeibo]) {
        [self shareOption:option item:[self shareWeiboItem:option]];
    } else {
        [self shareOption:option item:[self shareItem:option]];
    }
}

- (void)shareOption:(AXShareOption *)option item:(AXSocialShareContent *)item {
    AXSharePlatform type = option.type;
    
    if ([type isEqualToString:AXSharePlatformPhoneMessage]) {
        [self phoneMessage];
    } else if ([type isEqualToString:AXSharePlatformQRCode]) {
        [self shareQRCode];
    } else if ([type isEqualToString:AXSharePlatformWeiChatSession] ||
               [type isEqualToString:AXSharePlatformWeiChatTimeLine] ||
               [type isEqualToString:AXSharePlatformSinaWeibo] ||
               [type isEqualToString:AXSharePlatformQQFriends]) {
        __weak typeof(self) weakSelf = self;
        [self.shareBridge shareWithType:type item:item block:^(BOOL result, NSError *_Nullable error) {
            __strong typeof(weakSelf) strongSelf = weakSelf;
            NSLog(@"分享 %@, result = %d,error = %@", option.appName, result, error);
            if (result) {
                NSString *title = [NSString stringWithFormat:@"%@分享成功", option.title];
                [MBProgressHUD ax_showSuccess:title];
            } else {
                if (error.code == -2) {
                    [strongSelf _tipUnInstallApp:option.title url:option.appLink];
                } else {
                    [MBProgressHUD ax_showError:error.localizedDescription];
                }
            }
        }];
    }
}

- (AXSocialShareContent *)shareItem:(AXShareOption *)option {
    AXSocialShareContent *item = AXSocialShareContent.alloc.init;
    item.title = @"分享title";
    item.subTitle = [NSString stringWithFormat:@"%@分享地址:%@", @"分享title", @"https://www.baidu.com/"];
    if ([option.type isEqualToString:AXSharePlatformQQFriends]) {
        // qq分享没有universalLink,只能分享文字, 设备未授权 25105
//        item.mediaType = AXSocialShareContentTypeText;
        item.mediaType = AXSocialShareContentTypeUrl;
    } else {
        item.mediaType = AXSocialShareContentTypeUrl;
    }
    
    item.url = [NSURL URLWithString:@"https://www.baidu.com/"];
    item.thumbnail = [UIImage imageNamed:@"西瓜"];
    
    return item;
}

- (AXSocialShareContent *)shareWeiboItem:(AXShareOption *)option {
    // 微博分享链接,不显示logo图片,title在subTitle 后面
    // 格式: subTitle title 网页链接
    AXSocialShareContent *item = AXSocialShareContent.alloc.init;
    item.title = nil;
    item.subTitle = [NSString stringWithFormat:@"%@分享地址", @"分享title"];
    item.mediaType = AXSocialShareContentTypeUrl;
    item.url = [NSURL URLWithString:@"https://www.baidu.com/"];
    item.thumbnail = [UIImage imageNamed:@"西瓜"];
    
    return item;
}

#pragma mark - 短信分享
- (void)phoneMessage {
    Class messageClass = (NSClassFromString(@"MFMessageComposeViewController"));
    if (messageClass != nil) {
        if ([MFMessageComposeViewController canSendText]) {// 判断设备能不能发送短信
            MFMessageComposeViewController *pickerMsg = [[MFMessageComposeViewController alloc] init];
            pickerMsg.messageComposeDelegate = self;
            pickerMsg.navigationBar.tintColor = [UIColor whiteColor];
            pickerMsg.body = @"https://www.baidu.com/";
            //可以指定为某一个人的联系方式
            //            pickerMsg.recipients = [NSArray arrayWithObject:@""];
            [ax_currentViewController() presentViewController:pickerMsg animated:YES completion:^{
            }];
        } else {
        }
    } else {
    }
}

#pragma mark - 二维码
- (void)shareQRCode {
}

- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result
{
    switch (result) {
        case MessageComposeResultCancelled:
            break;
        case MessageComposeResultFailed:
            break;
        case MessageComposeResultSent:
            break;
        default:
            break;
    }
    [controller dismissViewControllerAnimated:YES completion:nil];
}

/// 提示未安装的app
/// @param name 名称
/// @param url 下载链接
- (void)_tipUnInstallApp:(NSString *)name url:(NSString *)url {
    NSURL *URL = [NSURL URLWithString:url];
    if (URL) {
        NSString *title = [NSString stringWithFormat:@"你的iPhone上还没有安装%@", name];
        NSString *msg = [NSString stringWithFormat:@"请先安装%@客户端，再进行分享", name];
        
        [ax_currentViewController() ax_showAlertByTitle:title message:msg confirm:^{
            ax_OpenURLStr(url);
        } cancel:^{
        }];
    }
}

#pragma mark - get
- (AXShareBridge *)shareBridge {
    if (!_shareBridge) {
        _shareBridge = [AXShareBridge.alloc init];
    }
    return _shareBridge;
}

@end
