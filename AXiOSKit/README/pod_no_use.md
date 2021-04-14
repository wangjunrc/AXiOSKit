# ********** 待用 **********

pod 'ReactiveObjC'
###  swift 版本的
pod 'ReactiveCocoa'


### 自定义本地通知样式,即使推送通知开关关闭,也可以使用,封装的 NSNotificationCenter
pod 'EBBannerView'

### UITableViewCell 缓存高度
pod 'UITableView+FDTemplateLayoutCell'

### 定时器
pod 'MSWeakTimer'

### 加密 解密
pod 'CocoaSecurity'

### UITableViewCell 左,右 侧滑 显示item
pod 'MGSwipeTableCell'

### 是一组庞大、功能丰富的 iOS 组件。
pod 'YYKit'
pod 'YYText'
pod 'YYImage'

### 主要用来将 JSON 数据模型化为 Model 对象
pod 'Mantle'

### SQLite
pod 'FMDB'

### Mantle,字典转模型 和 FMDB 的转换工具
pod 'MTLFMDBAdapter'

### 支持 iOS SQLite 数据库迁移
pod 'FMDBMigrationManager'

### 加载图片的模糊效果
pod 'PINRemoteImage'

### 是腾讯WeRead团队开源的一款检测 iOS 内存泄漏的框架,无需修改任何业务逻辑代码，而且只在 debug 下开启，完全不影响你的 release 包。
pod 'MLeaksFinder'

### 由Flipboard开源的iOS平台上播放GIF动画 facebook/FLAnimatedImage forked from Flipboard/FLAnimatedImage  替代品
pod 'FLAnimatedImage'
pod 'SDWebImage/GIF'
```
#import <FLAnimatedImage/FLAnimatedImageView.h>
#import <SDWebImage/FLAnimatedImageView+WebCache.h>
```
```
FLAnimatedImageView *gifView = [[FLAnimatedImageView alloc]init];
gifView.frame = CGRectMake(0, 100, 100, 280);

NSData *animatedImageDate = [NSData dataWithContentsOfFile:[NSBundle.mainBundle pathForResource:@"face_flash.gif" ofType:nil]];
FLAnimatedImage *animatedImage = [FLAnimatedImage animatedImageWithGIFData:animatedImageDate];
UIImage *placeholderImage = [[UIImage alloc]init];
placeholderImage.sd_FLAnimatedImage = animatedImage;

[gifView sd_setImageWithURL:[NSURL URLWithString:@"https://img.soogif.com/7lMNouzYDdKupikZNTDJLGHz74PdmEg2.gif"] placeholderImage:placeholderImage];
[self.view addSubview:gifView];
```


### 图片无限轮播器
pod 'SDCycleScrollView'

### 腾讯邮箱Team UI控件 和 TZScrollViewPopGesture 会产生返回拦截拦截功能冲突
pod 'QMUIKit'

### 让UIScrollView的滑动和系统侧滑手势并存，例如：在查看地图界面同时支持地图的滑动和侧滑返回。注：和FDFullscreenPopGesture库不冲突
pod 'TZScrollViewPopGesture'

### 相册多选
pod 'TZImagePickerController'
```

TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:9 delegate:nil];
imagePickerVc. allowPickingMultipleVideo = YES;

imagePickerVc.allowPickingVideo = NO;

imagePickerVc.allowPickingGif = YES;

imagePickerVc.allowPickingImage = YES;
imagePickerVc.showSelectedIndex = YES;


[imagePickerVc setDidFinishPickingPhotosWithInfosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto, NSArray<NSDictionary *> *infos) {

}];
[self presentViewController:imagePickerVc animated:YES completion:nil];

```

### UIWebView 加载进度条
pod 'NJKWebViewProgress'

### zip解压
pod 'SSZipArchive'

### 微信SQLit 存储
pod 'WCDB'

### 音频在线播放,含有缓存
pod 'FreeStreamer'

### 图片浏览器
pod 'GKPhotoBrowser'

```
MWPhotoBrowser 不维护了

IDMPhotoBrowser 很少维护

ZLPhotoBrowser 维护

```

## #coreData 封装
pod 'MagicalRecord'


### 气泡提示
pod 'JDFTooltips'

### 基于GPU的图片或视频的处理框架
pod 'GPUImage'

