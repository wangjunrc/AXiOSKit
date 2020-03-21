//
//  AFNViewController.m
//  AXiOSKitExample
//
//  Created by liuweixing on 2020/3/21.
//  Copyright © 2020 liu.weixing. All rights reserved.
//

#import "AFNViewController.h"
#import <AXiOSKit/AXiOSKit.h>
#import <AXiOSKit/AXNetworkManager.h>
#import "AXNetworkManager.h"
#import "TZImagePickerController.h"
#import "AXNetManager+Upload.h"

@interface AFNViewController ()

/**
 * 注释
 */
@property(nonatomic,strong)AXNetworkManager *manager;

@end

@implementation AFNViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.manager = AXNetworkManager.manager;
}

- (IBAction)afn1:(id)sender {
    self.manager.get(@"http://localhost:8091/sleep?time=5").successHandler(^(id  _Nonnull JSONObject) {
        NSLog(@"JSONObject1 = %@",JSONObject);
        
    }).failureHandler(^(NSError * _Nonnull error) {
        NSLog(@"error1 = %@",error.description);
    }).start();
    
}

- (IBAction)afn2:(id)sender {
    
    self.manager.get(@"http://localhost:8091/sleep?time=1").successHandler(^(id  _Nonnull JSONObject) {
        NSLog(@"JSONObject2 = %@",JSONObject);
        
    }).failureHandler(^(NSError * _Nonnull error) {
        NSLog(@"error2 = %@",error.description);
    }).start();
    
}

- (IBAction)download:(id)sender {
    NSString *path = NSHomeDirectory();
    NSLog(@"path = %@",path);
    
    [AXNetManager postDownURL:@"http://127.0.0.1:8091/downFile?id=123" showStatus:YES downPath:path progress:^(float aProgress) {
        
    } success:^(NSString *filePath) {
        NSLog(@"filePath = %@",filePath);
    } failure:^(NSInteger statusCode) {
        NSLog(@"statusCode = %ld",statusCode);
    }];
    
}

- (IBAction)upload:(id)sender {
}


@end
