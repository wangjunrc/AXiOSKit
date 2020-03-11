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
#import "TZImagePickerController.h"
#import "AXNetManager+Upload.h"

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
    
    
    //    [MBProgressHUD ax_showProgressMessage:@"加载..." toView:self.view];
    //   self.manager = AXNetworkManager.manager;
    //    axSelfWeak;
    //    self.manager.get(@"http://127.0.0.1:8091/test?time=5").successHandler(^(id  _Nonnull JSONObject) {
    //        axSelfStrong;
    //        NSLog(@"JSONObject = %@  ,view = %p",JSONObject,self);
    //        [ MBProgressHUD HUDForView:self.view];
    //    }).failureHandler(^(NSError * _Nonnull error) {
    //         axSelfStrong;
    //        NSLog(@"error = %@  view = %p",error,self);
    //        [ MBProgressHUD HUDForView:self.view];
    //    }).start();
    
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
- (IBAction)uploadImage1:(id)sender {
}
- (IBAction)uploadimage2:(id)sender {
    
    TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:9 delegate:nil];
    imagePickerVc. allowPickingMultipleVideo = YES;
    
    imagePickerVc.allowPickingVideo = NO;
    
    imagePickerVc.allowPickingGif = YES;
    
    imagePickerVc.allowPickingImage = YES;
    imagePickerVc.showSelectedIndex = YES;
    
    
    [imagePickerVc setDidFinishPickingPhotosWithInfosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto, NSArray<NSDictionary *> *infos) {
        NSLog(@"assets %@",assets);
        NSLog(@"infos %@",infos);
        
//        [self images:assets];
        
        [self images2:photos];
    }];
    [self presentViewController:imagePickerVc animated:YES completion:nil];
    
}
-(void)images2:(NSArray<UIImage *> *)photos{
    
    NSString *url = @"http://127.0.0.1:8091/uploadsimplefile";
    
//    NSDictionary *dic = @{@"attachment":@"file"};
      NSDictionary *dic = @{@"file":@"file"};
    [AXNetManager uploadJpegWithURL:url parameters:nil image:photos.firstObject success:^(id json) {
        NSLog(@"json %@",json);

    } failure:^(NSString *errorString) {
         NSLog(@"errorString %@",errorString);
    }];
    
    UIImage *image = photos.firstObject;
     NSData *imageData = UIImageJPEGRepresentation(image, 1);


    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //返回值解析类型
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];

    [manager POST:url parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  formData) {


               [formData appendPartWithFileData:imageData name:@"attachment" fileName:@"12111.jpg" mimeType:jpegMimeType];


       } progress:^(NSProgress * uploadProgress) {


       } success:^(NSURLSessionDataTask * task, id  responseObject) {

          NSLog(@"responseObject = %@",responseObject);


       } failure:^(NSURLSessionDataTask * task, NSError * error) {
           NSLog(@"error = %@",error);



       }];
    
}

-(void)images:(NSArray<PHAsset *> *) photos{
    
    NSMutableArray *array = [NSMutableArray array];
    
    
    for (PHAsset *asset in photos) {
        

      
        NSString *filename = [asset valueForKey:@"filename"];
        
        
        PHImageManager * imageManager = [PHImageManager defaultManager];
        
        
        [imageManager requestImageDataForAsset:asset options:nil resultHandler:^(NSData * _Nullable imageData, NSString * _Nullable dataUTI, UIImageOrientation orientation, NSDictionary * _Nullable info) {
            
            
//            NSURL *url = [info valueForKey:@"PHImageFileURLKey"];
//            NSString *str = [url absoluteString];   //url>string
//            NSArray *arr = [str componentsSeparatedByString:@"/"];
//            NSString *imgName = [arr lastObject];  // 图片名字
//            NSInteger length = imageData.length;   // 图片大小，单位B
//            UIImage * image = [UIImage imageWithData:imageData];
            
            
           
            
            AXFormData *form = [[AXFormData alloc]init];
            form.data = imageData;
            form.filename = filename;
            
            NSString *type = info[@"PHImageFileUTIKey"];
            
            if ([type isEqualToString:@"public.jpeg"]) {
                form.mimeType = jpegMimeType;
            }
            [array addObject:form];
            
        }];
        
    }
    NSString *url = @"http://localhost:8091/uploadsimplefile";
    
    NSDictionary *dic = @{@"attachment":@"file"};
    
    [AXNetManager POSTUpLoadWithURL:@"http://localhost:8091/uploadsimplefile" parameters:@{@"attachment":@"file"} formDataArray:array progress:^(NSProgress *aProgress) {
        
    } success:^(id json) {
        NSLog(@"json %@",json);
        
    } failure:^(NSString *errorString) {
         NSLog(@"errorString %@",errorString);
    }];
    [AXNetManager uploadJpegWithURL:url parameters:dic image:nil success:^(id json) {
        
    } failure:^(NSString *errorString) {
        
    }];
}

@end
