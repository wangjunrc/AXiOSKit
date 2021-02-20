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
    [self _p00ButtonTitle:@"系统分享,自定义按钮,可以分享图片" handler:^(UIButton * _Nonnull btn) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        [strongSelf _share0];
    }];
    [self _p00ButtonTitle:@"UIDocumentInteractionController" handler:^(UIButton * _Nonnull btn) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        [strongSelf _share1];
    }];
    [self _p00ButtonTitle:@"UIDocumentInteractionController-分享pdf" handler:^(UIButton * _Nonnull btn) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
      
        NSString *url = [[NSBundle mainBundle] pathForResource:@"office.bundle/testPDF.pdf" ofType:nil];
        strongSelf.documentController = [UIDocumentInteractionController interactionControllerWithURL:[NSURL fileURLWithPath:url]];
        [strongSelf.documentController presentOptionsMenuFromRect:self.view.bounds inView:self.view animated:YES];
        
        
    }];
    [self _p00ButtonTitle:@"UIDocumentInteractionController-2" handler:^(UIButton * _Nonnull btn) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        [strongSelf createXLSFile];
    }];
    [self _p00ButtonTitle:@"QuickLook预览文件" handler:^(UIButton * _Nonnull btn) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        [strongSelf _look];
    }];
    
    [self _p00ButtonTitle:@"local socket-服务端" handler:^(UIButton * _Nonnull btn) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        [strongSelf _share2];
    }];
    
    // 这里放最后一个view的底部
    [self _loadBottomAttribute];
}

-(void)_share0 {
    
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


-(void)_share1 {
    
    NSString *url = [[NSBundle mainBundle] pathForResource:@"office.bundle/share2.xlsx" ofType:nil];
    self.documentController = [UIDocumentInteractionController interactionControllerWithURL:[NSURL fileURLWithPath:url]];
    [self.documentController presentOptionsMenuFromRect:self.view.bounds inView:self.view animated:YES];
    
}
-(void)_share2 {
    _28LocalSocketServiceViewController *vc = [_28LocalSocketServiceViewController ax_init];
    [self ax_pushVC:vc];
}

- (void)createXLSFile {
    
    // 创建存放XLS文件数据的数组
    
    NSMutableArray  *xlsDataMuArr = [[NSMutableArray alloc] init];
    
    // 第一行内容
    
    [xlsDataMuArr addObject:@"Time"];
    
    [xlsDataMuArr addObject:@"Address"];
    
    [xlsDataMuArr addObject:@"Person"];
    
    [xlsDataMuArr addObject:@"Reason"];
    
    [xlsDataMuArr addObject:@"Process"];
    
    [xlsDataMuArr addObject:@"Result"];
    
    // 10行数据
    
    for (int i = 0; i < 10; i ++) {
        
        [xlsDataMuArr addObject:@"下班时间"];
        
        [xlsDataMuArr addObject:@"大连"];
        
        [xlsDataMuArr addObject:@"弄啪波勒"];
        
        [xlsDataMuArr addObject:@"哦"];
        
        [xlsDataMuArr addObject:@"很酷"];
        
        [xlsDataMuArr addObject:@"又很帅气"];
        
    }
    
    // 把数组拼接成字符串，连接符是 \t（功能同键盘上的tab键）
    
    NSString *fileContent = [xlsDataMuArr componentsJoinedByString:@"\t"];
    
    // 字符串转换为可变字符串，方便改变某些字符
    
    NSMutableString *muStr = [fileContent mutableCopy];
    
    // 新建一个可变数组，存储每行最后一个\t的下标（以便改为\n）
    
    NSMutableArray *subMuArr = [NSMutableArray array];
    
    for (int i = 0; i < muStr.length; i ++) {
        
        NSRange range = [muStr rangeOfString:@"\t" options:NSBackwardsSearch range:NSMakeRange(i, 1)];
        
        if (range.length == 1) {
            
            [subMuArr addObject:@(range.location)];
            
        }
        
    }
    
    // 替换末尾\t
    
    for (NSUInteger i = 0; i < subMuArr.count; i ++) {
        
#warning  下面的6是列数，根据需求修改
        
        if ( i > 0 && (i%6 == 0) ) {
            
            [muStr replaceCharactersInRange:NSMakeRange([[subMuArr objectAtIndex:i-1] intValue], 1) withString:@"\n"];
            
        }
        
    }
    
    // 文件管理器
    
    NSFileManager *fileManager = [[NSFileManager alloc]init];
    
    //使用UTF16才能显示汉字；如果显示为#######是因为格子宽度不够，拉开即可
    
    NSData *fileData = [muStr dataUsingEncoding:NSUTF16StringEncoding];
    
    // 文件路径
    
    NSString *path = NSHomeDirectory();
    
    NSString *filePath = [path stringByAppendingPathComponent:@"/Documents/export.xlsx"];
    
    AXLoger(@"文件路径：\n%@",filePath);
    
    // 生成xls文件
    
    [fileManager createFileAtPath:filePath contents:fileData attributes:nil];
    
    
    // 调用safari分享功能将文件分享出去
    
    UIDocumentInteractionController *documentIc = [UIDocumentInteractionController interactionControllerWithURL:[NSURL fileURLWithPath:filePath]];
    
    // 记得要强引用UIDocumentInteractionController,否则控制器释放后再次点击分享程序会崩溃
    
    self.documentController = documentIc;
    
    // 如果需要其他safari分享的更多交互,可以设置代理
    
    documentIc.delegate = self;
    
    // 设置分享显示的矩形框
    
    CGRect rect = CGRectMake(0, 0, 300, 300);
    
    [documentIc presentOpenInMenuFromRect:rect inView:self.view animated:YES];
    
    [documentIc presentPreviewAnimated:YES];
    
}




#pragma mark - UIDocumentInteractionControllerDelegate

- (UIViewController *)documentInteractionControllerViewControllerForPreview:(UIDocumentInteractionController *)controller {
    
    return self;
    
}

- (CGRect)documentInteractionControllerRectForPreview:(UIDocumentInteractionController *)controller{
    return self.view.bounds;
}


#pragma mark - QuickLook
-(void)_look {
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
