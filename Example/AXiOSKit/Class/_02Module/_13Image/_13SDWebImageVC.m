//
//  _13WeImageTableViewController.m
//  AXiOSKit_Example
//
//  Created by 小星星吃KFC on 2020/11/14.
//  Copyright © 2020 axinger. All rights reserved.
//

#import "_13SDWebImageVC.h"

#import <SDWebImage/SDWebImage.h>

@interface MyCustomTableViewCell : UITableViewCell

@property (nonatomic, strong) UILabel *customTextLabel;
@property (nonatomic, strong) SDAnimatedImageView *customImageView;

@end

@implementation MyCustomTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        _customImageView = [[SDAnimatedImageView alloc] initWithFrame:CGRectMake(20.0,0, 120, 120)];
        [self.contentView addSubview:_customImageView];
        _customTextLabel = [[UILabel alloc] initWithFrame:CGRectMake(160.0, 12.0, 200, 20.0)];
        [self.contentView addSubview:_customTextLabel];
        
        _customImageView.clipsToBounds = YES;
        _customImageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return self;
}

@end



@interface DetailViewController : UIViewController

@property (strong, nonatomic) NSURL *imageURL;

@end

@interface DetailViewController ()

@property (strong, nonatomic)SDAnimatedImageView *imageView;

@end

@implementation DetailViewController

- (void)configureView {
    self.imageView=[SDAnimatedImageView.alloc init];
    [self.view addSubview:self.imageView];
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(100);
        make.centerX.mas_equalTo(0);
        make.width.mas_equalTo(100);
    }];
    if (!self.imageView.sd_imageIndicator) {
        self.imageView.sd_imageIndicator = SDWebImageProgressIndicator.defaultIndicator;
    }
    [self.imageView sd_setImageWithURL:self.imageURL
                      placeholderImage:nil
                               options:SDWebImageProgressiveLoad];
    self.imageView.shouldCustomLoopCount = YES;
    self.imageView.animationRepeatCount = 0;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configureView];
    self.view.backgroundColor = UIColor.whiteColor;
    
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem.alloc initWithTitle:@"是否关闭动画"
                                                                            style:UIBarButtonItemStylePlain
                                                                           target:self
                                                                           action:@selector(toggleAnimation:)];
}

- (void)toggleAnimation:(UIResponder *)sender {
    
    self.imageView.isAnimating ? [self.imageView stopAnimating] : [self.imageView startAnimating];
}

@end



@interface _13SDWebImageVC ()

@property (nonatomic, strong) NSMutableArray<NSString *> *objects;

@end

@implementation _13SDWebImageVC

/**
 
 UIImageView *imgView1 = [UIImageView.alloc init];
 imgView1.backgroundColor = UIColor.grayColor;
 [self.containerView addSubview:imgView1];
 [imgView1 mas_makeConstraints:^(MASConstraintMaker *make) {
     make.top.equalTo(self.bottomAttribute).mas_equalTo(20);
     make.width.height.mas_equalTo(60);
     make.centerX.mas_equalTo(0);
 }];
 
 [SDImageCache.sharedImageCache containsImageForKey:@"key_1234" cacheType:SDImageCacheTypeAll completion:^(SDImageCacheType containsCacheType) {
     NSLog(@"containsImageForKey %ld",containsCacheType);
     
     if (containsCacheType == SDImageCacheTypeNone) {
         NSLog(@"缓存一下");
         [SDImageCache.sharedImageCache storeImage:[UIImage imageNamed:@"no_data"] forKey:@"key_1234" completion:^{
             NSLog(@"缓存一下,成功");
             imgView1.image =  [SDImageCache.sharedImageCache imageFromMemoryCacheForKey:@"key_1234"];
         }];
     }else {
         NSLog(@"有缓存,直接取值");
         imgView1.image =  [SDImageCache.sharedImageCache imageFromMemoryCacheForKey:@"key_1234"];
     }
 }];
 
 */
