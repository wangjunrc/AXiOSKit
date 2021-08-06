//
//  _44FilesTableViewController.m
//  AXiOSKit
//
//  Created by 小星星吃KFC on 2021/8/9.
//  Copyright © 2021 axinger. All rights reserved.
//

#import "_44FilesTableViewController.h"
#import <AXiOSKit/AXiOSKit.h>
@interface _44FilesTableViewController ()

@property(nonatomic,strong)UIBarButtonItem *editButtonItem;

@property(nonatomic, strong) NSMutableArray *filePaths;
@end

@implementation _44FilesTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *path = self.path ? self.path:[NSString ax_documentDirectory];
    
    self.title = [path lastPathComponent];
    self.filePaths = [NSMutableArray array];
    NSArray *fileNames = [[NSFileManager defaultManager]contentsOfDirectoryAtPath:path error:nil];
    
    for (NSString *fileName in fileNames) {
        if ([fileName hasPrefix:@"."]) {
            continue;
        }
        NSLog(@"%@",fileName);
        NSString *filePath = [path stringByAppendingPathComponent:fileName];
        
        [self.filePaths addObject:filePath];
        
    }
    self.navigationItem.rightBarButtonItem =  self.editButtonItem;
    
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.filePaths.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    
    NSString *filePath = self.filePaths[indexPath.row];
    cell.textLabel.text = [filePath lastPathComponent];
    
    
    //判断是否是文件夹
    if ([self isDirectoryOfPath:filePath]) {
        cell.imageView.image = [UIImage imageNamed:@"icon_document"];
    }else{
        cell.imageView.image = [UIImage imageNamed:@"icon_file"];
    }
    return cell;
}



//判断是否为文件夹的 function

- (BOOL)isDirectoryOfPath:(NSString *)path{
    
    NSFileManager *fm = [NSFileManager defaultManager];
    
    BOOL isDir = NO;
    //方法返回值判断的是文件是否存在
    if ([fm fileExistsAtPath:path isDirectory:&isDir]&&isDir) {
        return YES;
    }
    
    return NO;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *filePath = self.filePaths[indexPath.row];
    
    //判断是否是文件夹
    if ([self isDirectoryOfPath:filePath]) {
        
        _44FilesTableViewController *vc = [_44FilesTableViewController new];
        vc.path = filePath;
        [self.navigationController pushViewController:vc animated:YES];
        
    }else if ([filePath hasSuffix:@"mp4"]){
        
        AVPlayerViewController *vc = [AVPlayerViewController new];
        vc.player = [[AVPlayer alloc]initWithURL:[NSURL fileURLWithPath:filePath]];
        
        [vc.player play];
        
        [self.navigationController pushViewController:vc animated:YES];
    }else if ([filePath.lowercaseString hasSuffix:@"jpg".lowercaseString]||[filePath.lowercaseString hasSuffix:@"png".lowercaseString] ||[filePath.lowercaseString hasSuffix:@"jpeg".lowercaseString]){
        UIViewController *vc = [UIViewController new];
        vc.view.backgroundColor = [UIColor whiteColor];
        UIImageView *iv = [[UIImageView alloc]initWithFrame:self.view.bounds];
        [vc.view addSubview:iv];
        iv.image = [UIImage imageWithContentsOfFile:filePath];
        
        [self.navigationController pushViewController:vc animated:YES];
        
    }else if ([filePath hasSuffix:@"mp3"]){
        
//        self.player = [[AVAudioPlayer alloc]initWithContentsOfURL:[NSURL fileURLWithPath:filePath] error:nil];
//        [self.player play];
        
    }else if([filePath hasSuffix:@"rtf"]||[filePath hasSuffix:@"txt"]||[filePath hasSuffix:@".h"]||[filePath hasSuffix:@".m"]){
        
        
        UIViewController *vc = [UIViewController new];
        vc.view.backgroundColor = [UIColor whiteColor];
        UITextView *tv = [[UITextView alloc]initWithFrame:self.view.bounds];
        [vc.view addSubview:tv];
        tv.text = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
        [self.navigationController pushViewController:vc animated:YES];
        
        
        
        
    }else{
        
        UIAlertController *ac = [UIAlertController alertControllerWithTitle:@"提示" message:@"目前版本暂不支持此格式，请期待下一版本！" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
        
        [ac addAction:action1];
        
        
        [self presentViewController:ac animated:YES completion:nil];
        
        
    }
}


@end
