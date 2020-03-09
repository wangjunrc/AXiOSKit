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

@interface WCDBViewController ()
@property (weak, nonatomic) IBOutlet UITextField *tf;
@property (weak, nonatomic) IBOutlet UITextField *tf2;

@end

@implementation WCDBViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
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
