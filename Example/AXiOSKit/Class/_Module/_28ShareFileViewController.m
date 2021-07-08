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
#import "_28LocalSocketClientViewController.h"
#import "_28LocalSocketServiceViewController.h"

#import <QuickLook/QuickLook.h>
#import <AXiOSKit/AXiOSKit.h>
@import ReactiveObjC;

@interface _28ShareFileViewController ()<UIDocumentInteractionControllerDelegate,QLPreviewControllerDataSource,QLPreviewControllerDelegate>

@property(nonatomic, strong) UIDocumentInteractionController *documentController;

@property(nonatomic, strong) NSMutableArray<id<QLPreviewItem>> *dataArray;


@end

@implementation _28ShareFileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"分享文件,已经去除了自己APP";
    // https://pspdfkit.com/blog/2016/hiding-action-share-extensions-in-your-own-apps/
    self.view.backgroundColor = UIColor.whiteColor;
    
    __weak typeof(self) weakSelf = self;
    

    
    
#pragma mark - UIActivityViewController
    [self _titlelabel:@"UIActivityViewController"];
    [self _buttonTitle:@"系统分享,自定义按钮,可以分享图片" handler:^(UIButton * _Nonnull btn) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        [strongSelf _test_UIActivity];
    }];
    
#pragma mark - wkwebView
    //https://www.jianshu.com/p/a83483647f4c?ivk_sa=1024320u
    [self _titlelabel:@"webView预览 excel,适配,因为UIDocumentInteractionController不能适配"];
    [self _buttonTitle:@"webView 预览excel" handler:^(UIButton * _Nonnull btn) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        [strongSelf _show_excel_of_webview];
    }];
    
#pragma mark - UIDocumentInteractionController
    
    [self _titlelabel:@"UIDocumentInteractionController"];
    [self _buttonTitle:@"直接预览 或者 使用AirDrop" handler:^(UIButton * _Nonnull btn) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        [strongSelf _test_UIDocumentInteractionController];
    }];
    
    [self _buttonTitle:@"文件夹" handler:^(UIButton * _Nonnull btn) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        NSString* path = [NSString ax_documentPath];
        [strongSelf _preview_UIDocumentInteractionController:path];
    }];
    
    [self _buttonTitle:@"创建一个excel并分享" handler:^(UIButton * _Nonnull btn) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        [strongSelf createXLSFile];
    }];
    
#pragma mark - QLPreviewController
    [self _titlelabel:@"QLPreviewController,可以多页同时预览"];
    [self _buttonTitle:@"QuickLook预览文件" handler:^(UIButton * _Nonnull btn) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        [strongSelf _test_QLPreviewController];
    }];
    
    [self _titlelabel:@"sys/socket.h"];
    [self _buttonTitle:@"local socket-服务端" handler:^(UIButton * _Nonnull btn) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        [strongSelf _test_socket];
    }];
    
    // 这里放最后一个view的底部
    [self _lastLoadBottomAttribute];
}


- (void)_show_excel_of_webview {
    NSString *jsString = @"var script = document.createElement('meta');"
    "script.name = 'viewport';"
    "script.content=\"width=device-width, initial-scale=1.0, minimum-scale=1.0, user-scalable=yes\";"
    "document.getElementsByTagName('head')[0].appendChild(script);";
    
    NSURL *URL = [NSBundle.mainBundle URLForResource:@"office.bundle/share2.xlsx" withExtension:nil];
    AXWKWebVC *vc = [AXWKWebVC.alloc initWithURL:URL];
    
    [vc addUserScript:jsString time:WKUserScriptInjectionTimeAtDocumentEnd];
    [self ax_pushVC:vc];
}



#pragma mark - 方法
-(void)_test_UIActivity {
    
    MyActivity *item1 = [[MyActivity alloc] init];
    CopyActivity *item2 = [[CopyActivity alloc] init];
    NSString *url = [[NSBundle mainBundle] pathForResource:@"office.bundle/share2.xlsx" ofType:nil];
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
}

