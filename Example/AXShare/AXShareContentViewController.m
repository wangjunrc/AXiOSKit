//
//  AXShareContentViewController.m
//  AXShare
//
//  Created by 小星星吃KFC on 2020/12/18.
//  Copyright © 2020 axinger. All rights reserved.
//

#import "AXShareContentViewController.h"
#import "_03ChatFriendVC.h"
#import "_AXCellItem.h"
@interface AXShareContentViewController ()

@property (nonatomic, strong) NSString* shareType;

@property(nonatomic, strong) NSMutableArray<_AXCellItem *> *dataArray;

@end

@implementation AXShareContentViewController


- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.title = @"接收分享2";
    
    [self.tableView registerClass:UITableViewCell.class forCellReuseIdentifier:@"cellID"];
    
    UIBarButtonItem *cancelItem = [[UIBarButtonItem alloc]initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(cancelItemAction:)];
    
    self.navigationItem.leftBarButtonItems = @[cancelItem];
    
    UIBarButtonItem *confirmItem = [[UIBarButtonItem alloc]initWithTitle:@"确定" style:UIBarButtonItemStyleDone target:self action:@selector(confirmItemAction:)];
    self.navigationItem.rightBarButtonItems = @[confirmItem];
    
    
    //    [self pushViewController:vc animated:NO];
    //获取分享数据
    [self.extensionContext.inputItems enumerateObjectsUsingBlock:^(NSExtensionItem *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//        NSString* contentText = [obj.attributedContentText string];
        //        if (contentText && contentText.length >0) {
        //             [NSFileManager saveWithUserDefSuite:contentText andKey:ShareTitle];
        //        }else{
        //             [NSFileManager saveWithUserDefSuite:@"" andKey:ShareTitle];
        //        }
        
        [obj.attachments enumerateObjectsUsingBlock:^(NSItemProvider *  _Nonnull itemProvider, NSUInteger idx, BOOL * _Nonnull stop) {
            
            if ([itemProvider hasItemConformingToTypeIdentifier:@"public.url"])
            {
                
                [itemProvider loadItemForTypeIdentifier:@"public.url" options:nil completionHandler:^(id<NSSecureCoding>  _Nullable item, NSError * _Null_unspecified error) {
                    
                    if ([(NSObject *)item isKindOfClass:[NSURL class]])
                    {
                        //                        [self.sharedURLArr addObject:((NSURL*)item).absoluteString];
                    }
                    
                }];
                
            }else if ([itemProvider hasItemConformingToTypeIdentifier:@"public.image"])
            {
                //                self.shareType = ShareTypeImage;`
                [itemProvider loadItemForTypeIdentifier:@"public.image" options:nil completionHandler:^(id item, NSError *error) {
                    
                    //                    if ([item isKindOfClass:[NSURL class]])
                    //                    {
                    //                        [self.sharedURLArr addObject:((NSURL*)item).absoluteString];
                    //                    }
                    //                    else if ([item isKindOfClass:[UIImage class]])
                    //                    {
                    //                        NSLog(@"Warning:Shareextension shared UIImage object.");
                    //                    }
                }];
            }else if ([itemProvider hasItemConformingToTypeIdentifier:@"public.movie"])
            {
                [itemProvider loadItemForTypeIdentifier:@"public.movie" options:nil completionHandler:^(id<NSSecureCoding>  _Nullable item, NSError * _Null_unspecified error)
                 {
                    NSURL *fileurl = (NSURL *)item;
                    if ([fileurl isFileURL])
                    {
                        
                    }
                }];
            }
            
        }];
        
        
    }];
    
    
}



-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID" forIndexPath:indexPath];
    cell.textLabel.text = [NSString stringWithFormat:@"%ld",(long)indexPath.row];
    return cell;

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    _03ChatFriendVC *vc = _03ChatFriendVC.alloc.init;
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)confirmItemAction:(UIBarButtonItem *)sender {
    [self.extensionContext completeRequestReturningItems:@[] completionHandler:nil];
}

-(void)cancelItemAction:(UIBarButtonItem *)sender {
//    [self.navigationController dismissViewControllerAnimated:YES completion:nil];

    
    NSError *error = [NSError errorWithDomain:@"ax.kit.share" code:NSUserCancelledError userInfo:nil];
    [self.extensionContext cancelRequestWithError:error];
}
@end
