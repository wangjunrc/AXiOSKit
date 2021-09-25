//
//  UIViewController+AXAlert.m
//  AXiOSKit
//
//  Created by liuweixing on 16/9/19.
//  Copyright © 2016年 liuweixing All rights reserved.
//

#import "UIViewController+AXAlert.h"
#import <objc/runtime.h>
#import "UIViewController+AXKit.h"
#import <objc/runtime.h>
#import "AXiOSKit.h"
#import <AVFoundation/AVCaptureDevice.h>
#import <Photos/Photos.h>
#import "AXDeviceFunctionDisableViewController.h"
#import <MobileCoreServices/UTCoreTypes.h>

@implementation AXActionItem

@synthesize title;
@synthesize titleColor;
@synthesize image;
@synthesize imageColor;
@synthesize style;
@synthesize handler;

@end

@implementation UIViewController (AXAlert)

#pragma mark - Sheet


/**
 * Sheet  没有取消回调
 */
- (void)ax_showSheetByTitle:(NSString *)title message:(NSString*)message actionArray:(NSArray <NSString*>*)actionArray confirm:(void(^)(NSInteger index))confirm{
    
    [self ax_showSheetByiPadView:nil title:title message:message actionArray:actionArray confirm:confirm];
    
}

/**
 * Sheet 有取消回调
 */
- (void)ax_showSheetByTitle:(NSString *)title message:(NSString*)message actionArray:(NSArray <NSString*>*)actionArray confirm:(void(^)(NSInteger index))confirm cancel:(void(^)(void))cancel{
    
    [self ax_showSheetByiPadView:nil title:title message:message actionArray:actionArray confirm:confirm cancel:cancel];
}

/**
 * Sheet 退出登录
 */
- (void)ax_showSheeLogout:(void(^)(void))confirm{
    [self ax_showSheeLogoutByPadView:nil confirm:confirm];
}

#pragma mark - Alert

/**
 * 数组 Alert 有取消回调
 */
- (void)ax_showAlertArrayByTitle:(NSString *)title message:(NSString*)message actionArray:(NSArray <NSString*>*)actionArray confirm:(void(^)(NSInteger index))confirm cancel:(void(^)(void))cancel{
    
    [self ax_showAlertByiPadView:nil title:title message:message actionArray:actionArray confirm:confirm cancel:cancel];
}


/**
 * 只有确定,没有回调
 */
- (void)ax_showAlertByTitle:(NSString *)title{
    [self ax_showAlertByTitle:title confirm:nil];
}


/**
 * 有确定和回调
 */
- (void)ax_showAlertByTitle:(NSString *)title confirm:(void(^)(void))confirm{
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:nil preferredStyle:UIAlertControllerStyleAlert];
    
    [alert addAction:[UIAlertAction actionWithTitle:AXKitLocalizedString(@"ax.i.know") style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if (confirm) {
            confirm();
        }
    }]];
    
    [self presentViewController:alert animated:YES completion:nil];
}
/**
 * 有确定和回调
 */
- (void)ax_showAlertByTitle:(NSString *)title message:(NSString *)message confirm:(void(^)(void))confirm{
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    [alert addAction:[UIAlertAction actionWithTitle:AXKitLocalizedString(@"ax.i.know") style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if (confirm) {
            confirm();
        }
    }]];
    
    [self presentViewController:alert animated:YES completion:nil];
}
/*=======================================*/

/**
 * 有确定,取消 ,确定按钮文字
 */
- (void)ax_showAlertByTitle:(NSString *)title message:(NSString *)message confirmTitle:(NSString *)confirmTitle confirm:(void(^)(void))confirm cancel:(void(^)(void))cancel{
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    [alert addAction:[UIAlertAction actionWithTitle:AXKitLocalizedString(confirmTitle )style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if (confirm) {
            confirm();
        }
    }]];
    
    [alert addAction:[UIAlertAction actionWithTitle:AXKitLocalizedString(@"ax.cancel") style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        if (cancel) {
            cancel();
        }
    }]];
    [self presentViewController:alert animated:YES completion:nil];
}


/**
 * 有确定,取消
 */
- (void)ax_showAlertByTitle:(NSString *)title message:(NSString *)message confirm:(void(^)(void))confirm cancel:(void(^)(void))cancel{
    
    [self ax_showAlertByTitle:title message:message confirmTitle:AXKitLocalizedString(@"ax.confirm") confirm:confirm cancel:cancel];
}

/**
 * 流量网络下载,提示
 */