-(void)_test_UIDocumentInteractionController{
    
    NSArray<NSString *> *temp =@[
        @"testWord.docx",
        @"share2.xlsx" ,
        @"test_number.numbers",
        @"testPDF.pdf",
        @"test.zip",
        @"photo.html",
    ];
    
    @weakify(self)
    [self ax_showSheetByTitle:@"选择UIDocumentInteractionController打开类型" message:@"" actionArray:temp confirm:^(NSInteger index) {
        @strongify(self);
        NSString *name = [NSString stringWithFormat:@"office.bundle/%@",temp[index]];
        NSString *path =[NSBundle.mainBundle pathForResource:name ofType:nil];
        [self _preview_UIDocumentInteractionController:path];
    }];
}



-(void)_preview_UIDocumentInteractionController:(NSString *)path {
    
    @weakify(self)
    [self ax_showSheetByTitle:@"选择UIDocumentInteractionController打开类型" message:@"" actionArray:@[@"直接预览",@"使用AirDrop"] confirm:^(NSInteger index) {
        @strongify(self);
        self.documentController = [UIDocumentInteractionController interactionControllerWithURL:[NSURL fileURLWithPath:path]];
        self.documentController.delegate = self;
        
        if (index==0) {
            [self.documentController  presentPreviewAnimated:YES];
        }else if(index==1){
            [self.documentController presentOptionsMenuFromRect:self.view.bounds inView:self.view animated:YES];
        }
        
    }];
    
}

-(void)_test_socket {
    _28LocalSocketServiceViewController *vc = [_28LocalSocketServiceViewController ax_init];
    [self ax_pushVC:vc];
}

- (void)createXLSFile {
    
    // 第一行内容,及列个数
    NSArray<NSString *> *titleArray = @[
        @"Person",
        @"Time",
        @"Address",
        @"Reason" ,
        @"Process",
        @"Result"
    ];
    //     方法一
    //    NSUInteger column = titleArray.count;
    //
    //    // 创建存放XLS文件数据的数组
    //    NSMutableArray  *xlsDataMuArr = NSMutableArray.array;
    //    [xlsDataMuArr addObjectsFromArray:titleArray];
    //
    //    // 10行数据
    //    for (int i = 0; i < 10; i ++) {
    //        [xlsDataMuArr addObject:[NSString stringWithFormat:@"jim-%d",i]];
    //        [xlsDataMuArr addObject:@"2021-01-01"];
    //        [xlsDataMuArr addObject:@"地址1"];
    //        [xlsDataMuArr addObject:@"Reason22"];
    //        [xlsDataMuArr addObject:@"Process333"];
    //        [xlsDataMuArr addObject:@"Result444"];
    //    }
    //
    //    // 把数组拼接成字符串，连接符是 \t（功能同键盘上的tab键）
    //    // 字符串转换为可变字符串，方便改变某些字符
    //    NSMutableString *muStr = [xlsDataMuArr componentsJoinedByString:@"\t"].mutableCopy;
    //
    //    AXLoger(@"muStr替换前=\n%@",muStr);
    //
    //    // 新建一个可变数组，存储每行最后一个\t的下标（以便改为\n）
    //    NSMutableArray *subMuArr = [NSMutableArray array];
    //
    //    for (int i = 0; i < muStr.length; i ++) {
    //        NSRange range = [muStr rangeOfString:@"\t" options:NSBackwardsSearch range:NSMakeRange(i, 1)];
    //        if (range.length == 1) {
    //            [subMuArr addObject:@(range.location)];
    //        }
    //    }
    //
    //    // 替换末尾\t,每行换行
    //    for (NSUInteger i = 0; i < subMuArr.count; i ++) {
    //        if ( i > 0 && (i%column == 0) ) {
    //            [muStr replaceCharactersInRange:NSMakeRange([subMuArr[i-1] intValue], 1) withString:@"\n"];
    //        }
    //    }
    
    // 方法二
    
    NSMutableString *muStr = NSMutableString.string;
    /// 制表
    [muStr appendString:[titleArray componentsJoinedByString:@"\t"]];
    /// 换行
    [muStr appendString:@"\n"];
    for (int i = 0; i < 10; i ++) {
        NSMutableArray *tempArray = NSMutableArray.array;
        [tempArray addObject:[NSString stringWithFormat:@"中文名字-%d",i]];
        [tempArray addObject:[NSString ax_stringNowDateFormatter:@"yy-MM-dd HH:mm:ss:SSSS"]];
        [tempArray addObject:@"地址1"];
        [tempArray addObject:@"Reason22"];
        [tempArray addObject:@"Process333"];
        [tempArray addObject:@"Result444"];
        [muStr appendString:[tempArray componentsJoinedByString:@"\t"]];
        [muStr appendString:@"\n"];
    }
    
    NSString *dire = [NSString.ax_documentPath stringByAppendingPathComponent:@"Excel"];
    NSError *error = nil;
    
    /// 创建文件夹,没有就创建,有就不创建,不会覆盖,不用判断文件夹是否存在
    //    if (![NSFileManager.defaultManager fileExistsAtPath:dire]) {
    [NSFileManager.defaultManager createDirectoryAtPath:dire withIntermediateDirectories:YES attributes:nil error:&error];
    //    }
    
    // 文件路径
    NSString *name = [NSString stringWithFormat:@"%@.xlsx",NSString.ax_uuid];
    
    
    //    NSString *name = [NSString stringWithFormat:@"%@.xlsx",[NSString ax_stringNowDateFormatter:@"yy_MM_dd_HH_mm_ss_SSSS"]];
    NSString *filePath = [dire stringByAppendingPathComponent:name];
    AXLoger(@"创建excel文件路径=%@",filePath);
    [muStr writeToFile:filePath atomically:YES encoding:NSUTF8StringEncoding error:&error];
    //    NSFileHandle 用于追加写入
    if (!error) {
        [self _preview_UIDocumentInteractionController:filePath];
    }else {
        [self  ax_showAlertByTitle:error.localizedDescription];
    }
    
}

