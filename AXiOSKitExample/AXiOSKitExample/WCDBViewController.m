//
//  WCDBViewController.m
//  AXiOSKitExample
//
//  Created by liuweixing on 2020/3/9.
//  Copyright © 2020 liu.weixing. All rights reserved.
//

#import "WCDBViewController.h"
#import "SoundRecordDB.h"
#import "BAThemeListModel.h"
#import <AXiOSKit/AXiOSKit.h>
#import <AXiOSKit/AXNetworkManager.h>
#import "AXNetworkManager.h"

@interface WCDBViewController ()
@property (weak, nonatomic) IBOutlet UITextField *tf;
@property (weak, nonatomic) IBOutlet UITextField *tf2;

/**
 * <#注释#>
 */
@property(nonatomic,strong)AXNetworkManager *manager;
@end

@implementation WCDBViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    
    [MBProgressHUD ax_showProgressMessage:@"加载..." toView:self.view];
   self.manager = AXNetworkManager.manager;
    axSelfWeak;
    self.manager.get(@"http://127.0.0.1:8091/test?time=5").successHandler(^(id  _Nonnull JSONObject) {
        axSelfStrong;
        NSLog(@"JSONObject = %@  ,view = %p",JSONObject,self);
        [ MBProgressHUD HUDForView:self.view];
    }).failureHandler(^(NSError * _Nonnull error) {
         axSelfStrong;
        NSLog(@"error = %@  view = %p",error,self);
        [ MBProgressHUD HUDForView:self.view];
    }).start();
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    AXLogFunc;
//    self.manager.cancel();
}

-(void)dealloc{
    axLong_dealloc;
    
}
- (IBAction)addDB:(id)sender {
    BAThemeListModel *model = [[BAThemeListModel alloc]init];
    
    NSString *Id = self.tf.text;
    
    model.resourceId = [NSString stringWithFormat:@"%@",Id];
    model.name = [NSString stringWithFormat:@"name%@",Id];
    model.date = [NSDate date];
    
    SoundRecordDB *db = [SoundRecordDB sharedSoundRecordDB];
    BOOL result = [db insertWithModel:model];
    NSLog(@"result插入数据 %@",result ? @"成功" : @"失败");
}

- (IBAction)readDB:(id)sender {
    SoundRecordDB *db = [SoundRecordDB sharedSoundRecordDB];
    NSString *Id = self.tf2.text;
    
    BAThemeListModel *model = [db getOneById:Id];
    NSLog(@"model = %@",[model mj_JSONObject]);
    
}

@end