### 是一个基于GCD的轻量级服务器框架，用于内嵌到OSX或者iOS系统的应用中提供HTTP1.1的服务。
pod 'GCDWebServer'

### facebook出品的paper，动画效果
pod 'pop'

### 是一个开源的第三方框架，可以将用户的崩溃日志以邮件发给你或者以发给我们提供的服务器
pod 'KSCrash'

### 腾讯Buglg可以做到时时发送崩溃报告
pod 'Buglg'

### 存放用户账号密码组件
pod 'UICKeyChainStore'

### 监测网络状态
pod 'Reachability'

### 友好化时间
pod 'DateTools'

### 一款简单的 iOS 照片浏览控件
pod 'MWPhotoBrowser'

### 一个选择器组件, 支持从用户的相片库选择多张照片和视频
pod 'CTAssetsPickerController'

### 无需使用图片文件的 iOS 弹出式菜单
pod 'QBPopupMenu'

### 一个能够让你方便地将提醒用户评分的功能加入 App 的工具
pod 'UAAppReviewManager'

### 对 NSUserDefaults 进行了封装, 方便的进行本地化存储操作
pod 'GVUserDefaults'

### 对用户当前地理位置进行正向地址编码和反向地址编码
pod 'FCCurrentLocationGeocoder'

### 页面滚动时隐藏工具栏
pod 'AFSwipeToHide'

### 添加带动画效果的未读消息数提醒
pod 'JSBadgeView'

### 添加未读消息数显示提醒 和JSBadgeView 效果类似
pod 'RKNotificationHub'

### 可在应用中显示视图的尺寸
pod 'MMPlaceHolder'

### 创建弹出卡片视图
pod 'CNPPopupController'

## #加入沙漏等多种动画加载效果
pod 'FeSpinner'

### 方便创建用户引导视图 画圈圈,引导用户点击
pod 'JMHoledView'

### 快速给应用添加上滑动视图
pod 'SwipeView'

### 对视图进行模糊操作
pod 'FXBlurView'

### 中国省市地理位置选择器
pod 'AreaPicker'

### 富文字
pod 'DTCoreText'

### 导航栏,可以每个VC不一样配置
pod 'RTRootNavigationController'

### 五角星 显示
pod 'HCSStarRatingView'

### 分段
pod 'FSScrollContentViewLib'

### 时间选择器
```
PGDatePickManager *datePickManager = [[PGDatePickManager alloc]init];
PGDatePicker *datePicker = datePickManager.datePicker;
datePicker.datePickerMode = PGDatePickerModeDateHourMinuteSecond;
datePicker.delegate = self;
[self presentViewController:datePickManager animated:false completion:nil];
```
pod 'PGDatePicker'

## 提供了一个可在 iPhone 和 iPad 上使用的具有 UINavigationController 弹出效果的 STPopupController 类, 并能在 Storyboard 上很好的工。
pod 'STPopupController'


KxMenu


### 通过几条线段实现的非常Q萌的动画按钮效果。
### VBFPopFlatButton

### 电影院位置排座位
### ZSeatSelector

### 自动识别网址、号码、邮箱、@、## 话题## 和表情的label。 可以自定义自己的表情识别正则，和对应的表情图像。(默认是识别微信的表情符号)
## MLLabel

### AppleMusic式pop up，弹出是页面，可以上下拉动
### LNPopupController

### 连线进度
KYAnimatedPageControl

### 带粘性的扇形菜单
KYGooeyMenu

### Bootstrap 3.0扁平化风格按钮，自带图标，一句代码直接调用
### LLBootstrapButton

###  OS-Slide-Menu - 能够类似Facebook和Path那样弹出左右边栏侧滑菜单,还支持手势。多种可以自定义的属性 (非常不错)。

###  侧滑菜单
###  ECSlidingViewController

###  侧滑菜单,有左右菜单，有pop功能，支持手势侧滑
### JASidePanels

###  一个弹性侧滑菜单,弹性动画原理借鉴该项目中阻尼函数实现
pod ‘LLSlideMenu'

## *********以下是第三方服务*********
### U-Share SDK UI模块（分享面板，建议添加）
pod ‘UMengUShare/UI’

###  集成微信(精简版0.2M)
pod ‘UMengUShare/Social/ReducedWeChat'

###  集成微信(完整版14.4M)
pod ‘UMengUShare/Social/WeChat'

