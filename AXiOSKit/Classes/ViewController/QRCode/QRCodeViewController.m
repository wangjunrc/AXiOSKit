//
//  QRCodeViewController.m
//  QRCode
//
//  Created by 王聪 on 16/5/22.
//  Copyright © 2016年 王聪. All rights reserved.
//

#import "QRCodeViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "AXiOSKit.h"
@interface QRCodeViewController () <UITabBarDelegate,AVCaptureMetadataOutputObjectsDelegate,UIGestureRecognizerDelegate>

// 显示扫描后的结果
@property (strong, nonatomic) IBOutlet UILabel *resultLab;

// 高度约束
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *containerHeightCons;


@property (strong, nonatomic) IBOutlet UIView *seeView;


// 扫描线
@property (strong, nonatomic) IBOutlet UIImageView *scanLineView;

// 扫描线的约束，这里很重要，动画效果主要是根据设置这个的值实现的
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *scanLineCons;

// 自定义ToolBar
@property (strong, nonatomic) IBOutlet UITabBar *customTabBar;

// 会话
@property (nonatomic, strong) AVCaptureSession *session;

// 输入设备
@property (nonatomic, strong) AVCaptureDeviceInput *deviceInput;

// 输出设备
@property (nonatomic, strong) AVCaptureMetadataOutput *output;

// 预览图层
@property (nonatomic, strong) AVCaptureVideoPreviewLayer *previewLayer;

// 会话图层
@property (nonatomic, strong) CALayer *drawLayer;


// 扫描完成回调block
@property (copy, nonatomic) void (^completionBlock) (NSString *);

// 音频播放
@property (strong, nonatomic) AVAudioPlayer *beepPlayer;

/**
 * 设备是否能进行扫描
 */
@property (nonatomic, assign,getter=isCanRun) BOOL canRun;

@property (nonatomic, strong)  AVCaptureDevice *device;

@property(nonatomic) CGFloat currentZoomFactor ;
@property(nonatomic) CGFloat maxZoomFactor;
@property(nonatomic) CGFloat minZoomFactor;


/**
 当前扫码的type
 * 二维码 AVMetadataObjectTypeQRCode
 * 条形码 AVMetadataObjectTypeEAN13Code, AVMetadataObjectTypeEAN8Code
 */
@property (nonatomic, copy) NSMutableArray *currentTypeArray;

@end

@implementation QRCodeViewController

- (NSMutableArray *)currentTypeArray {
    if (nil == _currentTypeArray) {
        _currentTypeArray = [[NSMutableArray alloc]init];
    }
    return _currentTypeArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    self.customTabBar.delegate = self;
    [self setupSessionView];
    [self tabBar:self.customTabBar didSelectItem:self.customTabBar.items.firstObject];
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{
    
    if ([gestureRecognizer isKindOfClass:[UIPinchGestureRecognizer class]]){
        //        self.slider.minimumValue = self.minZoomFactor;
        //        self.slider.maximumValue = self.maxZoomFactor;
        self.currentZoomFactor = self.device.videoZoomFactor;
        NSLog(@"self.currentZoomFactor>> %lf",self.currentZoomFactor);
    }
    return YES;
}

//缩放手势
- (void)zoomChangePinchGestureRecognizerClick:(UIPinchGestureRecognizer *)pinchGestureRecognizer{
    
    if (pinchGestureRecognizer.state == UIGestureRecognizerStateBegan ||
        pinchGestureRecognizer.state == UIGestureRecognizerStateChanged){
        
        
        CGFloat currentZoomFactor = self.currentZoomFactor * pinchGestureRecognizer.scale;

        
        
        if (currentZoomFactor < self.maxZoomFactor &&
            currentZoomFactor > self.minZoomFactor){

            NSError *error = nil;

            if ([self.device lockForConfiguration:&error] ) {

                self.device.videoZoomFactor = currentZoomFactor;
                [self.device unlockForConfiguration];

                [self.previewLayer setAffineTransform:CGAffineTransformMakeScale(1 +currentZoomFactor , 1 + currentZoomFactor)];
            }
            else {
                NSLog( @"Could not lock device for configuration: %@", error );
            }
        }
//    }
//    else
//    {
//
    }
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self startAnimation];
        [self startScan];
    });
    
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

#pragma mark - Managing the Block

- (void)setCompletionWithBlock:(void (^) (NSString *resultAsString))completionBlock{
    self.completionBlock = completionBlock;
}


#pragma 扫描过程
- (void)startScan{
    if (self.isCanRun) {
        // 6.告诉session开始扫描
        self.view.backgroundColor = [UIColor clearColor];
        [self.session startRunning];
    }
}

/**
 * 初始化设备
 */