- (void)ax_showNetDownloadGo:(void(^)(void))go cancel:(void(^)(void))cancel{
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:AXKitLocalizedString(@"当前网络为数据流量") message:AXKitLocalizedString(@"是否取消下载") preferredStyle:UIAlertControllerStyleAlert];
    
    [alert addAction:[UIAlertAction actionWithTitle:AXKitLocalizedString(@"继续下载") style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        if (go) {
            go();
        }
    }]];
    
    
    [alert addAction:[UIAlertAction actionWithTitle:AXKitLocalizedString(@"取消下载") style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if (cancel) {
            cancel();
        }
    }]];
    
    [self presentViewController:alert animated:YES completion:nil];
}

#pragma mark Alert+UITextField
/**
 * Alert含有输入文本框
 */
- (void)ax_showAlertTFByTitle:(NSString *)title message:(NSString *)message confirm:(void(^)( NSString *text))confirm cancel:(void(^)(void))cancel{
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    
    UITextField * textF=nil;
    __block typeof(textF)weaktextF = textF;
    
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        weaktextF = textField;
        textField.placeholder = message;
    }];
    
    
    [alert addAction:[UIAlertAction actionWithTitle:AXKitLocalizedString(@"ax.confirm") style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if (confirm) {
            confirm(weaktextF.text);
        }
    }]];
    
    [alert addAction:[UIAlertAction actionWithTitle:AXKitLocalizedString(@"ax.cancel") style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        if (cancel) {
            cancel();
        }
    }]];
    
    [self presentViewController:alert animated:YES completion:nil];
}


/**
 * Alert含有输入文本框
 */
- (void)ax_showAlertTF:(UITextField *)textF title:(NSString *)title message:(NSString *)message confirm:(void(^)( UITextField *textF))confirm cancel:(void(^)(void))cancel{
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    
    __block typeof(textF)weaktextF = textF;
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = textF.placeholder;
        textField.keyboardType = textF.keyboardType;
        textField.secureTextEntry = textF.secureTextEntry;
        
        weaktextF = textField;
        textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    }];
    
    
    [alert addAction:[UIAlertAction actionWithTitle:AXKitLocalizedString(@"ax.confirm") style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        if (confirm) {
            confirm(weaktextF);
        }
    }]];
    
    [alert addAction:[UIAlertAction actionWithTitle:AXKitLocalizedString(@"ax.cancel") style:UIAlertActionStyleCancel handler:^(UIAlertAction * action) {
        if (cancel) {
            cancel();
        }
    }]];
    
    [self presentViewController:alert animated:YES completion:nil];
}


#pragma mark - iPad alert



#pragma mark - Sheet

/**
 * Sheet  没有取消回调
 */
- (void)ax_showSheetByiPadView:(UIView*)iPadView title:(NSString *)title message:(NSString*)message actionArray:(NSArray <NSString*>*)actionArray confirm:(void(^)(NSInteger index))confirm{
    
    [self ax_showSheetByiPadView:iPadView title:title message:message actionArray:actionArray confirm:confirm cancel:nil];
    
}

/**
 * Sheet 有取消回调
 */
- (void)ax_showSheetByTitle:(NSString *)title
                    message:(NSString*)message
                actionItems:(NSArray <id<AXAlertAction>>*)actionArray
                    confirm:(void(^)(NSInteger index))confirm
                     cancel:(void(^)(void))cancel {
    [self ax_showSheetByiPadView:nil title:title message:message actionItems:actionArray confirm:confirm cancel:cancel];
}

/**
 * Sheet 有取消回调
 */
- (void)ax_showSheetByiPadView:(UIView*)iPadView
                         title:(NSString *)title
                       message:(NSString*)message
                   actionArray:(NSArray <NSString*>*)actionArray
                       confirm:(void(^)(NSInteger index))confirm
                        cancel:(void(^)(void))cancel{
    NSMutableArray<AXActionItem *> *temp = [NSMutableArray array];
    for (NSString *title in actionArray) {
        AXActionItem *item = [AXActionItem.alloc init];
        item.title = title;
        [temp addObject:item];
    }
    [self ax_showSheetByiPadView:iPadView title:title message:message actionItems:temp confirm:confirm cancel:cancel];
    
}

#pragma mark - Alert 和 sheet