#pragma mark - UIDocumentInteractionControllerDelegate

- (UIViewController *)documentInteractionControllerViewControllerForPreview:(UIDocumentInteractionController *)controller {
    
    return self;
    
}

- (CGRect)documentInteractionControllerRectForPreview:(UIDocumentInteractionController *)controller{
    return self.view.bounds;
}


#pragma mark - QuickLook
-(void)_test_QLPreviewController {
    self.dataArray = NSMutableArray.array;
    NSArray<NSString *> *temp =@[
        @"office.bundle/testWord.docx",
        @"office.bundle/share2.xlsx" ,
        @"office.bundle/testPDF.pdf",
        @"office.bundle/test.zip",
        @"office.bundle/photo.html",
    ];
    
    [temp enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSString *uri = [NSBundle.mainBundle pathForResource:obj ofType:nil];
        if (uri) {
            NSURL *url =[NSURL fileURLWithPath:uri];
            if ([QLPreviewController canPreviewItem:url]) {
                [self.dataArray addObject:url];
            }else{
                NSLog(@"不支持此类文件预览 %@",obj);
            }
            
        }else{
            NSLog(@"文件不存在 %@",obj);
        }
    }];
    
    QLPreviewController *qlPreVC = [[QLPreviewController alloc] init];
    qlPreVC.delegate = self;
    qlPreVC.dataSource = self;
    qlPreVC.title = @"文件";
    [qlPreVC setCurrentPreviewItemIndex:0];
    [self.navigationController pushViewController:qlPreVC animated:YES];
    
}


#pragma mark - QLPreviewControllerDataSource
// 预览的数量
- (NSInteger)numberOfPreviewItemsInPreviewController:(QLPreviewController *)controller {
    return self.dataArray.count;
}
// 控制器预览的内容
- (id<QLPreviewItem>)previewController:(QLPreviewController *)controller previewItemAtIndex:(NSInteger)index {
    return self.dataArray[index];
}

#pragma mark - QLPreviewControllerDelegate
// 预览界面将要消失
- (void)previewControllerWillDismiss:(QLPreviewController *)controller {
    
}
// 预览界面已经消失
- (void)previewControllerDidDismiss:(QLPreviewController *)controller {
    
}
// 文件内部链接点击是否进行外部跳转
- (BOOL)previewController:(QLPreviewController *)controller shouldOpenURL:(NSURL *)url forPreviewItem:(id <QLPreviewItem>)item {
    return YES;
}

@end
