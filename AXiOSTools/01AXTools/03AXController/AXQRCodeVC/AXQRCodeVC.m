//
//  AXQRCodeVC.m
//  AXiOSTools
//
//  Created by liuweixing on 16/6/12.
//  Copyright © 2016年 liuweixing All rights reserved.
//

#import "AXQRCodeVC.h"
#import <AVFoundation/AVFoundation.h>
#import "AXiOSTools.h"
typedef void(^QRCodeBlock)(NSString *code);

@interface AXQRCodeVC ()<AVCaptureMetadataOutputObjectsDelegate,UIGestureRecognizerDelegate>
@property (weak, nonatomic) IBOutlet UIView *seeView;

@property (nonatomic, strong)AVCaptureSession * session;//输入输出的中间桥梁
@property (nonatomic, assign) BOOL isOpenCamera;
@property (nonatomic, assign) BOOL isShowResult;
/**
 *
 */
//@property (nonatomic, copy) QRCodeBlock qRCodeBlock;

/**<#description#>*/
@property (nonatomic, strong)  AVCaptureDevice *device;

@property(nonatomic) CGFloat currentZoomFactor ;

@property(nonatomic) CGFloat maxZoomFactor;
@property(nonatomic) CGFloat minZoomFactor;

@end

@implementation AXQRCodeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = AXToolsLocalizedString(@"扫一扫");
    
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
        
        if (self.qrCodeBlock) {
            
            NSDictionary *userInfo = @{NSLocalizedDescriptionKey:@"该设备无相机功能"};
            NSError *error = [[NSError alloc] initWithDomain:NSCocoaErrorDomain code:4 userInfo:userInfo];
            self.qrCodeBlock(error, nil);
        }
        
    }else{
        
        self.isOpenCamera = YES;
        
        self.maxZoomFactor = 10;
        self.minZoomFactor = 0.1;
        
        [self.session startRunning];
        
        UIPinchGestureRecognizer *pinchGestureRecognizer = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(zoomChangePinchGestureRecognizerClick:)];
        pinchGestureRecognizer.delegate = self;
        [self.view addGestureRecognizer:pinchGestureRecognizer];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(activeCodeDidEnterBackground) name:UIApplicationDidEnterBackgroundNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(becomeActive) name:UIApplicationDidBecomeActiveNotification object:nil];
    }
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.isShowResult = NO;
}


- (void)activeCodeDidEnterBackground{
    if (self.isOpenCamera ) {
        [self.session stopRunning];
    }
}

- (void)becomeActive{
    if (self.isOpenCamera ) {
        //开始捕获
        [self.session startRunning];
    }
}

#pragma mark AVCaptureMetadataOutputObjectsDelegate
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection{
    
    if ([metadataObjects count] >0){
        
        if (_isShowResult) {
            return;
        }
        _isShowResult = YES;
        AVMetadataMachineReadableCodeObject * metadataObject = metadataObjects.firstObject;
        NSString *qrCode = metadataObject.stringValue;
        if (self.qrCodeBlock) {
            self.qrCodeBlock(nil, qrCode);
              [self.navigationController dismissViewControllerAnimated:YES completion:nil];
        }
    }
}


- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{
    
    if ([gestureRecognizer isKindOfClass:[UIPinchGestureRecognizer class]]){
        //        self.slider.minimumValue = self.minZoomFactor;
        //        self.slider.maximumValue = self.maxZoomFactor;
        self.currentZoomFactor = self.device.videoZoomFactor;
    }
    return YES;
}

//缩放手势
- (void)zoomChangePinchGestureRecognizerClick:(UIPinchGestureRecognizer *)pinchGestureRecognizer
{
    if (pinchGestureRecognizer.state == UIGestureRecognizerStateBegan ||
        pinchGestureRecognizer.state == UIGestureRecognizerStateChanged){
        
        CGFloat currentZoomFactor = self.currentZoomFactor * pinchGestureRecognizer.scale;
        
        if (currentZoomFactor < self.maxZoomFactor &&
            currentZoomFactor > self.minZoomFactor){
            
            NSError *error = nil;
            
            if ([self.device lockForConfiguration:&error] ) {
                
                self.device.videoZoomFactor = currentZoomFactor;
                [self.device unlockForConfiguration];
            }
            else {
                NSLog( @"Could not lock device for configuration: %@", error );
            }
        }
    }
    else
    {
        
    }
}

- (AVCaptureDevice *)device {
    if (nil == _device) {
        _device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    }
    return _device;
}

- (AVCaptureSession *)session{
    if (!_session) {
        
        //创建输入流
        AVCaptureDeviceInput * input = [AVCaptureDeviceInput deviceInputWithDevice:self.device error:nil];
        
        //创建输出流
        AVCaptureMetadataOutput * output = [[AVCaptureMetadataOutput alloc]init];
        //设置代理 在主线程里刷新
        [output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
        // CGRectMake（y的起点/屏幕的高，x的起点/屏幕的宽，扫描的区域的高/屏幕的高，扫描的区域的宽/屏幕的宽）
        
        //            output.rectOfInterest=CGRectMake(0.25, 0.25, 0.25,0.25);
        
        CGRect rect = UIScreen.mainScreen.bounds;
        CGFloat ScreenHigh = rect.size.height;
        CGFloat ScreenWidth = rect.size.width;
        CGFloat x = self.seeView.frame.origin.y/ScreenHigh;
        CGFloat y = self.seeView.frame.origin.x/ScreenWidth;
        CGFloat w = self.seeView.frame.size.width/ScreenHigh;
        CGFloat h = self.seeView.frame.size.height /ScreenWidth;
        output.rectOfInterest=CGRectMake(x, y,w,h);
        
        
        //    output.
        //初始化链接对象
        _session = [[AVCaptureSession alloc]init];
        //高质量采集率
        [_session setSessionPreset:AVCaptureSessionPresetHigh];
        
        //设置扫码支持的编码格式(如下设置条形码和二维码兼容)
        AVCaptureVideoPreviewLayer * previewLayer = [AVCaptureVideoPreviewLayer layerWithSession:self.session];
        previewLayer.videoGravity=AVLayerVideoGravityResizeAspectFill;
        previewLayer.backgroundColor = [UIColor orangeColor].CGColor;
        previewLayer.frame = rect;
        
        [self.view.layer insertSublayer:previewLayer atIndex:0];
        
        if ([_session canAddInput:input]){
            [_session addInput:input];
        }
        
        if ([_session canAddOutput:output]){
            [_session addOutput:output];
        }
        // 一定要写在 self.session addOutput:output] 后面
        output.metadataObjectTypes=@[AVMetadataObjectTypeQRCode,AVMetadataObjectTypeEAN13Code, AVMetadataObjectTypeEAN8Code, AVMetadataObjectTypeCode128Code];
    }
    return _session;
}

- (void)dealloc{
    axLong_dealloc ;
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationDidEnterBackgroundNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationDidBecomeActiveNotification object:nil];
}
@end