-(void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"13SDWebImage";
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem.alloc initWithTitle:@"Clear Cache"
                                                                            style:UIBarButtonItemStylePlain
                                                                           target:self
                                                                           action:@selector(flushCache)];
    
    // HTTP NTLM auth example
    // Add your NTLM image url to the array below and replace the credentials
    [SDWebImageDownloader sharedDownloader].config.username = @"httpwatch";
    [SDWebImageDownloader sharedDownloader].config.password = @"httpwatch01";
    [[SDWebImageDownloader sharedDownloader] setValue:@"SDWebImage Demo" forHTTPHeaderField:@"AppName"];
    [SDWebImageDownloader sharedDownloader].config.executionOrder = SDWebImageDownloaderLIFOExecutionOrder;
    
    self.objects = [NSMutableArray arrayWithObjects:
                    @"http://www.httpwatch.com/httpgallery/authentication/authenticatedimage/default.aspx?0.35786508303135633",     // requires HTTP auth, used to demo the NTLM auth
                    @"http://assets.sbnation.com/assets/2512203/dogflops.gif",
                    @"https://raw.githubusercontent.com/liyong03/YLGIFImage/master/YLGIFImageDemo/YLGIFImageDemo/joy.gif",
                    @"http://apng.onevcat.com/assets/elephant.png",
                    @"http://www.ioncannon.net/wp-content/uploads/2011/06/test2.webp",
                    @"http://www.ioncannon.net/wp-content/uploads/2011/06/test9.webp",
                    @"http://littlesvr.ca/apng/images/SteamEngine.webp",
                    @"http://littlesvr.ca/apng/images/world-cup-2014-42.webp",
                    @"https://isparta.github.io/compare-webp/image/gif_webp/webp/2.webp",
                    @"https://nokiatech.github.io/heif/content/images/ski_jump_1440x960.heic",
                    @"https://nokiatech.github.io/heif/content/image_sequences/starfield_animation.heic",
                    @"https://s2.ax1x.com/2019/11/01/KHYIgJ.gif",
                    @"https://raw.githubusercontent.com/icons8/flat-color-icons/master/pdf/stack_of_photos.pdf",
                    @"https://nr-platform.s3.amazonaws.com/uploads/platform/published_extension/branding_icon/275/AmazonS3.png",
                    @"http://via.placeholder.com/200x200.jpg",
                    nil];
    
    for (int i=1; i<25; i++) {
        // From http://r0k.us/graphics/kodak/, 768x512 resolution, 24 bit depth PNG
        [self.objects addObject:[NSString stringWithFormat:@"http://r0k.us/graphics/kodak/kodak/kodim%02d.png", i]];
    }
    
    UIView *headView = [UIView.alloc initWithFrame:CGRectMake(0, 0, 0, 200)];
    headView.backgroundColor = UIColor.grayColor;
    
    UIImageView *headIconImv = [UIImageView.alloc initWithFrame:CGRectMake(50, 50, 80, 80)];
    headIconImv.backgroundColor = UIColor.orangeColor;
    
    /**
     
     SDImagePipelineTransformer       //它可以将多个变换器绑定在一起，让图像按顺序逐个变换并生成最终图像
     SDImageRoundCornerTransformer //圆角
     SDImageResizingTransformer //调整大小
     SDImageCroppingTransformer //裁剪
     SDImageFlippingTransformer //翻转
     SDImageRotationTransformer //旋转
     SDImageTintTransformer //Tint颜色
     SDImageBlurTransformer //毛玻璃效果
     SDImageFilterTransformer //滤镜
     
     
     */
    /// 圆角，这里的Radius和Size都是已像素为单位的，可以获取手机的Scale计算出具体大小
    SDImageRoundCornerTransformer *transformer1 = [SDImageRoundCornerTransformer transformerWithRadius:80
                                                                                               corners:UIRectCornerAllCorners
                                                                                           borderWidth:2
                                                                                           borderColor:UIColor.redColor];
    /// 大小
    //        SDImageResizingTransformer *transformer2 = [SDImageResizingTransformer transformerWithSize:CGSizeMake(200, 200) scaleMode:(SDImageScaleModeAspectFill)];
    //
    //        SDImagePipelineTransformer *transformer = [SDImagePipelineTransformer transformerWithTransformers:@[transformer1, transformer2]];
    
    // 翻转
    SDImageFlippingTransformer *flip = [SDImageFlippingTransformer transformerWithHorizontal:YES vertical:NO];
    
    /**
     typedef NSDictionary<SDWebImageContextOption, id> SDWebImageContext;
     typedef NSMutableDictionary<SDWebImageContextOption, id> SDWebImageMutableContext;
     context:(nullable SDWebImageContext *)context
     */
    
    SDImagePipelineTransformer *line = [SDImagePipelineTransformer transformerWithTransformers:@[transformer1,flip]];
    
    //    [headIconImv sd_setImageWithURL:ax_URLWithStr(@"http://via.placeholder.com/200x200.jpg")
    //                   placeholderImage:nil
    //                            options:SDWebImageRetryFailed
    //                            context:@{
    ////                                SDWebImageContextImageTransformer : transformer1,
    //                                SDWebImageContextImageTransformer : line,
    //                            }];
    
    [headView addSubview:headIconImv];
    self.tableView.tableHeaderView = headView;
    
    
    
    
}

- (void)flushCache {
    [SDWebImageManager.sharedManager.imageCache clearWithCacheType:SDImageCacheTypeAll completion:nil];
}

#pragma mark - Table View
-(CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 120;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.objects.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    
    static UIImage *placeholderImage = nil;
    if (!placeholderImage) {
        placeholderImage = [UIImage imageNamed:@"placeholder"];
    }
    
    MyCustomTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[MyCustomTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.customImageView.sd_imageTransition = SDWebImageTransition.fadeTransition;
        cell.customImageView.sd_imageIndicator = SDWebImageActivityIndicator.grayIndicator;
    }
    
    cell.customTextLabel.text = [NSString stringWithFormat:@"Image #%ld", (long)indexPath.row];
    __weak SDAnimatedImageView *imageView = cell.customImageView;
    [imageView sd_setImageWithURL:[NSURL URLWithString:self.objects[indexPath.row]]
                 placeholderImage:placeholderImage
                          options:indexPath.row == 0 ? SDWebImageRefreshCached : 0
                          context:@{SDWebImageContextImageThumbnailPixelSize : @(CGSizeMake(180, 120))}
                         progress:nil
                        completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        SDWebImageCombinedOperation *operation = [imageView sd_imageLoadOperationForKey:imageView.sd_latestOperationKey];
        SDWebImageDownloadToken *token = operation.loaderOperation;
        if (@available(iOS 10.0, *)) {
            NSURLSessionTaskMetrics *metrics = token.metrics;
            if (metrics) {
                printf("动画 Metrics: %s download in (%f) seconds\n", [imageURL.absoluteString cStringUsingEncoding:NSUTF8StringEncoding], metrics.taskInterval.duration);
            }
        }
    }];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *largeImageURLString = [self.objects[indexPath.row] stringByReplacingOccurrencesOfString:@"small" withString:@"source"];
    NSURL *largeImageURL = [NSURL URLWithString:largeImageURLString];
    DetailViewController *detailViewController = [[DetailViewController alloc] init];
    detailViewController.imageURL = largeImageURL;
    [self.navigationController pushViewController:detailViewController animated:YES];
}

@end


