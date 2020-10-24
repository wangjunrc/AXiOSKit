//
//  _28ShareFileViewController.m
//  AXiOSKit_Example
//
//  Created by 小星星吃KFC on 2020/10/24.
//  Copyright © 2020 axinger. All rights reserved.
//

#import "_28ShareFileViewController.h"
#import "MyActivity.h"
#import "CopyActivity.h"

@interface _28ShareFileViewController ()<UIDocumentInteractionControllerDelegate>

@property(nonatomic, strong) UIDocumentInteractionController *documentController;

@end

@implementation _28ShareFileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    [self _loginTest];
}


-(void)_loginTest {
    
    UIView *topView = self.view;
    
    {
        UIButton *btn1 = [[UIButton alloc]init];
        [btn1 setTitle:@"系统分享,自定义按钮,可以分享图片" forState:UIControlStateNormal];
        btn1.backgroundColor = UIColor.orangeColor;
        [self.view addSubview:btn1];
        [btn1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.mas_equalTo(30);
            
        }];
        __weak typeof(self) weakSelf = self;
        [btn1 ax_addTargetBlock:^(UIButton * _Nullable button) {
            __strong typeof(weakSelf) self = weakSelf;
            
            MyActivity *item1 = [[MyActivity alloc] init];
            CopyActivity *item2 = [[CopyActivity alloc] init];
            
//            NSString *url = [[NSBundle mainBundle] pathForResource:@"App" ofType:@"pdf"];
            NSString *url = [[NSBundle mainBundle] pathForResource:@"share2.xlsx" ofType:nil];
            if (!url) {
                [self ax_showAlertByTitle:@"URL不存在"];
                return;;
            }
            NSURL *pdfURL=[NSURL fileURLWithPath:url];
            
            // 1、设置分享的内容，并将内容添加到数组中
//            NSArray *activityItemsArray = @[@"A"];
            NSArray *activityItemsArray = @[pdfURL];
            
            NSArray *activityArray = @[item1, item2];
            
            // 2、初始化控制器，添加分享内容至控制器
            UIActivityViewController *activityVC =
            [[UIActivityViewController alloc]
             initWithActivityItems:activityItemsArray
             applicationActivities:activityArray];
            if (@available(iOS 13.0, *)) {
                activityVC.modalInPresentation = YES;
            } else {
                // Fallback on earlier versions
            }
            
            // ios8.0 之后用此方法回调
            UIActivityViewControllerCompletionWithItemsHandler itemsBlock =
            ^(UIActivityType __nullable activityType, BOOL completed,
              NSArray *__nullable returnedItems,
              NSError *__nullable activityError) {
                NSLog(@"activityType == %@", activityType);
                if (completed == YES) {
                    NSLog(@"completed");
                } else {
                    NSLog(@"cancel");
                }
            };
            activityVC.completionWithItemsHandler = itemsBlock;
            
            //不出现在活动项目
            activityVC.excludedActivityTypes = @[
                UIActivityTypePrint, UIActivityTypeCopyToPasteboard,
                UIActivityTypeAssignToContact, UIActivityTypeSaveToCameraRoll,
                @"com.ax.kit"
            ];
            
            // 4、调用控制器
            [self presentViewController:activityVC animated:YES completion:nil];
        }];
        topView = btn1;
    }
    {
        UIButton *btn1 = [[UIButton alloc]init];
        [btn1 setTitle:@"UIDocumentInteractionController" forState:UIControlStateNormal];
        btn1.backgroundColor = UIColor.orangeColor;
        [self.view addSubview:btn1];
        [btn1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(30);
            make.top.equalTo(topView.mas_bottom).mas_equalTo(30);
        }];
        __weak typeof(self) weakSelf = self;
        [btn1 ax_addTargetBlock:^(UIButton * _Nullable button) {
            __strong typeof(weakSelf) self = weakSelf;
            NSString *url = [[NSBundle mainBundle] pathForResource:@"App" ofType:@"pdf"];
            self.documentController = [UIDocumentInteractionController interactionControllerWithURL:[NSURL fileURLWithPath:url]];
            [self.documentController presentOptionsMenuFromRect:self.view.bounds inView:self.view animated:YES];
        }];
        topView = btn1;
    }
    {
        UIButton *btn1 = [[UIButton alloc]init];
        [btn1 setTitle:@"UIDocumentInteractionController" forState:UIControlStateNormal];
        btn1.backgroundColor = UIColor.orangeColor;
        [self.view addSubview:btn1];
        [btn1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(30);
            make.top.equalTo(topView.mas_bottom).mas_equalTo(30);
        }];
        __weak typeof(self) weakSelf = self;
        [btn1 ax_addTargetBlock:^(UIButton * _Nullable button) {
            __strong typeof(weakSelf) self = weakSelf;
//            NSString *url = [[NSBundle mainBundle] pathForResource:@"App" ofType:@"pdf"];
            NSString *url = [[NSBundle mainBundle] pathForResource:@"share2.xlsx" ofType:nil];
            if (!url) {
                [self ax_showAlertByTitle:@"URL不存在"];
            }else{
                
                self.documentController = [UIDocumentInteractionController interactionControllerWithURL:[NSURL fileURLWithPath:url]];
                self.documentController.delegate = self;
                //直接预览
                [self.documentController presentPreviewAnimated:YES];
            }
              
        }];
        topView = btn1;
    }
}

#pragma mark - UIDocumentInteractionControllerDelegate

- (UIViewController *)documentInteractionControllerViewControllerForPreview:(UIDocumentInteractionController *)controller {
    
    return self;
    
}
@end