- (void)setupSessionView{
    // 1.判断是否能够将输入添加到会话中
    if (![self.session canAddInput:self.deviceInput]) {
        return;
    }
    
    // 2.判断是否能够将输出添加到会话中
    if (![self.session canAddOutput:self.output]) {
        return;
    }
    
    // 3.将输入和输出都添加到会话中
    [self.session addInput:self.deviceInput];
    
    [self.session addOutput:self.output];
    
    // 4.设置输出能够解析的数据类型
    // 注意: 设置能够解析的数据类型, 一定要在输出对象添加到会员之后设置, 否则会报错
//    self.output.metadataObjectTypes = self.output.availableMetadataObjectTypes;
    /**
     ios原生AVFoundation支持同时扫描二维码和条形码
     
     但是，如果设置扫描类型，同时为二维码和条形码（
     
     dataOutput.metadataObjectTypes = @[AVMetadataObjectTypeQRCode,AVMetadataObjectTypeEAN13Code,AVMetadataObjectTypeEAN8Code,AVMetadataObjectTypeCode128Code];
     ）
     
     会存在一个bug，就是
     
     扫描条形码的时候，效率非常低下
     */
    NSLog(@"");
    
    self.output.metadataObjectTypes = @[AVMetadataObjectTypeQRCode];
    
    
    [self.output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    
    // 如果想实现只扫描一张图片, 那么系统自带的二维码扫描是不支持的
    // 只能设置让二维码只有出现在某一块区域才去扫描
    //    self.output.rectOfInterest = CGRectMake(0.0, 0.0, 1, 1);
    
    // 设置二维码区域参开http://www.tuicool.com/articles/6jUjmur
    CGFloat ScreenHigh = [UIScreen mainScreen].bounds.size.height;
    CGFloat ScreenWidth = [UIScreen mainScreen].bounds.size.width;
    
    //        [self.output setRectOfInterest : CGRectMake (( 160 )/ ScreenHigh ,(( ScreenWidth - 300 )/ 2 )/ ScreenWidth , 300 / ScreenHigh , 300 / ScreenWidth)];
    //    self.output.rectOfInterest = self.seeView.frame;
    
    // CGRectMake（y的起点/屏幕的高，x的起点/屏幕的宽，扫描的区域的高/屏幕的高，扫描的区域的宽/屏幕的宽）
    CGFloat x = ((ScreenHigh-300-64)*0.5-80)/ScreenHigh;
    CGFloat y = (ScreenWidth-300)*0.5 /ScreenWidth;
    CGFloat w = 300/ScreenHigh;
    CGFloat h = 300 /ScreenWidth;
    
    
    self.output.rectOfInterest=CGRectMake(x, y,w,h);
    // 5.添加预览图层
    [self.view.layer insertSublayer:self.previewLayer atIndex:0];
    
    // 添加绘制图层
    [self.previewLayer addSublayer:self.drawLayer];
    
    self.canRun = YES;
    
    
    self.maxZoomFactor = 3;
    self.minZoomFactor = 1;
    UIPinchGestureRecognizer *pinchGestureRecognizer = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(zoomChangePinchGestureRecognizerClick:)];
    pinchGestureRecognizer.delegate = self;
    [self.view addGestureRecognizer:pinchGestureRecognizer];
}



- (void)stopScan{
    if ([self.session isRunning]) {
        [self.session stopRunning];
    }
    [self stopAnimation];
}


- (void)startAnimation{
    
    // 让约束从顶部开始
    self.scanLineView.layer.hidden = NO;
    self.scanLineCons.constant = 0;
    [self.view layoutIfNeeded];
    
    // 设置动画指定的次数
    
    [UIView animateWithDuration:2.0 animations:^{
        // 1.修改约束
        self.scanLineCons.constant = self.containerHeightCons.constant;
        [UIView setAnimationRepeatCount:MAXFLOAT];
        // 2.强制更新界面
        [self.view layoutIfNeeded];
    }];
}

// 停止动画
- (void)stopAnimation{
    [self.view.layer removeAllAnimations];
    self.scanLineView.layer.hidden = YES;
    [self.scanLineView.layer removeAllAnimations];
}

/**
 *  当从二维码中获取到信息时，就会调用下面的方法
 *
 *  @param captureOutput   输出对象
 *  @param metadataObjects 信息
 *  @param connection 结果
 */
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection{
    // 0.清空图层
    [self clearCorners];
    
    if (metadataObjects.count == 0 || metadataObjects == nil) {
        
        return;
    }
    
    // 1.获取扫描到的数据
    // 注意: 要使用stringValue
    AVMetadataObject *metadataObj = metadataObjects.lastObject;
    
    //判断回传的数据类型 是二维码 还是 条形码
    if ([self.currentTypeArray containsObject:metadataObj.type] && [metadataObj isKindOfClass:[AVMetadataMachineReadableCodeObject class]]) {
        
        // 扫描结果
        NSString *result = [metadataObjects.lastObject stringValue];
        
        // 停止扫描
        [self stopScan];
        [self.beepPlayer play];
        
        if (self.completionBlock) {
            self.completionBlock(result);
        }
        if (self.delegate && [self.delegate respondsToSelector:@selector(qrCodeViewController:didScanResult:)]) {
            [self.delegate qrCodeViewController:self didScanResult:result];
        }
        [self drawCorners:metadataObj];
        
    }
}




/**
 *  画出二维码的边框
 *
 *  @param metadataObj 保存了坐标的对象
 */
