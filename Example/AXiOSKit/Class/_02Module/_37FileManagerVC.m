//
//  _37FileManagerVC.m
//  AXiOSKit
//
//  Created by 小星星吃KFC on 2021/3/20.
//  Copyright © 2021 axinger. All rights reserved.
//

#import "_37FileManagerVC.h"

@interface _37FileManagerVC ()

@end

@implementation _37FileManagerVC

- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self _buttonTitle:@"创建文件" handler:^(UIButton * _Nonnull btn) {
        [self createFile];
        [self writeFile];
        [self readFileContent];
    }];
    
    
    [self _buttonTitle:@"创建移动文件" handler:^(UIButton * _Nonnull btn) {
      
        NSString *documentsPath =[self getDocumentsPath];
        
        NSFileManager *fileManager = NSFileManager.defaultManager ;
        
        
        NSString *moveToPath = [documentsPath stringByAppendingPathComponent:@"move/a/iOS.txt"];
        NSLog(@"stringByDeletingLastPathComponent = %@",moveToPath.stringByDeletingLastPathComponent);
        BOOL ret1 = [fileManager createDirectoryAtPath:moveToPath.stringByDeletingLastPathComponent withIntermediateDirectories:YES attributes:nil error:nil];//执行这句话就已经创建目录
     
        NSLog(@"创建移动文件 = %d",ret1);
        
    }];
    
    

    
    
    [self _buttonTitle:@"移动文件" handler:^(UIButton * _Nonnull btn) {
        [self moveFileName];
    }];
    
    
    [self _lastLoadBottomAttribute];
}

/// 2.创建文件
-(void)createFile{
    NSString *documentsPath =[self getDocumentsPath];
    NSFileManager *fileManager = NSFileManager.defaultManager ;
    NSString *iOSPath = [documentsPath stringByAppendingPathComponent:@"iOS.txt"];
    BOOL isSuccess = [fileManager createFileAtPath:iOSPath contents:nil attributes:nil];
    if (isSuccess) {
        NSLog(@"success");
    } else {
        NSLog(@"fail");
    }
}

/// 3.写文件
-(void)writeFile{
    NSString *documentsPath =[self getDocumentsPath];
    NSString *iOSPath = [documentsPath stringByAppendingPathComponent:@"iOS.txt"];
    NSString *content = @"我要写数据啦";
    BOOL isSuccess = [content writeToFile:iOSPath atomically:YES encoding:NSUTF8StringEncoding error:nil];
    if (isSuccess) {
        NSLog(@"write success");
    } else {
        NSLog(@"write fail");
    }
}

/// 4.读取文件内容
-(void)readFileContent{
    NSString *documentsPath =[self getDocumentsPath];
    NSString *iOSPath = [documentsPath stringByAppendingPathComponent:@"iOS.txt"];
    NSString *content = [NSString stringWithContentsOfFile:iOSPath encoding:NSUTF8StringEncoding error:nil];
    NSLog(@"read success: %@",content);
}

/// 5.判断文件是否存在
- (BOOL)isSxistAtPath:(NSString *)filePath{
    NSFileManager *fileManager = NSFileManager.defaultManager ;
    BOOL isExist = [fileManager fileExistsAtPath:filePath];
    return isExist;
}

/// 9.移动文件
- (void)moveFileName
{
    NSString *documentsPath =[self getDocumentsPath];
    NSFileManager *fileManager = NSFileManager.defaultManager ;
    NSString *filePath = [documentsPath stringByAppendingPathComponent:@"iOS.txt"];
    
    NSString *moveToPath = [documentsPath stringByAppendingPathComponent:@"move/a/iOS.txt"];
    
    BOOL isSuccess = [fileManager moveItemAtPath:filePath toPath:moveToPath error:nil];
    if (isSuccess) {
        NSLog(@"rename success");
    }else{
        NSLog(@"rename fail");
    }
}

- (NSString *)getDocumentsPath
{
    //获取Documents路径
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = [paths objectAtIndex:0];
    NSLog(@"path:%@", path);
    return path;
}




@end