###  集成QQ/QZone/TIM(精简版0.5M)
pod ‘UMengUShare/Social/ReducedQQ'

### 集成QQ/QZone/TIM(完整版7.6M)
pod ‘UMengUShare/Social/QQ'

### 集成新浪微博(精简版1M)
pod ‘UMengUShare/Social/ReducedSina'

### 集成新浪微博(完整版25.3M)
pod ‘UMengUShare/Social/Sina'

### ********** facebook集合**********

### OS移动测试框架
pod ‘WebDriverAgent'

### 通知样式
pod ‘FBNotifications'


### xctool是facebook给出的自动化构建的解决方案，让构建和测试更容易，更好的支持持续集成。但xctool只是对xcodebuild的一个封装，因此xctool是基于xcodebuild的。停止更新
### xctool

### 跑马灯文字
pod ‘Shimmer'

### kvo
pod ‘KVOController'

### 内存使用 显示
pod ‘FBMemoryProfiler'

### 支付宝在用的
pod 'UIAlertView-Blocks'

<!--pod 'CustomIOSAlertView'-->

<!--pod 'RTLabel'-->

<!--pod 'SSKeychain'-->

#### 由于c语言中，没有直接的字典，字符串数组等数据结构，所以要借助结构体定义，处理json。
pod 'cJSON'

pod 'JSONModel'


### 在大小上比png小，图片质量上跟png差不多，就是WebP。

pod 'WebP'

<!--pod 'SDScreenshotCapture'-->

<!--pod 'STWebPDecoder'-->

<!--pod 'stun'-->

### c/c++中使用unqlite
pod 'unqlite'

### C语言读和写png图片格式
pod 'libpng'

### Swift  
pod 'Zip'

<!--pod 'css-layout'-->

###第三方正则表达式开源库
<!--pod 'RegexKitLite'-->

<!--pod 'VZADealloc2MainObject'-->

<!--pod 'Reachability'-->

<!--pod 'PLCrashReporter'-->

pod 'KSCrash'

### Duktape 是一个轻量级的嵌入式 JavaScript 引擎,专注于可移植性和低占用率。Duktape 可以被轻松地集成进一个 C/C++ 项目中:
pod 'Duktape'

### Libextobjc是一个非常强大的Objective-C库的扩展,为Objective-C提供诸如Safe categories、Concrete protocols、简单和安全的key paths以及简单使用block中的弱变量等功能。libextobjc非常模块化，只需要一个或者两个依赖就能使用大部分类和模块。

<!--pod 'libextobjc'-->

<!--pod 'GTMNSString-HTML'-->

SPDY（读作“SPeeDY”）是Google开发的基于TCP的应用层协议
<!--pod 'SPDY'-->

pod 'ProtocolBuffers'

<!--pod 'GTM/AliSecXCryptoGTMDefines.h'-->

### HTML解析库Gumbo
pod 'gumbo-parser'

### opencore框架进行语音解码amr文件转化wav播放 - 简书
pod 'OpencoreAmr'

### openssl是一个c语言函数库，
pod 'OpenSSL'

### LZ4最快压缩算法
pod 'lz4'

<!--pod 'Json11'-->

### Lua 是一个小巧的脚本语言
pod 'lua'

### FFmpeg及视频格式转码
pod 'FFmpeg'

### 分享协议
pod 'OpenShare'

### 分享UI
pod 'IFMShare'

### Facebook长链接 SRWebSocket
####目前Facebook的SocketRocket应该是目前最好的 关于WebSocket使用的框架了.而且简单易用. 
pod 'SocketRocket'

### CocoaAsyncSocket 
CocoaAsyncSocket

### CocoaLumberjack——简单好用的日志框架
CocoaLumberjack

### pod 'PromisesObjC'
pod 'PromisesObjC'

### 移动端网络调试工具
pod 'Bagel', '~>  1.3.2'

### FBRetainCycleDetector 用以检测循环引用，可以检测NSObject的循环引用
pod 'FBRetainCycleDetector'

### jrswizzle  子类安全交换父类方法, https://www.jianshu.com/p/4807e9745397
pod 'jrswizzle'

### TabBarController 动画
pod 'RAMAnimatedTabBarController'

### 定义的iOS控制，为您提供了一个可选择范围值的 UISlider 控件 
pod 'NMRangeSlider'

### fmdb 操作
pod 'LKDBHelper'