- (void)drawCorners:(AVMetadataObject *)metadataObj{
    
    AVMetadataMachineReadableCodeObject *codeObject = (AVMetadataMachineReadableCodeObject *)[self.previewLayer transformedMetadataObjectForMetadataObject:metadataObj];
    
    
    if (codeObject.corners.count == 0) {
        return;
    }
    
    // 1.创建一个图层
    CAShapeLayer *layer = [[CAShapeLayer alloc] init];
    layer.lineWidth = 2;
    layer.strokeColor = [UIColor redColor].CGColor;
    layer.fillColor = [UIColor clearColor].CGColor;
    
    // 2.创建路径
    UIBezierPath *path = [[UIBezierPath alloc] init];
    CGPoint point = CGPointZero;
    NSInteger index = 0;
    
    // 2.1移动到第一个点
    // 从corners数组中取出第0个元素, 将这个字典中的x/y赋值给point
    CGPointMakeWithDictionaryRepresentation((CFDictionaryRef)codeObject.corners[index++], &point);
    [path moveToPoint:point];
    
    // 2.2移动到其它的点
    while (index < codeObject.corners.count) {
        CGPointMakeWithDictionaryRepresentation((CFDictionaryRef)codeObject.corners[index++], &point);
        [path addLineToPoint:point];
    }
    // 2.3关闭路径
    [path closePath];
    
    // 2.4绘制路径
    layer.path = path.CGPath;
    
    // 3.将绘制好的图层添加到drawLayer上
    [self.drawLayer addSublayer:layer];
}

/**
 *  清除边线
 */
- (void)clearCorners{
    if (self.drawLayer.sublayers == nil || self.drawLayer.sublayers.count == 0) {
        return;
    }
    
    for (CALayer *subLayer in self.drawLayer.sublayers) {
        [subLayer removeFromSuperlayer];
    }
}


/**
 *  选择tabBar时进行跳转
 *
 *  @param tabBar tabbar
 *  @param item   tabBar的item
 */
- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item{
    
    [self.currentTypeArray removeAllObjects];
    
    if (item.tag == 1) {
        self.title = AXKitLocalizedString(@"二维码");
        self.resultLab.text = @"请将二维码放在上面框中";
        self.containerHeightCons.constant = 300;
        [self.currentTypeArray addObject:AVMetadataObjectTypeQRCode];
    } else {
        self.title = AXKitLocalizedString(@"条形码");
        self.resultLab.text = @"请将条形码放在上面框中";
        self.containerHeightCons.constant = 150;
        [self.currentTypeArray addObject:AVMetadataObjectTypeEAN13Code];
        [self.currentTypeArray addObject:AVMetadataObjectTypeEAN8Code];
    }
    
    [self clearCorners];
    self.canRun = YES;
    [self startScan];
    
    // 2.停止动画
    [self.view.layer removeAllAnimations];
    [self.scanLineView.layer removeAllAnimations];
    
    // 3.重新开始动画
    [self startAnimation];
}

#pragma mark - 懒加载
// 会话
- (AVCaptureSession *)session{
    if (_session == nil) {
        _session = [[AVCaptureSession alloc] init];
    }
    return _session;
}

- (AVCaptureDevice *)device {
    if (nil == _device) {
        _device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
        
        if ([_device isFocusModeSupported:AVCaptureFocusModeAutoFocus]) {
            if ([_device lockForConfiguration:nil]) {
                _device.focusMode = AVCaptureExposureModeContinuousAutoExposure;
            }
            
        }
    }
    return _device;
}
// 拿到输入设备
- (AVCaptureDeviceInput *)deviceInput{
    if (_deviceInput == nil) {
        _deviceInput = [[AVCaptureDeviceInput alloc] initWithDevice:self.device error:nil];
    }
    return _deviceInput;
}
// 拿到输出对象
- (AVCaptureMetadataOutput *)output{
    if (_output == nil) {
        _output = [[AVCaptureMetadataOutput alloc] init];
    }
    return _output;
}
// 创建预览图层
- (AVCaptureVideoPreviewLayer *)previewLayer{
    if (_previewLayer == nil) {
        _previewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:self.session];
        
//        想要实现调整焦距 需先设置AVCaptureVideoPreviewLayer的videoGravity为AVLayerVideoGravityResizeAspectFill.
        _previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
        _previewLayer.frame = [UIScreen mainScreen].bounds;
    }
    return _previewLayer;
}
// 创建用于绘制边线的图层
- (CALayer *)drawLayer{
    if (_drawLayer == nil) {
        _drawLayer = [[CALayer alloc] init];
        _drawLayer.frame = [UIScreen mainScreen].bounds;
    }
    return _drawLayer;
}

- (AVAudioPlayer *)beepPlayer
{
    if (_beepPlayer == nil) {
        NSString * wavPath = [[NSBundle mainBundle] pathForResource:@"beep" ofType:@"wav"];
        NSData* data = [[NSData alloc] initWithContentsOfFile:wavPath];
        _beepPlayer = [[AVAudioPlayer alloc] initWithData:data error:nil];
    }
    return _beepPlayer;
}


@end
