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
    
    [AXNetManager postDownURL:@"http://127.0.0.1:8091/downFile.do?id=123" showStatus:YES downPath:path progress:^(float aProgress) {
        
    } success:^(NSString *filePath) {
        NSLog(@"filePath = %@",filePath);
    } failure:^(NSInteger statusCode) {
        NSLog(@"statusCode = %ld",statusCode);
    }];
    
}

- (IBAction)upload:(id)sender {
    [self __TZImagePickerController:1];
    
    
}


- (IBAction)uploadMore:(id)sender {
    [self __TZImagePickerController:9];
}

-(void)__TZImagePickerController:(NSInteger )count{
    
    TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:count delegate:nil];
    imagePickerVc. allowPickingMultipleVideo = YES;
    
    imagePickerVc.allowPickingVideo = NO;
    
    imagePickerVc.allowPickingGif = YES;
    
    imagePickerVc.allowPickingImage = YES;
    imagePickerVc.showSelectedIndex = YES;
    
    
    [imagePickerVc setDidFinishPickingPhotosWithInfosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto, NSArray<NSDictionary *> *infos) {
        NSLog(@"assets %@",assets);
        NSLog(@"infos %@",infos);
        
        if (photos.count==1) {
            [self imagesOne:photos];
        }else{
            //             [self imagesMore:assets];
            [self imagesMore:photos];
        }
    }];
    [self presentViewController:imagePickerVc animated:YES completion:nil];
    
}


//// 上传单个张图片
-(void)imagesOne:(NSArray<UIImage *> *)photos{
    
    NSString *url = @"http://127.0.0.1:8091/uploadFileOne.do";
    [AXNetManager uploadJpegWithURL:url parameters:nil image:photos.firstObject name:@"file" success:^(id json) {
        NSLog(@"json %@",json);
        
    } failure:^(NSString *errorString) {
        NSLog(@"errorString %@",errorString);
    }];
    
    //    UIImage *image = photos.firstObject;
    //    NSData *imageData = UIImageJPEGRepresentation(image, 1);
    //
    //
    //    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //    //返回值解析类型
    //    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    //
    //    [manager POST:url parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  formData) {
    //
    //
    //        [formData appendPartWithFileData:imageData name:@"attachment" fileName:@"12111.jpg" mimeType:jpegMimeType];
    //
    //
    //    } progress:^(NSProgress * uploadProgress) {
    //
    //
    //    } success:^(NSURLSessionDataTask * task, id  responseObject) {
    //
    //        NSLog(@"responseObject = %@",responseObject);
    //
    //
    //    } failure:^(NSURLSessionDataTask * task, NSError * error) {
    //        NSLog(@"error = %@",error);
    //
    //
    //
    //    }];
    
}

-(void)imagesMore:(NSArray<UIImage *> *) photos{
    
    NSMutableArray *array = [NSMutableArray array];
    
    
    //    for (PHAsset *asset in photos) {
    //
    //        NSString *filename = [asset valueForKey:@"filename"];
    //        PHImageManager * imageManager = [PHImageManager defaultManager];
    //
    //
    //        [imageManager requestImageDataForAsset:asset options:nil resultHandler:^(NSData * _Nullable imageData, NSString * _Nullable dataUTI, UIImageOrientation orientation, NSDictionary * _Nullable info) {
    //
    //
    //            //            NSURL *url = [info valueForKey:@"PHImageFileURLKey"];
    //            //            NSString *str = [url absoluteString];   //url>string
    //            //            NSArray *arr = [str componentsSeparatedByString:@"/"];
    //            //            NSString *imgName = [arr lastObject];  // 图片名字
    //            //            NSInteger length = imageData.length;   // 图片大小，单位B
    //            //            UIImage * image = [UIImage imageWithData:imageData];
    //
    //
    //            AXFormData *form = [[AXFormData alloc]init];
    //            form.data = imageData;
    //            form.filename = filename;
    //            form.name = @"attachment";
    //
    //            NSString *type = info[@"PHImageFileUTIKey"];
    //
    //            if ([type isEqualToString:@"public.jpeg"]) {
    //                form.mimeType = jpegMimeType;
    //            }
    //            [array addObject:form];
    //
    //        }];
    //
    //    }
    
    for (NSInteger index = 0; index<photos.count; index++) {
        UIImage *image  = photos[index];
        
        
        AXFormData *form = [[AXFormData alloc]init];
        NSData *imageData = UIImageJPEGRepresentation(image, 1);

        form.data = imageData;
        form.filename = [NSString stringWithFormat:@"filename%ld.jpg",index];
        form.name = @"files";
        form .mimeType=jpegMimeType;
        [array addObject:form];
        
        
//            NSData *imageData = UIImageJPEGRepresentation(image, 1);
//            NSString *fileName =[NSString stringWithFormat:@"%@.jpeg",[NSString ax_uuid]];
//
//            AXFormData *formData = [AXFormData formDataWithData:imageData name:@"attachment" filename:fileName mimeType:jpegMimeType];
//          [array addObject:formData];
        
    }
    
    NSString *url = @"http://localhost:8091/uploadFileMore.do";
    
    
    [AXNetManager POSTUpLoadWithURL:url parameters:nil formDataArray:array progress:^(NSProgress *aProgress) {
        
    } success:^(id json) {
        NSLog(@"json %@",json);
        
    } failure:^(NSString *errorString) {
        NSLog(@"errorString %@",errorString);
    }];
    
}


@end
