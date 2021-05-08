//
//  AXShareService.m
//  DLAppStore
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

@property(nonatomic, strong) AXShareUtil *shareUtil;

@end

@implementation AXShareService

AX_SINGLETON_IMPL(Service);

-(BOOL)handleOpenUrl:(NSURL *)url {
    
    return [self.shareUtil handleOpenWithUrl:url];
}


-(void)shareDownloadLinkOption:(AXShareOption *)option {
    AXShareType  type = option.type;
    
    if ([type isEqualToString:AXShareTypePhoneMessage]) {
        
        [self phoneMessage];
    }else if ([type isEqualToString:AXShareTypeQRCode]) {
        
        [self shareQRCode];
    }else if ([type isEqualToString:AXShareTypeSinaWeibo]) {
        [self shareOption:option item:[self weiboLinkItemName:option.appName link:option.appLink]];
    }else {
        [self shareOption:option item:[self linkItemName:option.appName link:option.appLink]];
    }
    
    
}

-(void)shareOption:(AXShareOption *)option item:(AXShareInfoItem *)item {
    
    AXShareType  type = option.type;
    
    if ([type isEqualToString:AXShareTypePhoneMessage]) {
        
        [self phoneMessage];
    }else if ([type isEqualToString:AXShareTypeQRCode]) {
        
        [self shareQRCode];
    }else if ([type isEqualToString:AXShareTypeWeiChatSession] ||
              [type isEqualToString:AXShareTypeWeiChatTimeLine] ||
              [type isEqualToString:AXShareTypeSinaWeibo] ||
              [type isEqualToString:AXShareTypeQQFriends] ) {
        
        __weak typeof(self) weakSelf = self;
        [self.shareUtil shareWithType:type item:item block:^(BOOL result, NSError * _Nullable error) {
            
            __strong typeof(weakSelf) strongSelf = weakSelf;
            NSLog(@"分享 %@, result = %d,error = %@",option.appName,result,error);
            if (result) {
                [strongSelf createAlertView:STR_SHARE_WX_SUCC];
            }else{
                
                if (error.code == -2) {
                    [strongSelf _tipUnInstallApp:option.title url:option.appLink];
                }else {
                    
                    [strongSelf createAlertView:error.localizedDescription];
                }
            }
            
        }];
    }
}

-(AXShareInfoItem *)linkItemName:(NSString *)name link:(NSString *)link {
    
    AXShareInfoItem *item = AXShareInfoItem.alloc.init;
    item.title = CurrentDLDisplayName;
    item.subTitle = [NSString stringWithFormat:@"%@分享地址:%@",CurrentDLDisplayName,DL_SHARE_URL];
    item.mediaType = DLShareInfoTypeUrl;
    item.url = [NSURL URLWithString:DL_SHARE_URL];
    item.thumbnail = IMG_ICON_SHARE;
    
    return item;
}
-(AXShareInfoItem *)weiboLinkItemName:(NSString *)name link:(NSString *)link {
    
    // 微博分享链接,不显示logo图片,title在subTitle 后面
    // 格式: subTitle title 网页链接
    AXShareInfoItem *item = AXShareInfoItem.alloc.init;
    item.title = nil;
    item.subTitle = [NSString stringWithFormat:@"%@分享地址",CurrentDLDisplayName];
    item.mediaType = DLShareInfoTypeUrl;
    item.url = [NSURL URLWithString:DL_SHARE_URL];
    item.thumbnail = IMG_ICON_SHARE;
    
    return item;
}


#pragma mark - 短信分享
- (void)phoneMessage {
    Class messageClass = (NSClassFromString(@"MFMessageComposeViewController"));
    if (messageClass != nil) {
        if( [MFMessageComposeViewController canSendText] )// 判断设备能不能发送短信
        {
            MFMessageComposeViewController *pickerMsg = [[MFMessageComposeViewController alloc] init];
            pickerMsg.messageComposeDelegate = self;
            pickerMsg.navigationBar.tintColor = [UIColor whiteColor];
            pickerMsg.body = DL_SHARE_URL;
            //可以指定为某一个人的联系方式
            //            pickerMsg.recipients = [NSArray arrayWithObject:@""];
            [ax_currentViewController() presentViewController:pickerMsg animated:YES completion:^{
                
            }];
            
        }
        else
        {
            [ax_currentViewController() dl_showConfirmAlertWihtTitle:STR_SHARE_WARM message:STR_SHARE_NONSUPPORT confirm:^{
                
            }];
        }
    }else{
        
        [ax_currentViewController() dl_showConfirmAlertWihtTitle:STR_SHARE_WARM message:STR_SHARE_BATE confirm:^{
            
        }];
    }
    
    [self uploadShareType:STR_SHARE_SMS];
}

#pragma mark - 二维码
-(void)shareQRCode {
    
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
-(void)_tipUnInstallApp:(NSString *)name url:(NSString *)url {
    
    NSURL *URL = [NSURL URLWithString:url];
    if (URL) {
        NSString *title = [NSString stringWithFormat:@"你的iPhone上还没有安装%@",name];
        NSString *msg = [NSString stringWithFormat:@"无法使用此功能，使用%@可以方便的把你喜欢的作品分享给好友。",name];
        NSString *confirmTitle = [NSString stringWithFormat:@"请先安装%@客户端，再进行分享",name];
        NSString *cancelTitle = @"取消";
        
        [ax_currentViewController() dl_showAlertWihtTitle:title message:msg confirmTitle:confirmTitle confirm:^{
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
        } cancelTitle:cancelTitle cancel:nil];
    }
}



#pragma mark - get
- (AXShareUtil *)shareUtil {
    if (!_shareUtil) {
        _shareUtil = [AXShareUtil.alloc init];
    }
    return _shareUtil;
}

@end