- (void)ax_showAlertWithStyle:(UIAlertControllerStyle )style
                     iPadView:(UIView *)iPadView
                        title:(NSMutableAttributedString *)titleAtt
                      message:(NSMutableAttributedString *)messageAtt
                  actionItems:(NSArray <id<AXAlertAction>>*)actionArray
                      confirm:(void(^)(NSInteger index))confirm
                       cancel:(void(^)(void))cancel {
    
    UIAlertController * alert = [UIAlertController alertControllerWithTitle:titleAtt.string message:messageAtt.string preferredStyle:style];
    if (titleAtt) {
        [alert setValue:titleAtt forKey:@"attributedTitle"];
    }
    if (messageAtt) {
        [alert setValue:messageAtt forKey:@"attributedMessage"];
    }
    [self _alertControllerAddAction:alert actionItems:actionArray confirm:confirm];
    
    [self _alert:alert addPadView:iPadView];
    [self presentViewController:alert animated:YES completion:nil];
}



/**
 Sheet 有取消回调
 
 @param iPadView iPad 需要显传入显示的view
 @param title title
 @param message message
 @param actionItems 其他按钮文字数组
 @param confirm 选中按钮回调
 */
- (void)ax_showSheetByiPadView:(UIView*)iPadView
                         title:(NSString *)title
                       message:(NSString*)message
                   actionItems:(NSArray <id<AXAlertAction>>*)actionArray
                       confirm:(void(^)(NSInteger index))confirm
                        cancel:(void(^)(void))cancel {
    
    UIAlertController * alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleActionSheet];
    
    [alert addAction:[UIAlertAction actionWithTitle:AXKitLocalizedString(@"ax.cancel") style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        if (cancel) {
            cancel();
        }
    }]];
    
    [self _alertControllerAddAction:alert actionItems:actionArray confirm:confirm];
    [self _alert:alert addPadView:iPadView];
    [self presentViewController:alert animated:YES completion:nil];
}

-(void)_alertControllerAddAction:(UIAlertController * )alert
                     actionItems:(NSArray <id<AXAlertAction>>*)actionArray
                         confirm:(void(^)(NSInteger index))confirm{
    
    [actionArray enumerateObjectsUsingBlock:^(AXActionItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj.title.length==0) {
            obj.title = @"";
        }
        UIAlertAction *action = [UIAlertAction actionWithTitle:obj.title style:obj.style handler:^(UIAlertAction * _Nonnull action) {
            if (confirm) {
                if (actionArray.count>idx && actionArray[idx].handler) {
                    actionArray[idx].handler();
                }
                confirm(idx);
            }
        }];
        
        if (obj.titleColor) {
            [action setValue:obj.titleColor forKey:@"_titleTextColor"];
        }
        
        if (obj.image) {
            [action setValue:obj.image forKey:@"image"];
        }
        
        if (obj.imageColor) {
            [action setValue:obj.imageColor forKey:@"_imageTintColor"];
        }
        [alert addAction:action];
        
    }];
}

-(void)_alert:(UIAlertController * )alert addPadView:(UIView*)iPadView {
    if (iPadView != nil) {
        alert.popoverPresentationController.sourceView = iPadView;
        alert.popoverPresentationController.sourceRect = iPadView.bounds;
    }
}

/**
 * Sheet 退出登录 兼容iPad需要传入view
 */
- (void)ax_showSheeLogoutByPadView:(UIView *)iPadView confirm:(void(^)(void))confirm{
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:AXKitLocalizedString(@"ax.logOut.message") preferredStyle:UIAlertControllerStyleActionSheet];
    
    [alert addAction:[UIAlertAction actionWithTitle:AXKitLocalizedString(@"ax.cancel") style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    }]];
    
    
    [alert addAction:[UIAlertAction actionWithTitle:AXKitLocalizedString(@"ax.logOut") style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        if (confirm) {
            confirm();
        }
    }]];
    [self _alert:alert addPadView:iPadView];
    [self presentViewController:alert animated:YES completion:nil];
    
}


/**
 * 数组 Alert 有取消回调
 */
- (void)ax_showAlertByiPadView:(UIView*)iPadView title:(NSString *)title message:(NSString*)message actionArray:(NSArray <NSString*>*)actionArray confirm:(void(^)(NSInteger index))confirm cancel:(void(^)(void))cancel{
    
    UIAlertController * alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    [alert addAction:[UIAlertAction actionWithTitle:AXKitLocalizedString(@"ax.cancel") style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
        if (cancel) {
            cancel();
        }
        
    }]];
    
    
    for (NSInteger index=0; index<actionArray.count; index++) {
        
        NSString *title = actionArray[index];
        
        [alert addAction:[UIAlertAction actionWithTitle:title style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            if (confirm) {
                confirm(index);
            }
            
        }]];
    }
    
    [self _alert:alert addPadView:iPadView];
    [self presentViewController:alert animated:YES completion:nil];
    
}

@end
