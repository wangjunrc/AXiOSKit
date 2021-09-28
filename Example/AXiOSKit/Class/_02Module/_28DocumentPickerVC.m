//
//  _28DocumentPickerVC.m
//  AXiOSKit
//
//  Created by axinger on 2021/9/28.
//  Copyright © 2021 axinger. All rights reserved.
//

#import "_28DocumentPickerVC.h"
@import ReactiveObjC;
@import AXiOSKit;

@interface _28DocumentPickerVC ()<UIDocumentPickerDelegate>

@property (nonatomic, strong) UIDocumentPickerViewController *documentPickerVC;


@property(nonatomic, strong)  NSData *fileData;

@end

@implementation _28DocumentPickerVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"UIDocumentPickerViewController";
    
    @weakify(self)
    [self _buttonTitle:@"打开文件系统" handler:^(UIButton * _Nonnull btn) {
        @strongify(self)
        [self presentViewController:self.documentPickerVC animated:YES completion:nil];
    }];
    
    
    [self _buttonTitle:@"保存到文件系统" handler:^(UIButton * _Nonnull btn) {
        @strongify(self)
        [self saveFile];
    }];
    
    [self _lastLoadBottomAttribute];
}



/**
 初始化 UIDocumentPickerViewController
 
 @param allowedUTIs 支持的文件类型数组
 "public.content",
 "public.text",
 "public.source-code",
 "public.image",
 "public.audiovisual-content",
 "com.adobe.pdf",
 "com.apple.keynote.key",
 "com.microsoft.word.doc",
 "com.microsoft.excel.xls",
 "com.microsoft.powerpoint.ppt"
 @param mode 支持的共享模式
 */
- (UIDocumentPickerViewController *)documentPickerVC {
    if (!_documentPickerVC) {
        NSArray *types = @[@"public.content",
                           @"public.text",
                           @"public.source-code",
                           @"public.image",
                           @"public.jpeg",
                           @"public.png",
                           @"com.adobe.pdf",
                           @"com.apple.keynote.key",
                           @"com.microsoft.word.doc",
                           @"com.microsoft.excel.xls",
                           @"com.microsoft.powerpoint.ppt",
                           @"public.data"];
        _documentPickerVC = [[UIDocumentPickerViewController alloc] initWithDocumentTypes:types inMode:UIDocumentPickerModeOpen];
        // 设置代理
        _documentPickerVC.delegate = self;
        // 设置模态弹出方式
        _documentPickerVC.modalPresentationStyle = UIModalPresentationFormSheet;
    }
    return _documentPickerVC;
}

#pragma mark - UIDocumentPickerDelegate

- (void)documentPicker:(UIDocumentPickerViewController *)controller didPickDocumentsAtURLs:(NSArray<NSURL *> *)urls {
    // 获取授权
    BOOL fileUrlAuthozied = [urls.firstObject startAccessingSecurityScopedResource];
    if (fileUrlAuthozied) {
        // 通过文件协调工具来得到新的文件地址，以此得到文件保护功能
        NSFileCoordinator *fileCoordinator = [[NSFileCoordinator alloc] init];
        NSError *error;
        
        [fileCoordinator coordinateReadingItemAtURL:urls.firstObject options:0 error:&error byAccessor:^(NSURL *newURL) {
            // 读取文件
            NSString *fileName = [newURL lastPathComponent];
            NSError *error = nil;
            NSData *fileData = [NSData dataWithContentsOfURL:newURL options:NSDataReadingMappedIfSafe error:&error];
            
            
            if (error) {
                // 读取出错
            } else {
                // 上传
                NSLog(@"获得了文件 fileName=%@", fileName);
                // [self uploadingWithFileData:fileData fileName:fileName fileURL:newURL];
                self.fileData = fileData;
                [self ax_showAlertByTitle:[NSString stringWithFormat:@"获取了 fileData %ld,%@",fileData.length,newURL]];
                
            }
            //            [self dismissViewControllerAnimated:YES completion:NULL];
        }];
        [urls.firstObject stopAccessingSecurityScopedResource];
    } else {
        // 授权失败
    }
}

- (void)saveFile {
    NSURL *URL = [NSBundle.mainBundle URLForResource:@"office.bundle/testPDF.pdf" withExtension:nil];
    
    UIDocumentPickerViewController *documentPickerVC = [[UIDocumentPickerViewController alloc] initWithURL:URL inMode:UIDocumentPickerModeExportToService];
    // 设置代理
    documentPickerVC.delegate = self;
    // 设置模态弹出方式
    documentPickerVC.modalPresentationStyle = UIModalPresentationFormSheet;
    [self presentViewController:documentPickerVC animated:YES completion:nil];
}

@end
