//
//  AXNetworkTestViewController.m
//  AXiOSKitExample
//
//  Created by liuweixing on 2019/12/26.
//  Copyright © 2019 liu.weixing. All rights reserved.
//

#import "AXNetworkTestViewController.h"

@interface AXNetworkTestViewController ()

@end

@implementation AXNetworkTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}
- (IBAction)action1:(id)sender {
    
    //        AXNetworkManager.manager.get(@"http://localhost:8080/login.do").addParameters(@{@"username":@"jim",@"password":@"123456"}).successHandler(^(id  _Nonnull json) {
    //
    //            AXLoger(@"json>> %@",json);
    //
    //        }).failureHandler(^(NSError * _Nonnull error) {
    //             AXLoger(@"error>> %@",error);
    //        }).start();
            
    //        [AXNetManager getURL:@"http://localhost:8080/login.do" parameters:@{@"username":@"jim",@"password":@"123456"} success:^(id json) {
    //            AXLoger(@"json>> %@",json);
    //        } failure:^(NSError *error) {
    //            AXLoger(@"error>> %@",error);
    //        }];
            
    //        AXNetworkManager.managerWithURL(@"http://localhost:8080").post(@"/login.do").addParameters(@{@"username":@"jim",@"password":@"123456"}).successHandler(^(id  _Nonnull json) {
    //
    //            NSLog(@"json>> %@",json);
    //
    //        }).failureHandler(^(NSError * _Nonnull error) {
    //             NSLog(@"error>> %@",error);
    //        }).start();
            
    //        AXNetworkManager.managerWithURL(@"http://localhost:8080").post(@"/loginList.do").serializerType(AxRequestSerializerTypeJSON).addParameters(@[@{@"username":@"jim",@"password":@"123456"},@{@"username":@"jim2",@"password":@"123456"}]).successHandler(^(id  _Nonnull json) {
    //
    //            NSLog(@"json>> %@",json);
    //
    //        }).failureHandler(^(NSError * _Nonnull error) {
    //             NSLog(@"error>> %@",error);
    //        }).start();
    //        @{@"username":@"jim",@"password":@"123456"},@{@"username":@"jim2",@"password":@"123456"}
            
           
    //        NSDictionary *dict = @{@"list": @[@{@"username":@"jim",@"password":@"123456"},@{@"username":@"jim2",@"password":@"123456"}]};
    //
    //
    //        AXNetworkManager.managerWithURL(@"http://localhost:8080").post(@"/ loginList2.do").addParameters(dict).successHandler(^(id  _Nonnull json) {
    //
    //            NSLog(@"json>> %@",json);
    //
    //        }).failureHandler(^(NSError * _Nonnull error) {
    //             NSLog(@"error>> %@",error);
    //        }).start();
           
         
    //        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //
    //              manager.requestSerializer = [AFJSONRequestSerializer serializer];
    //
    //        NSString *url = [NSString stringWithFormat:@"http://localhost:8080/loginList2.do?%@",dict.ax_toJSONString];
    //        NSLog(@"url %@",url);
    //
    //        [manager POST:@"http://localhost:8080/loginList2.do" parameters:dict.ax_toJSONString progress:^(NSProgress * _Nonnull uploadProgress) {
    //
    //        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
    //            NSLog(@"%@",responseObject);
    //        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    //
    //        }];
            
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
