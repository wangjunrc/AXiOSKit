
## import 不同类型
```

#if __has_include(<YYWebImage/YYWebImage.h>)
#import <YYWebImage/YYWebImage.h>
#else
#import "YYWebImage.h"
#endif

```
## GitHub汇总
https://github.com/Tim9Liu9/TimLiu-iOS

## 消除 过期警告 top
```
/// 消除局部警告
#pragma clang diagnostic push
#pragma clang diagnostic ignored <#参数#>

/* 代码放这中间*/

#pragma clang diagnostic pop

```
```
/// 过期警告
 "-Wdeprecated-declarations"
```

```
/// 方法未实现警告
"-Wundeclared-selector"
```
```
// 将此行放在出现警告的. m 文件中。 消除所有警告
#pragma GCC diagnostic ignored <#参数#>
```

## 过期宏 三种方式都是 第一种的宏
```
__attribute__((deprecated(" ")));

DEPRECATED_MSG_ATTRIBUTE ()

DEPRECATED_ATTRIBUTE

UIKIT_EXTERN API_DEPRECATED("ax_is_过期", ios(2.0, 9.0))

```
##  禁用宏
```
NS_UNAVAILABLE
```
```
NS_UNAVAILABLE 当我们不想要其他开发人员，用普通的 init 方法去初始化一个类，我们可以在.h 文件里这样写：
- (instancetype)init NS_UNAVAILABLE;
假如禁用父类方法(包含属性),内部调用,super调用,
假如数属性 会有警告,重写dynamic方法
如: @dynamic delegate;
```

## 初始化方法 宏

```
NS_DESIGNATED_INITIALIZER

```
```
NS_DESIGNATED_INITIALIZER 指定的初始化方法。当一个类提供多种初始化方法时，所有的初始化方法最终都会调用这个指定的初始化方法。比较常见的有：
- (instancetype)initWithFrame:(CGRect)frame NS_DESIGNATED_INITIALIZER;

一个子类如果有自己的 designed initializer，则必须要实现父类的 designed initializer。比如一个继承自 NSObject 的 Person 类，就必须要重写 init 方法，并在 init 方法中，调用自己的 designed initializer，而不是调用 super 的初始化方法。如果未实现，可以看到编译警告：
Method override for the designed initializer of the superclass ‘- init’ not found.
所以，对于 Person 来说，如果 initWithName: 被标记了 NS_DESIGNED_INITIALIZER ，那么实现应该为：

- (instancetype)init {
// 在外部调用不需要 name 变量时，应该给出默认值
return [self initWithName:@"John doe"];
}

- (instancetype)initWithName:(NSString *)name {
self = [super init];
if (self) {
self.name = name;
}
return self;
}

```

#  NSSet / NSHashTable 、NSDictionary/ NSMapTable 的学习
```
NSSet 是过滤掉重复 object 的集合类，
NSHashTable 是 NSSet 的升级版容器，并且只有可变版本，允许对添加到容器中的对象是弱引用的持有关系， 当NSHashTable 中的对象销毁时，该对象也会从容器中移除。
NSMapTable 同 NSDictionary 类似，唯一区别是多了个功能：可以设置 key 和 value 的 NSPointerFunctionsOptions 特性! NSDictionary的 key 策略固定是 copy，考虑到开销问题，一般使用简单的数字或者字符串为 key。但是如果碰到需要用 object 作为 key 的应用场景呢？NSMapTable 就可以派上用场了！可以通过 NSFunctionsPointer 来分别定义对 key 和 value 的内存管理策略，简单可以分为 strong,weak以及 copy。

# 2 几个比较有用的宏

NS_ASSUME_NONNULL_BEGIN、
NS_ASSUME_NONNULL_END，
如果需要每个属性或每个方法都去指定 nonnull 和 nullable，是一件非常繁琐的事。苹果为了减轻我们的工作量，专门提供了这两个宏。在这两个宏之间的代码，所有比较简单指针对象都被假定为 nonnull，因此我们只需要去指定那些 nullable 的指针。如果我们强行通过点语法将一个非空指针置空，编译器会报 warning。
NS_UNAVAILABLE 当我们不想要其他开发人员，用普通的 init 方法去初始化一个类，我们可以在.h 文件里这样写：
- (instancetype)init NS_UNAVAILABLE;
编译器不但不会提示补全 init 方法，就算开发人员强制发送 init 消息，编译器会直接报错。
NS_DESIGNATED_INITIALIZER 指定的初始化方法。当一个类提供多种初始化方法时，所有的初始化方法最终都会调用这个指定的初始化方法。比较常见的有：
- (instancetype)initWithFrame:(CGRect)frame NS_DESIGNATED_INITIALIZER;

# 3 断言的使用
NSAssert(x,y);：x 为 BOOL 值，y 为 字符串类型。当 x = YES，则不产生断言。当 x = NO，则产生断言，app 会 crash，并在控制台中打印 y 字符串内容。合理利用断言，可以保证 app 的健壮性。
4 互斥锁的使用

```



# 代码触发点击事件
```
sendActionsForControlEvents
```
# NSMutableAttributedString 属性
```
NSMutableAttributedString 常见的属性：

NSFontAttributeName 字体

NSForegroundColorAttributeName 文字颜色

NSBackgroundColorAttributeName 背景颜色

NSStrikethroughStyleAttributeName 删除线（默认是0，无删除线）

NSUnderlineStyleAttributeName 下划线(默认是0，无下划线)

NSParagraphStyleAttributeName 设置段落／间距 vlue>> NSMutableParagraphStyle

```


# pod github资源 格式
```
pod 'AXiOSKit',  :git => 'https://github.com/liuweixingGitHub/AXiOSKit.git'
```



# 播放音频,不与其他app冲突
```
// 1.启动代理
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

[[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryAmbient withOptions:AVAudioSessionCategoryOptionMixWithOthers|AVAudioSessionCategoryOptionDefaultToSpeaker error:nil];

return YES;
}
// 2. 播放音频时

[[AVAudioSession sharedInstance] setActive:NO withOptions:AVAudioSessionSetActiveOptionNotifyOthersOnDeactivation error:nil];

NSString *filePath = [[NSBundle mainBundle] pathForResource:@"123" ofType:@"mp3"];
NSURL *fileUrl = [NSURL URLWithString:filePath];
self.musicPlayer = [[AVAudioPlayer alloc]initWithContentsOfURL:fileUrl error:nil];
self.musicPlayer.delegate = self;
[self.musicPlayer play];
```




# tableView 默认选中
```
[tableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
```



# wkwebView 加载本地 css 文件
```
1.建立一个bundle文件
2.把js,css,html文件拖入
3.直接加载相对路径
NSString *filePath= [[NSBundle ax_mainBundle] pathForResource:@"HTML.bundle/wk_index.html" ofType:nil];
NSURL *url = [NSURL fileURLWithPath:filePath];
NSURLRequest *request = [NSURLRequest requestWithURL:url];
[self.webView loadRequest:request];


//获取bundlePath 路径
NSString *bundlePath = [[NSBundle mainBundle] bundlePath];
//获取本地html目录 basePath
NSString *basePath = [NSString stringWithFormat: @"%@/www", bundlePath];
//获取本地html目录 baseUrl
//html 路径
NSString *indexPath = [NSString stringWithFormat: @"%@/%@.html", basePath,url];
NSURL *fileUrl = [NSURL fileURLWithPath:indexPath];
NSURL *baseUrl = [NSURL fileURLWithPath: basePath isDirectory: YES];
[self.webView loadFileURL:[NSURL fileURLWithPath:indexPath] allowingReadAccessToURL: baseUrl];
```



# scrollView 滚动方向,x 判断左右, y判断上下

```
CGPoint point =  [scrollView.panGestureRecognizer translationInView:self.view];

if (point.x < 0 ) {
// 往右滚动

}
}
}
```



# 同时多个alert 顺序弹出
```
//创建一个队列，串行并行都可以，主要为了操作信号量
dispatch_queue_t queue = dispatch_queue_create("com.ax.queue.alert", DISPATCH_QUEUE_SERIAL);
//创建一个初始为0的信号量
dispatch_semaphore_t sema = dispatch_semaphore_create(0);

// 异步,防止卡死,因为  dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
dispatch_async(queue, ^{
//等待信号触发，注意，这里是在我们创建的队列中等待
dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
//上面的等待到信号触发之后，再创建第二个Alert
dispatch_async(dispatch_get_main_queue(), ^{

UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"弹框2" message:@"第二个弹框" preferredStyle:UIAlertControllerStyleAlert];
[alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
dispatch_semaphore_signal(sema);
}]];
[self presentViewController:alert animated:YES completion:nil];
});
});

//同理，创建第三个Alert
dispatch_async(queue, ^{
dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
dispatch_async(dispatch_get_main_queue(), ^{

UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"弹框3" message:@"第三个弹框" preferredStyle:UIAlertControllerStyleAlert];
[alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
dispatch_semaphore_signal(sema);
}]];
[self presentViewController:alert animated:YES completion:nil];

});
});

// 第一个不用异步,优先执行,不管放在哪里
//第一个弹框，UI的创建和显示，要在主线程
dispatch_async(dispatch_get_main_queue(), ^{

UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"弹框1" message:@"第一个弹框" preferredStyle:UIAlertControllerStyleAlert];
[alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {

//点击Alert上的按钮，我们发送一次信号。
dispatch_semaphore_signal(sema);
}]];
[alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {

//点击Alert上的按钮，我们发送一次信号。
dispatch_semaphore_signal(sema);
}]];

[self presentViewController:alert animated:YES completion:nil];

});

```

# 类属性

```
@property (class,nonatomic, copy) NSString *nameAge;

static NSString *_nameAge1 = nil;

+(void)setNameAge:(NSString *)nameAge {

_nameAge1 = nameAge;
}

+ (NSString *)nameAge {

return _nameAge1;
}
```




# UIScrollView 滚动g内容高度 子视图适应
```
UIScrollView *scrollView = [[UIScrollView alloc] init];
scrollView.backgroundColor = [UIColor greenColor];
[self.view addSubview:scrollView];

[scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
make.top.mas_equalTo(80);
make.left.mas_equalTo(0);
make.right.mas_equalTo(0);
make.height.mas_equalTo(200);
}];


UIView *containerView = [[UIView alloc] init];
containerView.backgroundColor = [UIColor yellowColor];
[scrollView addSubview:containerView];

[containerView mas_makeConstraints:^(MASConstraintMaker *make) {
make.edges.mas_equalTo(UIEdgeInsetsZero);
make.width.equalTo(scrollView);//这个不能省略
}];


UIView *view0 = [[UIView alloc] init];
view0.backgroundColor = [UIColor redColor];
[containerView addSubview:view0];

[view0 mas_makeConstraints:^(MASConstraintMaker *make) {
make.edges.mas_equalTo(UIEdgeInsetsZero);
make.height.mas_equalTo(400);
}];
```

# 制作脚本
1.可以.sh结尾,执行 ./文件名
2.无后缀,直接双击
3.脚本运行
./ <文件名>

/*
#dirname $0,获取当前执行脚本文件的父路径
basepath=$(cd'dirname $0';pwd)

#echo 打印
echo "$basepath"
echo "父路径: $basepath"

#当前路径
currentPath=$(pwd)
echo "当前路径: $currentPath"
*/


# UIView 始终最上面 .layer.zPosition> 0就行,
```
UIView *view1 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 100, 260)];
view1.backgroundColor = [UIColor redColor];
[self.view addSubview:view1];
view1.layer.zPosition = 10;
```
# 键盘弹起
```
[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];


/**
*  键盘即将显示的时候调用
*/

- (void)keyboardWillShow:(NSNotification *)note{

// 1.取出键盘的frame
CGRect begin = [note.userInfo[UIKeyboardFrameBeginUserInfoKey] CGRectValue];

CGRect end = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];

// 2.取出键盘弹出的时间
CGFloat duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];

//3.输入框弹起后的Y
CGFloat y_board = 0;

//4.处理键盘（包括第三方键盘）
if(begin.size.height > 0 && (begin.origin.y - end.origin.y > 0)){
//处理逻辑

y_board = end.origin.y - self.view_comment.frame.size.height;

[UIView animateWithDuration:duration animations:^{

self.view.transform = CGAffineTransformMakeTranslation(0, -end.size.height);

}];
}
}

/**
*  键盘即将退出的时候调用
*/

- (void)keyboardWillHide:(NSNotification *)note
{
// 1.取出键盘弹出的时间
CGFloat duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
2.执行动画
[UIView animateWithDuration:duration animations:^{
self.view_comment.transform = CGAffineTransformIdentity;
}];
}
```
=======
// NSOperation 
# 使用子类 NSBlockOperation 子线程
```
- (void)opDemo6{

NSBlockOperation *op1 = [NSBlockOperation blockOperationWithBlock:^{

dispatch_semaphore_t sem = dispatch_semaphore_create(0);
self.didBlock = ^{
NSLog(@"正在下载全集 。。。 %@", [NSThread currentThread]);
dispatch_semaphore_signal(sem);
};
dispatch_semaphore_wait(sem, DISPATCH_TIME_FOREVER);
}];


op1.completionBlock = ^{
NSLog(@"op1 完成");
};


NSBlockOperation *op2 = [NSBlockOperation blockOperationWithBlock:^{
sleep(3);
NSLog(@"正在解压缩全集。。。 %@", [NSThread currentThread]);

}];
op2.completionBlock = ^{
NSLog(@"op2 完成");
};


NSBlockOperation *op3 = [NSBlockOperation blockOperationWithBlock:^{
sleep(3);
NSLog(@"正在保存到磁盘 。。。 %@", [NSThread currentThread]);
}];
op3.completionBlock = ^{
NSLog(@"op3 完成");
};

NSBlockOperation *op4 = [NSBlockOperation blockOperationWithBlock:^{
sleep(3);
NSLog(@"下载完成 。 %@", [NSThread currentThread]);
}];
op4.completionBlock = ^{
NSLog(@"op4 完成");
};


// 指定操作之间的”依赖“关系，某一个操作的执行，必须等待另一个操作完成才会开始
// 依赖关系是可以跨队列指定的
[op2 addDependency:op1];
[op3 addDependency:op2];
[op4 addDependency:op3];
// *** 添加依赖的时候，注意不要出现循环依赖
//    [op3 addDependency:op4];

[self.queue addOperation:op1];
[self.queue addOperation:op2];
[self.queue addOperation:op3];
// 主队列更新UI
[[NSOperationQueue mainQueue] addOperation:op4];

}

# NSOperationQueue 队列
/** 暂停操作 */
- (void)pause
{
// 1. 判断队列中是否有操作
if (self.queue.operationCount == 0) {
NSLog(@"没有操作");
return;
}

// 2. 如果没有被挂起(正在执行)，才需要暂停
// 只会挂起当前队列中还没有被调度（没有被安排到线程上工作的操作）才会被挂起
if (!self.queue.isSuspended) {
NSLog(@"暂停");
[self.queue setSuspended:YES];
} else {
NSLog(@"已经暂停");
}
}

/** 继续操作 */
- (void)resume
{
// 1. 判断队列中是否有操作
if (self.queue.operationCount == 0) {
NSLog(@"没有操作");
return;
}

// 2. 如果有被挂起的操作，才需要继续(恢复)
if (self.queue.isSuspended) {
NSLog(@"继续");
[self.queue setSuspended:NO];
} else {
NSLog(@"正在执行");
}
}
```

## copy | strong
```
集合类(NSMutable,NS) 属性用 copy
@property(nonatomic, copy) 
非集合 属性用 strong
@property( nonatomic,  strong)   
```
## 添加数据到粘贴板中
```
UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
pasteboard.string = @"AAA";
```
## NSString 断句
`只能识别中文符号,句子以。？结尾算句子`
```
NSString *str = @"AAA。bbbb？cc,dd?";
[str enumerateSubstringsInRange:NSMakeRange(0, str.length) options:NSStringEnumerationBySentences usingBlock:^(NSString * _Nullable substring, NSRange substringRange, NSRange enclosingRange, BOOL * _Nonnull stop) {
NSLog(@"substring>> %@",substring);
}];
```

## NSScanner 分词器
```
NSString *originStr = @"130-F130-130-*3";

NSScanner *scanner = [NSScanner scannerWithString:originStr];
NSCharacterSet *set = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];

NSMutableString *phone = [NSMutableString string];

while (!scanner.isAtEnd) {
NSString *bufferStr;
//要set中的
if ([scanner scanCharactersFromSet:set intoString:&bufferStr]) {
[phone appendString:bufferStr];
}else{
scanner.scanLocation = scanner.scanLocation+1;
}
}
```
# pod 操作
```
pod search 不到,删除以下文件
~/Library/Caches/CocoaPods/Pods/search_index

本地仓库路径
.cocoapods/repos/master

pod update --no-repo-update

pod repo update 
```

# 保护App,
```
一般常见的问题不会导致闪退，增强App的健壮性，同时会将错误抛出来，根据每个App自身的日志渠道记录，下次迭代或者热修复以下问题.

Unrecognized Selector Sent to Instance(方法不存在异常)

NSNull(方法不存在异常)

NSArray,NSMutableArray,NSDictonary,NSMutableDictionary(数组越界,key-value参数异常)

KVO(忘记移除keypath导致闪退)

Zombie Pointer(野指针)

NSTimer(忘记移除导致内存泄漏)

NSNotification(忘记移除导致异常)

NSString,NSMutableString,NSAttributedString,NSMutableAttributedString(下标越界以及参数nil异常)
```
```
pod 'JJException'
```
demo

```
设置异常类型并开启，建议放在didFinishLaunchingWithOptions第一行，以免在多线程出现异常的情况
//开启保护
- (void)startGuardAction{
JJException.exceptionWhenTerminate = NO;
[JJException configExceptionCategory:JJExceptionGuardAll];
[JJException startGuardException];
[JJException registerExceptionHandle:self];
}

//关闭保护
- (void)stopGuardAction{
[JJException stopGuardException];
}

```
# view旋转屏
```
- (instancetype)initWithFrame:(CGRect)frame
{
self = [super initWithFrame:frame];
if (self) {
//开启和监听 设备旋转的通知（不开启的话，设备方向一直是UIInterfaceOrientationUnknown）
if (![UIDevice currentDevice].generatesDeviceOrientationNotifications) {
[[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
}
[[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(handleDeviceOrientationChange:)
name:UIDeviceOrientationDidChangeNotification object:nil];

}
return self;
}

- (void)handleDeviceOrientationChange:(NSNotification *)notification{


//这个能取到APP启动时的屏幕方向,不是设备方向,比如,手机竖屏时,APP只支持横屏,这个办法能正确
//UIDeviceOrientation deviceOrientation = [UIDevice currentDevice].orientation;这个方法不行
UIInterfaceOrientation orientation = [[UIApplication sharedApplication] statusBarOrientation];

switch (orientation) {
case UIInterfaceOrientationPortrait:
//            NSLog(@"portrait");
[self verticalTwoViews];
break;
case UIInterfaceOrientationLandscapeLeft:
//            NSLog(@"landscape left");
[self horizontalTwoViews];
break;
case UIInterfaceOrientationLandscapeRight:
//            NSLog(@"landscape right");
[self horizontalTwoViews];
break;
case UIInterfaceOrientationPortraitUpsideDown:
//            NSLog(@"portrait upside down");
break;
case UIInterfaceOrientationUnknown:
break;
default:
break;
}

}

- (void)dealloc{

[[NSNotificationCenter defaultCenter]removeObserver:self];
[[UIDevice currentDevice]endGeneratingDeviceOrientationNotifications];
}
```

# NSError
```
//预定义的userinfo键名
NSString *const NSUnderlyingErrorKey;//推荐的标准方式，通用键
NSString *const NSLocalizedDescriptionKey;             // 详细描述键
NSString *const NSLocalizedFailureReasonErrorKey;      // 失败原因键
NSString *const NSLocalizedRecoverySuggestionErrorKey; //恢复建议键
NSString *const NSLocalizedRecoveryOptionsErrorKey;    // 恢复选项键

//其他键
NSString *const NSRecoveryAttempterErrorKey;
NSString *const NSHelpAnchorErrorKey;
NSString *const NSStringEncodingErrorKey ;
NSString *const NSURLErrorKey;
NSString *const NSFilePathErrorKey;
```
```
NSDictionary *userInfo1 = @{
NSLocalizedDescriptionKey:@"由于文件不存在，无法打开",
NSLocalizedFailureReasonErrorKey:@"失败原因：文件不存在",
NSLocalizedRecoverySuggestionErrorKey:@"恢复建议：请创建该文件"
};

NSError *error = [[NSError alloc] initWithDomain:NSCocoaErrorDomain code:4 userInfo:userInfo1];


NSLog(@"========%@",error);
NSLog(@"========%@",[error localizedDescription]);
NSLog(@"========%@",[error localizedFailureReason]);
NSLog(@"========%@",[error localizedRecoverySuggestion]);

```
# 拦截view点击事件
```
- (UIView*)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
UIView *hitView = [super hitTest:point withEvent:event];

if(hitView == self){
[self dismiss];
}
return hitView;
}
```
# 自定义window,用单例,系统就是单例



# 2个APP之间通信(如微信分享)
主动分享端(我方app)

```
NSDictionary *dict= @{@"name":@"jim",@"age":@(25)};

/**plist 序列化*/
NSData *plistData = [NSPropertyListSerialization dataWithPropertyList:dict
format:NSPropertyListBinaryFormat_v1_0
options:0
error:nil];

/**json 序列化*/
NSData *jsonData= [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:nil];

/**NSKeyedArchiver 序列化*/
NSData *archiverData= [NSKeyedArchiver archivedDataWithRootObject:dict];

/**同时赋值会覆盖*/
[[UIPasteboard generalPasteboard] setData:jsonData forPasteboardType:@"content_json"];
[[UIPasteboard generalPasteboard] setData:plistData forPasteboardType:@"content_plist"];

[UIApplication.sharedApplication openURL:ax_URLWithStr(@"axApp://")];

```

被拉起APP (如:微信)


```
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey, id> *)options {

return [self ax_openURL:url];
}

//打开url
- (BOOL)ax_openURL:(NSURL *)URL {
// 序列化方式 有 json 和plist 两种,微信用的plist方式
if ([URL.scheme isEqualToString:@"wx_key"]) {

//通过粘贴板机制通信
NSData *data = [[UIPasteboard generalPasteboard] dataForPasteboardType:@"content"];
//xml(plist) 解析data
id obj = [NSPropertyListSerialization propertyListWithData:data options:NSPropertyListImmutable format:nil error:nil];

if ([obj isKindOfClass:NSDictionary.class]) {

NSDictionary *dict = (NSDictionary *)obj;

//微信小程序传参
NSString *messageExt =  dict[URL.scheme][@"messageExt"];
//自己app的scheme
if ([messageExt hasPrefix:@"myURLScheme://"]) {

}
};
return YES;
}
return YES;
}
```

## 序列化方式
### 微信用的是粘贴板默认名称,
### 支付宝用的是url拼接参数,
### QQ登录用的是粘贴板自定义名称,com.tencent.tencent+id,QQ分享用的是url


```
// 要确定序列化方式,才能取出数据,微信用的是plist方式

NSData *plistData = [[UIPasteboard generalPasteboard] dataForPasteboardType:@"content_plist"];
//xml(plist) 解析data
if (plistData!=nil) {

id obj = [NSPropertyListSerialization propertyListWithData:plistData options:NSPropertyListImmutable format:nil error:nil];
NSLog(@"obj>> %@",obj);
}


NSData *jsonData = [[UIPasteboard generalPasteboard] dataForPasteboardType:@"content_json"];
// json 解析data
if (jsonData!=nil) {
id obj2 = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
NSLog(@"obj2>> %@",obj2);

}

```

# 隐私权限
```
<key>NSCalendarsUsageDescription</key>
<string>使用此功能需要访问您的日历</string>
<key>NSCameraUsageDescription</key>
<string>使用此功能需要访问您的相机</string>
<key>NSLocationAlwaysUsageDescription</key>
<string>我们需要使用你的位置向你推送更适合的内容</string>
<key>NSLocationWhenInUseUsageDescription</key>
<string>我们需要使用你的位置向你推送更适合的内容</string>
<key>NSMotionUsageDescription</key>
<string>需要你的同意获取运动传感器，用于计步信息的记录。</string>
<key>NSPhotoLibraryAddUsageDescription</key>
<string>使用此功能需要访问您的相册</string>
<key>NSPhotoLibraryUsageDescription</key>
<string>使用此功能需要访问您的相册</string>
<key>NSAppTransportSecurity</key>
<dict>
<key>NSAllowsArbitraryLoads</key>
<true/>
</dict>

<key>LSApplicationQueriesSchemes</key>
<array>
<string>weixin</string>
</array>

<key>NSAppTransportSecurity</key>
<dict>
<key>NSAllowsArbitraryLoads</key>
<true/>
<key>NSExceptionDomains</key>
<dict>
<key>sina.cn</key>
<dict>
<key>NSExceptionRequiresForwardSecrecy</key>
<false/>
<key>NSIncludesSubdomains</key>
<true/>
<key>NSTemporaryExceptionAllowsInsecureHTTPLoads</key>
<true/>
<key>NSTemporaryExceptionMinimumTLSVersion</key>
<string>TLSv1.0</string>
</dict>
</dict>
</dict>
```

# delegate 重写父类

```.h文件中

@protocol CurrentDelegate<SuperDelegate>

@end

```
```.m文件中
@dynamic delegate;
- (id<CurrentDelegate>)delegate{
id curDelegate = [super delegate];
return curDelegate;
}

- (void)setDelegate:(id<CurrentDelegate>)delegate{
[super setDelegate:delegate];
}
```

# 消息转发 NSInvocation

```

-(id)invokeWithSEL:(NSString *)selStr {

SEL sel = NSSelectorFromString(selStr);

id obj = self;;

if (![obj respondsToSelector:sel]) {
return nil;
}

//        NSMethodSignature *sig= [[self class] instanceMethodSignatureForSelector:sel];

NSMethodSignature* sig = [obj methodSignatureForSelector:sel];
NSInvocation* invocation = [NSInvocation invocationWithMethodSignature:sig];
[invocation setSelector:sel];
[invocation setTarget:obj];
[invocation invoke];

//获得返回值类型
const char* returnType = sig.methodReturnType;
//声明返回值变量
id returnValue;
//如果没有返回值，也就是消息声明为void，那么returnValue=nil
if (!strcmp(returnType, @encode(void))) {
returnValue = nil;

} else if (!strcmp(returnType, @encode(id))) {
//如果返回值为对象，那么为变量赋值
[invocation getReturnValue:&returnValue];
} else {
//如果返回值为普通类型NSInteger  BOOL
NSUInteger length = [sig methodReturnLength];
//根据长度申请内存
void* buffer = (void*)malloc(length);
//为变量赋值
[invocation getReturnValue:buffer];
if (!strcmp(returnType, @encode(BOOL))) {
returnValue = [NSNumber numberWithBool:*((BOOL*)buffer)];

}else if(!strcmp(returnType, @encode(NSInteger)) ){
returnValue = [NSNumber numberWithInteger:*((NSInteger*)buffer)];

}else if(!strcmp(returnType, @encode(double)) ){
returnValue = [NSNumber numberWithDouble:*((double*)buffer)];

}else if(!strcmp(returnType, @encode(float)) ){
returnValue = [NSNumber numberWithFloat:*((float*)buffer)];

}else if(!strcmp(returnType, @encode(int)) ){
returnValue = [NSNumber numberWithInt:*((int*)buffer)];

}else if(!strcmp(returnType, @encode(long)) ){
returnValue = [NSNumber numberWithLong:*((long*)buffer)];

}else{
returnValue = [NSValue valueWithBytes:buffer objCType:returnType];
}
}

return returnValue;

}
```

# 方法重载-同一个方法,不同参数

```C语言方法
NSString* __attribute__((overloadable)) mytest(NSString* x, NSString* y)
{
return [NSString stringWithFormat:@"%@%@",x,y];
}

int __attribute__((overloadable)) mytest(int x)
{
return x;
}

```
# 用一个C字符串来表示一个数据类型

```
char *buf1 = @encode(int);
char *buf2 = @encode(float);
char *buf3 = @encode(NSString *);
NSLog(@"%s",buf1);
NSLog(@"%s",buf2);
NSLog(@"%s",buf3);
```

# 富文本 显示图片
```

NSTextAttachment *textAttachment = [[NSTextAttachment alloc] init];
textAttachment.image = [UIImage imageNamed:@"icon_push_gift"];
textAttachment.bounds = CGRectMake(0,0,height,height);
NSAttributedString *imageString = [NSAttributedString attributedStringWithAttachment:textAttachment];

```

# 旋转动画
```
self.arrowBtn.transform = !self.arrowBtn.isSelected
? CGAffineTransformMakeRotation(M_PI)
: CGAffineTransformIdentity;
```


# popView
```
AAViewController *testVC = [[AAViewController alloc]init];

testVC.preferredContentSize = CGSizeMake(240, 62);
testVC.modalPresentationStyle = UIModalPresentationPopover;
testVC.popoverPresentationController.delegate = self;
testVC.popoverPresentationController.sourceView = sender;
testVC.popoverPresentationController.permittedArrowDirections = UIPopoverArrowDirectionDown;
testVC.popoverPresentationController.passthroughViews =@[self.view];
//    testVC.popoverPresentationController.backgroundColor = [UIColor redColor];

if (@available(iOS 9.0, *)) {
testVC.popoverPresentationController.canOverlapSourceViewRect = YES;
} else {

}

[self presentViewController:testVC animated:YES completion:nil];

```


# pod 不能加载xib
```
- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
if (self =[super initWithNibName:nibNameOrNil bundle:[NSBundle bundleForClass:self.class]]) {

}
return self;
}

```

# 拖动手势
```

UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(100, 100, 50, 50)];
btn.backgroundColor = [UIColor redColor];
[self.view addSubview:btn];
self.btn = btn;
UIPanGestureRecognizer *leftPan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handleLeftPan:)];
[btn addGestureRecognizer:leftPan];

```

```
- (void)handleLeftPan:(UIPanGestureRecognizer *)gesture {


if (gesture.state == UIGestureRecognizerStateBegan) {

} else if (gesture.state == UIGestureRecognizerStateChanged ) {

[self commitTranslation:[gesture translationInView:gesture.view]];
// 这句很重要
[gesture setTranslation:CGPointZero inView:gesture.view];
}
}

/** 判断手势方向  */
- (void)commitTranslation:(CGPoint)translation {

CGFloat absX = fabs(translation.x);
CGFloat absY = fabs(translation.y);
// 设置滑动有效距离
//    if (MAX(absX, absY) < 10){
//        return;
//}
if (absX > absY ) {
if (translation.x<0) {//向左滑动
NSLog(@"向左滑动");

CGPoint translatePoint = translation;

self.btn.x += translatePoint.x;
self.btn.y += translatePoint.y;


}else{//向右滑动
NSLog(@"向右滑动");

CGPoint translatePoint = translation;

self.btn.x += translatePoint.x;
self.btn.y += translatePoint.y;
}
} else if (absY > absX) {
if (translation.y<0) {//向上滑动
NSLog(@"向上滑动");
}else{ //向下滑动
NSLog(@"向下滑动");
}
}
}

```

# CABasicAnimation
```

CABasicAnimation *baseicAnimation = [CABasicAnimation animationWithKeyPath:@"position.x"];
baseicAnimation.delegate = self;

baseicAnimation.fromValue = @(0);
baseicAnimation.toValue = @(toValue);
baseicAnimation.duration = time;
baseicAnimation.removedOnCompletion = NO;
baseicAnimation.fillMode = kCAFillModeForwards;
baseicAnimation.beginTime = CACurrentMediaTime();

[self.progressLine.layer addAnimation:baseicAnimation forKey:@"videoProcessing_progressLine_move_x"];


/**
*  暂停
*
*  @param layer 被停止的layer
*/
- (void)pauseLayer:(CALayer*)layer{

CFTimeInterval pausedTime = [layer convertTime:CACurrentMediaTime() fromLayer:nil];

CFTimeInterval time = self.width * self.timeScale;
CFTimeInterval palyTime = pausedTime - self.beginMediaTime;
CGFloat toValue = self.previewView.width;
self.processOffset = palyTime/time * toValue;



layer.speed = 0.0;
layer.timeOffset = pausedTime;



}

/**
*  恢复
*
*  @param layer 被恢复的layer
*/
- (void)resumeLayer:(CALayer*)layer{
CFTimeInterval pausedTime = [layer timeOffset];
layer.speed = 1.0;
layer.timeOffset = 0.0;
layer.beginTime = 0.0;
CFTimeInterval timeSincePause = [layer convertTime:CACurrentMediaTime() fromLayer:nil] - pausedTime;
layer.beginTime = timeSincePause;
}

```

# addChildViewController
```
[self addChildViewController:aVC];

//addChildViewController 会调用 [child willMoveToParentViewController:self] 方法，但是不会调用 didMoveToParentViewController:方法，官方建议显示调用

[aVC didMoveToParentViewController:self];

```

# 2个 Label 自适应约束
```
[textLabel setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
[detailTextLabel setContentCompressionResistancePriority:UILayoutPriorityDefaultHigh forAxis:UILayoutConstraintAxisHorizontal];

```

# cell 首尾圆角
```方式一
- (void)drawRect:(CGRect)rect {
[super drawRect:rect];

UIRectCorner corners = self.corners;
UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.containerView.bounds byRoundingCorners:corners cornerRadii:CGSizeMake(4, 4)];
CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
maskLayer.frame = self.containerView.bounds;
maskLayer.path = maskPath.CGPath;
self.containerView.layer.mask = maskLayer;
}

```
```方式二
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
// 圆角弧度半径
CGFloat cornerRadius = 6.f;
// 设置cell的背景色为透明，如果不设置这个的话，则原来的背景色不会被覆盖
cell.backgroundColor = UIColor.clearColor;

// 创建一个shapeLayer
CAShapeLayer *layer = [[CAShapeLayer alloc] init];
CAShapeLayer *backgroundLayer = [[CAShapeLayer alloc] init]; //显示选中
// 创建一个可变的图像Path句柄，该路径用于保存绘图信息
CGMutablePathRef pathRef = CGPathCreateMutable();
// 获取cell的size
// 第一个参数,是整个 cell 的 bounds, 第二个参数是距左右两端的距离,第三个参数是距上下两端的距离
CGRect bounds = CGRectInset(cell.bounds, 10, 0);

// CGRectGetMinY：返回对象顶点坐标
// CGRectGetMaxY：返回对象底点坐标
// CGRectGetMinX：返回对象左边缘坐标
// CGRectGetMaxX：返回对象右边缘坐标
// CGRectGetMidX: 返回对象中心点的X坐标
// CGRectGetMidY: 返回对象中心点的Y坐标

// 这里要判断分组列表中的第一行，每组section的第一行，每组section的中间行

// CGPathAddRoundedRect(pathRef, nil, bounds, cornerRadius, cornerRadius);
if (indexPath.row == 0) {
// 初始起点为cell的左下角坐标
CGPathMoveToPoint(pathRef, nil, CGRectGetMinX(bounds), CGRectGetMaxY(bounds));
// 起始坐标为左下角，设为p，（CGRectGetMinX(bounds), CGRectGetMinY(bounds)）为左上角的点，设为p1(x1,y1)，(CGRectGetMidX(bounds), CGRectGetMinY(bounds))为顶部中点的点，设为p2(x2,y2)。然后连接p1和p2为一条直线l1，连接初始点p到p1成一条直线l，则在两条直线相交处绘制弧度为r的圆角。
CGPathAddArcToPoint(pathRef, nil, CGRectGetMinX(bounds), CGRectGetMinY(bounds), CGRectGetMidX(bounds), CGRectGetMinY(bounds), cornerRadius);
CGPathAddArcToPoint(pathRef, nil, CGRectGetMaxX(bounds), CGRectGetMinY(bounds), CGRectGetMaxX(bounds), CGRectGetMidY(bounds), cornerRadius);
// 终点坐标为右下角坐标点，把绘图信息都放到路径中去,根据这些路径就构成了一块区域了
CGPathAddLineToPoint(pathRef, nil, CGRectGetMaxX(bounds), CGRectGetMaxY(bounds));

} else if (indexPath.row == [tableView numberOfRowsInSection:indexPath.section]-1) {
// 初始起点为cell的左上角坐标
CGPathMoveToPoint(pathRef, nil, CGRectGetMinX(bounds), CGRectGetMinY(bounds));
CGPathAddArcToPoint(pathRef, nil, CGRectGetMinX(bounds), CGRectGetMaxY(bounds), CGRectGetMidX(bounds), CGRectGetMaxY(bounds), cornerRadius);
CGPathAddArcToPoint(pathRef, nil, CGRectGetMaxX(bounds), CGRectGetMaxY(bounds), CGRectGetMaxX(bounds), CGRectGetMidY(bounds), cornerRadius);
// 添加一条直线，终点坐标为右下角坐标点并放到路径中去
CGPathAddLineToPoint(pathRef, nil, CGRectGetMaxX(bounds), CGRectGetMinY(bounds));
} else {
// 添加cell的rectangle信息到path中（不包括圆角）
CGPathAddRect(pathRef, nil, bounds);
}
// 把已经绘制好的可变图像路径赋值给图层，然后图层根据这图像path进行图像渲染render
layer.path = pathRef;
backgroundLayer.path = pathRef;
// 注意：但凡通过Quartz2D中带有creat/copy/retain方法创建出来的值都必须要释放
CFRelease(pathRef);
// 按照shape layer的path填充颜色，类似于渲染render
// layer.fillColor = [UIColor colorWithWhite:1.f alpha:0.8f].CGColor;
layer.fillColor = [UIColor whiteColor].CGColor;

// view大小与cell一致
UIView *roundView = [[UIView alloc] initWithFrame:bounds];
// 添加自定义圆角后的图层到roundView中
[roundView.layer insertSublayer:layer atIndex:0];
roundView.backgroundColor = UIColor.clearColor;
// cell的背景view
cell.backgroundView = roundView;

// 以上方法存在缺陷当点击cell时还是出现cell方形效果，因此还需要添加以下方法
// 如果你 cell 已经取消选中状态的话,那以下方法是不需要的.
UIView *selectedBackgroundView = [[UIView alloc] initWithFrame:bounds];
backgroundLayer.fillColor = [UIColor cyanColor].CGColor;
[selectedBackgroundView.layer insertSublayer:backgroundLayer atIndex:0];
selectedBackgroundView.backgroundColor = UIColor.clearColor;
cell.selectedBackgroundView = selectedBackgroundView;

}

```


# 空格 Unicode 
```
\u00A0 1个字节空格
\u3000 2个字节空格

```
```
self.label.text = [NSString stringWithFormat:@"\u00A0\u00A0中\u00A0\u00A0"];
self.label.text = [NSString stringWithFormat:@"\u3000文\u3000"];

```

# extern
```
如果项目中涉及到使用C++语言的编程的话则最好使用
FOUNDATION_EXPORT
FOUNDATION_IMPORT
否则 使用
FOUNDATION_EXTERN 这个就可以了
当然使用extern 也是没有问题的
```
# tableView分割线
```
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
[cell setSeparatorInset:UIEdgeInsetsZero];
}

if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
[cell setLayoutMargins:UIEdgeInsetsZero];
}
}
-(void)viewDidLayoutSubviews
{
[super viewDidLayoutSubviews];
if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
[self.tableView setSeparatorInset:UIEdgeInsetsZero];
}

if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)]) {
[self.tableView setLayoutMargins:UIEdgeInsetsZero];
}
}
```

# try-catch-finally
```
- (IBAction)btnAction1:(id)sender {
@try {
// 可能会出现崩溃的代码
[self test];
} @catch (NSException* exception) {
// 捕获到的异常exception
NSLog(@"exception>> %@", exception);
} @finally {
// 结果处理
NSLog(@"结果处理");
}
}
```
# throw
```
- (void)test {
@throw [NSException exceptionWithName:@"error"
reason:@"预览对象不能为空"
userInfo:nil];
}
```


# UISlider 拖动事件
```
[self.progressSlider addTarget:self action:@selector(sliderProgressChange) forControlEvents:UIControlEventValueChanged];
[self.progressSlider addTarget:self action:@selector(sliderProgressChangeBegin) forControlEvents:UIControlEventTouchDown];

[self.progressSlider addTarget:self action:@selector(sliderProgressChangeEnd) forControlEvents:UIControlEventTouchUpOutside | UIControlEventTouchUpInside];
```
# 定义通知
```
UIKIT_EXTERN NSNotificationName const UIMenuControllerWillShowMenuNotification
```

# iOS的异步处理神器——Promises
```
#import "FBLPromises.h"
```
```
- (void)testAllAndAny {
NSMutableArray *arr = [NSMutableArray new];
[arr addObject:[self work1]];
[arr addObject:[self work2]];

//All是所有Promise都成功 fulfill才算完成；
[[[FBLPromise all:arr] then:^id _Nullable(NSArray * _Nullable value) {
NSLog(@"then, value:%@", value);
return value;
}] catch:^(NSError * _Nonnull error) {
NSLog(@"all error:%@", error);
}];

//Any是任何一个Promise成功 完成都会执行fulfill；
//    [[[FBLPromise any:arr] then:^id _Nullable(NSArray * _Nullable value) {
//        NSLog(@"then, value:%@", value);
//        return value;
//    }] catch:^(NSError * _Nonnull error) {
//        NSLog(@"any error:%@", error);
//    }];
}

- (FBLPromise<NSString *> *)work1 {
//    return [FBLPromise do:^id _Nullable{
//        BOOL success = arc4random() % 2;
//        return success ? @"work1>> work1 success" : [NSError errorWithDomain:@"work1_error" code:-1 userInfo:nil];
//    }];
//
return  [FBLPromise onQueue:dispatch_get_main_queue()
async:^(FBLPromiseFulfillBlock fulfill,
FBLPromiseRejectBlock reject) {

dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
BOOL success = arc4random() % 2;
if (success) {
fulfill(@"work1>>> success");
}
else {
reject([NSError errorWithDomain:@"work1_error" code:-1 userInfo:nil]);
}
});

}];
}

- (FBLPromise<NSString *> *)work2 {

//  return  [FBLPromise async:^(FBLPromiseFulfillBlock  _Nonnull fulfill, FBLPromiseRejectBlock  _Nonnull reject) {
//
//      dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//          BOOL success = arc4random() % 2;
//
//          if (success) {
//              fulfill(@"work2>>> success");
//          }
//          else {
//              reject([NSError errorWithDomain:@"work2_error" code:-1 userInfo:nil]);
//          }
//      });
//
//    }];
return  [FBLPromise onQueue:dispatch_get_main_queue()
async:^(FBLPromiseFulfillBlock fulfill,
FBLPromiseRejectBlock reject) {

dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
BOOL success = arc4random() % 2;
if (success) {
fulfill(@"work2>>> success");
}
else {
reject([NSError errorWithDomain:@"work2_error" code:-1 userInfo:nil]);
}
});

}];
}
```
# 字典中存放block
```
@{
@"title":@"暗黑主题-ViewController",
@"action":  ^{
ViewController *vc = [[ViewController alloc]init];
[self.navigationController pushViewController:vc animated:YES];
},
},
```

# InjectionIII
```
#if DEBUG
//    for iOS
[[NSBundle bundleWithPath:@"/Applications/InjectionIII.app/Contents/Resources/iOSInjection.bundle"] load];
//    for tvOS
[[NSBundle bundleWithPath:@"/Applications/InjectionIII.app/Contents/Resources/tvOSInjection.bundle"] load];
//    for masOS
[[NSBundle bundleWithPath:@"/Applications/InjectionIII.app/Contents/Resources/macOSInjection.bundle"] load];
#endif
```

### 在注入界面.m文件中实现- (void)injected方法然后所有的需要调试的界面，都写在injected方法里面
```
- (void)injected{
NSLog(@"I've been injected: %@", self);
[self viewDidLoad];
}

```

# 隐藏导航栏
```
@interface AAViewController () <UINavigationControllerDelegate,UIGestureRecognizerDelegate>

@end

- (void)viewDidLoad {
[super viewDidLoad];

self.view.backgroundColor = UIColor.redColor;

// 设置导航控制器的代理为self
self.navigationController.delegate = self;
// 必须设置,不然返回手势失效
self.navigationController.interactivePopGestureRecognizer.delegate = self;
}
#pragma mark - UINavigationControllerDelegate
//将要显示控制器
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
// 判断要显示的控制器是否是自己
BOOL isShowHomePage = [viewController isKindOfClass:[self class]];
[self.navigationController setNavigationBarHidden:isShowHomePage animated:YES];
}



- (void)dealloc {
self.navigationController.delegate = nil;
NSLog(@"dealloc>>>>");
}
```

# view 被移除
```
- (void)removeFromSuperview {
[super removeFromSuperview];

}
```

# nonatomic 和 natomic 区别
```
Property多线程安全小结：

简而言之，atomic的作用只是给getter和setter加了个锁，atomic只能保证代码进入getter或者setter函数内部时是安全的，一旦出了getter和setter，多线程安全只能靠程序员自己保障了。所以atomic属性和使用property的多线程安全并没什么直接的联系。另外，atomic由于加锁也会带来一些性能损耗，所以我们在编写iOS代码的时候，一般声明property为nonatomic，在需要做多线程安全的场景，自己去额外加锁做同步。
```
```
/// 加锁
- (void)testSynchronized {

@synchronized (self) {

self.count++;

}
}
```
# view 被添加到父视图
```
- (void)didMoveToSuperview{
[super didMoveToSuperview];

[self mas_makeConstraints:^(MASConstraintMaker *make) {
make.width.height.mas_equalTo(100);
make.top.equalTo(self.superview).mas_equalTo(300);
make.left.equalTo(self.superview).mas_equalTo(300);
}];

}
```
# labe自适应宽度,并居中
```
[self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {

make.bottom.equalTo(self.textField.mas_top).mas_equalTo(-10);
make.centerX.mas_offset(0);
make.left.mas_greaterThanOrEqualTo(5);
make.right.mas_lessThanOrEqualTo(-5);
}];
```

# copyWithZone
```
Person *person = [[Person alloc]init];

Person *person2 = person.copy;

```
浅copy,地址一致
```
- (id)copyWithZone:(nullable NSZone *)zone {
return self;;

}
```
深copy,地址不一致
```
- (id)copyWithZone:(nullable NSZone *)zone {

    Person *p = [[Person alloc]init];
    p.name = self.name.copy;
    return p;
    
}
```

# dispatch_barrier_async 栅格
```
dispatch_queue_t concurrentQueue = dispatch_queue_create("my.concurrent.queue", DISPATCH_QUEUE_CONCURRENT);
dispatch_async(concurrentQueue, ^(){
    NSLog(@"dispatch-1");
});
dispatch_async(concurrentQueue, ^(){
    NSLog(@"dispatch-2");
});

dispatch_async(concurrentQueue, ^(){
    NSLog(@"dispatch-3");
});
/// 异步
dispatch_barrier_async(concurrentQueue, ^(){
    NSLog(@"dispatch-barrier");
});
/// 同步
dispatch_barrier_sync
dispatch_async(concurrentQueue, ^(){
    NSLog(@"dispatch-4");
});
```
## 取余
```
//可以小数取余
NSLog(@"余数是%lf\n",fmod(10.1, 3));
/// 只能整数取余
NSLog(@"余数是%d",10%3);
```
##  UISearchBar 中按钮主题,比如 取消按钮颜色
```
[[UIBarButtonItem appearanceWhenContainedInInstancesOfClasses:@[UISearchBar.class]]
 setTitleTextAttributes:@{NSForegroundColorAttributeName:UIColor.redColor}
 forState:UIControlStateNormal];
 
 
 [UISearchBar.appearance setBarTintColor:UIColor.redColor];
 ```
## 正则表达式 NSRegularExpression 子类 NSDataDetector
```
NSDataDetector *detector = [NSDataDetector dataDetectorWithTypes:NSTextCheckingTypeAddress | NSTextCheckingTypePhoneNumber | NSTextCheckingTypeLink
                                                           error:nil];
//需要检测的字符串
NSString *testStr = @"有一个网址：wwww.JohnnyLiu.com有 一个电话：1299999 还有一个地址：安徽省来安县龙山街道 你看看这个www.baidu.com/sabc/bnss怎 么样?";
[detector enumerateMatchesInString:testStr options:NSMatchingReportCompletion range:NSMakeRange(0, testStr.length) usingBlock:^(NSTextCheckingResult * _Nullable result, NSMatchingFlags flags, BOOL * _Nonnull stop) {
    NSLog(@"result.range = %@",NSStringFromRange(result.range));
    if (result.URL) {
        NSLog(@"url = %@",result.URL);
    }
    if (result.phoneNumber) {
        NSLog(@"phone = %@",result.phoneNumber);
    }
    if ([result resultType] == NSTextCheckingTypeAddress) {

        NSDictionary<NSString *, NSString *> * addressComponent = [result addressComponents];
        NSLog(@"城市:%@, 街道:%@", addressComponent[NSTextCheckingCityKey], addressComponent[NSTextCheckingStreetKey]);
    }
}];
```
## 正则表达式 NSRegularExpression
```
{
    /// <正则表达式>
    NSString *regEx = @"12";
    ///<待匹配的字符串>
    NSString *string = @"1234567";

    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regEx];
    BOOL matched = [predicate evaluateWithObject:string];
    NSLog(@"是否匹配 = %d", matched);
}

{
    NSString *regEx = @"12";
    NSString *string = @"123123";
    NSError *error;
    NSRegularExpression *regularExpression = [NSRegularExpression regularExpressionWithPattern:regEx options:kNilOptions error:&error];
    if (error) {
        NSLog(@"error = %@", error);
    }

    NSUInteger number = [regularExpression numberOfMatchesInString:string options:kNilOptions range:NSMakeRange(0, string.length)];
    NSLog(@"匹配的个数 = %lu", (unsigned long) number);

    BOOL matched = (number != 0);
    NSLog(@"是否匹配 = %d", matched);


}

{

    NSString *regEx = @"12";
    NSString *string = @"123123";
    NSError *error;
    NSRegularExpression *regularExpression = [NSRegularExpression regularExpressionWithPattern:regEx options:kNilOptions error:&error];
    if (error) {
        NSLog(@"error = %@", error);
    }

    NSTextCheckingResult *firstMatch = [regularExpression firstMatchInString:string options:0 range:NSMakeRange(0, string.length)];
    if (firstMatch) {
        // NSTextCheckingResult 的 range 属性即匹配的字符串的位置
        NSString *matchedString = [string substringWithRange:firstMatch.range];
        NSLog(@"匹配的字符串 = %@", matchedString);
    } else {
        NSLog(@"匹配的字符串 = 错误");
    }

}

{
    NSString *regEx = @"<正则表达式>";
    NSString *string = @"<待匹配的字符串>";
    NSError *error;
    NSRegularExpression *regularExpression = [NSRegularExpression regularExpressionWithPattern:regEx options:kNilOptions error:&error];
    if (error) {
        NSLog(@"error = %@", error);
    }

    NSArray *matchArray = [regularExpression matchesInString:string options:0 range:NSMakeRange(0, string.length)];
    for (NSTextCheckingResult *match in matchArray) {
        NSString *matchedString = [string substringWithRange:match.range];
        NSLog(@"匹配的字符串 = %@", matchedString);
    }

}    {
/// <正则表达式>
NSString *regEx = @"12";
///<待匹配的字符串>
NSString *string = @"1234567";

NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regEx];
BOOL matched = [predicate evaluateWithObject:string];
NSLog(@"是否匹配 = %d", matched);
}

{
NSString *regEx = @"12";
NSString *string = @"123123";
NSError *error;
NSRegularExpression *regularExpression = [NSRegularExpression regularExpressionWithPattern:regEx options:kNilOptions error:&error];
if (error) {
    NSLog(@"error = %@", error);
}

NSUInteger number = [regularExpression numberOfMatchesInString:string options:kNilOptions range:NSMakeRange(0, string.length)];
NSLog(@"匹配的个数 = %lu", (unsigned long) number);

BOOL matched = (number != 0);
NSLog(@"是否匹配 = %d", matched);


}

{

NSString *regEx = @"12";
NSString *string = @"123123";
NSError *error;
NSRegularExpression *regularExpression = [NSRegularExpression regularExpressionWithPattern:regEx options:kNilOptions error:&error];
if (error) {
    NSLog(@"error = %@", error);
}

NSTextCheckingResult *firstMatch = [regularExpression firstMatchInString:string options:0 range:NSMakeRange(0, string.length)];
if (firstMatch) {
    // NSTextCheckingResult 的 range 属性即匹配的字符串的位置
    NSString *matchedString = [string substringWithRange:firstMatch.range];
    NSLog(@"匹配的字符串 = %@", matchedString);
} else {
    NSLog(@"匹配的字符串 = 错误");
}

}

{
NSString *regEx = @"<正则表达式>";
NSString *string = @"<待匹配的字符串>";
NSError *error;
NSRegularExpression *regularExpression = [NSRegularExpression regularExpressionWithPattern:regEx options:kNilOptions error:&error];
if (error) {
    NSLog(@"error = %@", error);
}

NSArray *matchArray = [regularExpression matchesInString:string options:0 range:NSMakeRange(0, string.length)];
for (NSTextCheckingResult *match in matchArray) {
    NSString *matchedString = [string substringWithRange:match.range];
    NSLog(@"匹配的字符串 = %@", matchedString);
}

}
```
### 谓词
```
/***
 类似IN NOT 这样的字符串有下面几种固定的。
 AND、OR、IN、NOT、ALL、ANY、SOME、NONE、LIKE、CASEINSENSITIVE、CI、MATCHES、CONTAINS、BEGINSWITH、ENDSWITH、BETWEEN、NULL、NIL、SELF、TRUE、YES、FALSE、NO、FIRST、LAST、SIZE、ANYKEY、SUBQUERY、CAST、TRUEPREDICATE、FALSEPREDICATE，
 所表达的含义和字母意识都差不多。

 
 
 */

{
    
    NSMutableArray *array = [NSMutableArray array];
    {
        Person *p = Person.alloc.init;
        p.name = @"jim";
        p.age = 2;
        [array addObject:p];
    }
    {
        Person *p = Person.alloc.init;
        p.name = @"jim";
        p.age = 1;
        [array addObject:p];
    }
    {
        Person *p = Person.alloc.init;
        p.name = @"tom";
        p.age = 3;
        [array addObject:p];
    }
    {
        Person *p = Person.alloc.init;
        p.name = @"tom";
        p.age = 4;
        [array addObject:p];
    }
    {
        Person *p = Person.alloc.init;
        p.name = @"joM";
        p.age = 4;
        [array addObject:p];
    }
    NSLog(@"sum = %@",[array valueForKeyPath:@"@sum.age"]);
    NSLog(@"avg = %@",[array valueForKeyPath:@"@avg.age"]);
    NSLog(@"max = %@",[array valueForKeyPath:@"@max.age"]);
    NSLog(@"min = %@",[array valueForKeyPath:@"@min.age"]);

    
    NSPredicate * filterPredicate = [NSPredicate predicateWithFormat:@"name IN %@",@[@"jim",@"jack"]];
    //过滤数组
    NSArray * arr = [array filteredArrayUsingPredicate:filterPredicate];
    NSLog(@"只有string = %@",arr);
    [arr enumerateObjectsUsingBlock:^(Person *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSLog(@"name包括 %@ %ld",obj.name,obj.age);
    }];
    
    {
        NSPredicate * filterPredicate = [NSPredicate predicateWithFormat:@"age BETWEEN %@",@[@2,@5]];
        //过滤数组
        NSArray * arr = [array filteredArrayUsingPredicate:filterPredicate];
        [arr enumerateObjectsUsingBlock:^(Person *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSLog(@"BETWEEN age = %@ %ld",obj.name,obj.age);
        }];
        
        
    }
    /// 分类汇总
    NSMutableArray<Person *> *array2 = [NSMutableArray array];
    [[NSSet setWithArray:[array valueForKeyPath:@"name"]] enumerateObjectsUsingBlock:^(NSString *  _Nonnull obj, BOOL * _Nonnull stop) {
        
        NSPredicate * pre = [NSPredicate predicateWithFormat:@"name = %@",obj];
        NSArray * arr = [array filteredArrayUsingPredicate:pre];
        NSInteger total = [[arr valueForKeyPath:@"@sum.age"] integerValue];
        
        Person *p = Person.alloc.init;
        p.name = obj;
        p.age = total;
        [array2 addObject:p];
        
    }];
    {
        NSPredicate * filterPredicate = [NSPredicate predicateWithFormat:@"name == %@",@"jim"];
        //过滤数组
        NSArray * arr = [array filteredArrayUsingPredicate:filterPredicate];
        [arr enumerateObjectsUsingBlock:^(Person *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSLog(@"name 等于指定 %@ %ld",obj.name,obj.age);
        }];
        
        
        NSLog(@"获得所有的 name == %@",[array valueForKey:@"name"]);
        
    }
    
    {
        /// '*om*' 直接拼接,还没有找到好办法
        NSPredicate * filterPredicate = [NSPredicate predicateWithFormat:@"name LIKE '*om*'"];
        //过滤数组
        NSArray * arr = [array filteredArrayUsingPredicate:filterPredicate];
        [arr enumerateObjectsUsingBlock:^(Person *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSLog(@"LIKT 区分大小写 = %@ %ld",obj.name,obj.age);
        }];
    }
    {
        NSPredicate * filterPredicate = [NSPredicate predicateWithFormat:@"name like[cd] '*om*'"];
        NSLog(@"predicateFormat %@",filterPredicate.predicateFormat);
        //过滤数组
        NSArray * arr = [array filteredArrayUsingPredicate:filterPredicate];
        [arr enumerateObjectsUsingBlock:^(Person *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSLog(@"LIKT 不区分大小写 = %@ %ld",obj.name,obj.age);
        }];
    }
    
}
{
    NSArray *array= [NSArray arrayWithObjects:@"2.0",@"2.3",@"3.0",@"4.0",@"10",nil];
    NSLog(@"sum ==== %@",[array valueForKeyPath:@"@sum.floatValue"]);
    
    CGFloat sum = [[array valueForKeyPath:@"@sum.floatValue"] floatValue];
    
    CGFloat avg = [[array valueForKeyPath:@"@avg.floatValue"] floatValue];
    CGFloat max =[[array valueForKeyPath:@"@max.floatValue"] floatValue];
    
    CGFloat min =[[array valueForKeyPath:@"@min.floatValue"] floatValue];
}
{
    
    /// array 不在 array2 中的 的元素
    NSArray *array = @[@"1",@"2",@"2",@"3",@"3",@"3"];
    NSArray *array2 = @[@"1",@"4"];
    NSPredicate * filterPredicate = [NSPredicate predicateWithFormat:@"NOT (SELF IN %@)",array2];
    //过滤数组
    NSArray * reslutFilteredArray = [array filteredArrayUsingPredicate:filterPredicate];
    
    NSLog(@"不在 Array = %@",reslutFilteredArray);
}
{
    /// array 在 array2 中的 的元素
    NSArray *array = @[@"1",@"2",@"2",@"3",@"3",@"3"];
    NSArray *array2 = @[@"2",@"2",@"2",@"4"];
    NSPredicate * filterPredicate = [NSPredicate predicateWithFormat:@"SELF IN %@",array2];
    //过滤数组
    NSArray * reslutFilteredArray = [array filteredArrayUsingPredicate:filterPredicate];
    
    NSLog(@"在 Array = %@",reslutFilteredArray);
}
{
    /// 大于,需要是Number
    NSArray *array = @[@1,@2,@2,@2,@3,@3];
    NSPredicate * filterPredicate = [NSPredicate predicateWithFormat:@"SELF >= 2"];
    //过滤数组
    NSArray * reslutFilteredArray = [array filteredArrayUsingPredicate:filterPredicate];
    
    NSLog(@"大于 Array = %@",reslutFilteredArray);
}
```

## UIScrollViewContentInsetAdjustmentNever
```
/// 处理方式：为了适配iOS11，我们需要把这个属性禁用调，
/// 使用UIScrollViewContentInsetAdjustmentNever不计算内边距，
/// 不然系统会帮我们自动计算内边距，这样在滚动之后无法定位，会出现额外的内边距偏差。

- (void)adapterIOS11{
    // 适配iOS11以上UITableview 、UICollectionView、UIScrollview 列表/页面偏移
    if (@available(iOS 11.0, *)){
        [[UIScrollView appearance] setContentInsetAdjustmentBehavior:UIScrollViewContentInsetAdjustmentNever];

        [[UITableView appearance] setEstimatedRowHeight:0];
        [[UITableView appearance] setEstimatedSectionFooterHeight:0];
        [[UITableView appearance] setEstimatedSectionHeaderHeight:0];
    }
}
```
## UILabel 的抗拉伸和抗压缩
```
// 抗被拉伸
[self.label setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
// 抗被压缩
[self.label setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
```
## UITextField 系统键盘输入汉字,点击确定再触发事件
```
[textField addTarget:self action:@selector(textFieldDidChangeEvent:) forControlEvents:UIControlEventEditingChanged];
```
```
- (void)textFieldDidChangeEvent:(UITextField *)textField{
    if (textField.markedTextRange == nil)//点击完选中的字之后
    {
        NSLog(@"textFieldDidChange:%@", textField.text);
    }
    else//没有点击出现的汉字,一直在点击键盘
    {
        NSLog(@"markedTextRange:%@",textField.text);
        
    }
}
```

## 同步遍历 可以创建指定长度 数组

```
/// GCD dispatch_apply函数是一个同步调用，
/// block任务执行n次后才返回。该函数比较适合处理耗时较长、迭代次数较多的情况。

dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
dispatch_apply(10, queue, ^(size_t insex) {
    NSLog(@"insex = %zu",insex);
});
NSLog(@"insex = 完成");
```

```
/// forin 删除会越界
/// 迭代器 删除不会越界
[tempArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
    if ([obj isEqualToString:@"B"]) {
        [tempArray removeObject:obj];
    }
}];

/// 删除不会越界
for (int i = 0; i < array.count; i++) {
    NSString *str  = array[i];
    if ([str isEqualToString:@"4"]) {
        [array removeObject:str];
    }
}

///逆序一下 删除不会越界
NSMutableArray *tempArray = [NSMutableArray arrayWithArray:@[@"A",@"B",@"C"]];
for (NSString *number in tempArray.reverseObjectEnumerator) {
    if ([number isEqualToString:@"B"]) {
        [tempArray removeObject:number];
    }
}
NSLog(@"tempArray = %@",tempArray);
```
## 写入文件
```
//获取document路径
NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
NSString *documentDirectory = [paths objectAtIndex:0];

//文件名及其路径
NSString *fileName = @"test.txt";
NSString *filePath = [documentDirectory stringByAppendingPathComponent:fileName];

//建立一个char数组，并归档写入到沙盒中
char *a = "hello, world";
NSData *data = [NSData dataWithBytes:a length:12];
[data writeToFile:filePath atomically:YES];
```

## push vc 是否存在
```
/// parent==nil 表示返回了
- (void)didMoveToParentViewController:(UIViewController *)parent {
    [super didMoveToParentViewController:parent];
    NSLog(@"didMoveToParentViewController %@  self = %@",parent,self);
}
```
## 图片变色
```
UIImageRenderingModeAutomatic  // 根据图片的使用环境和所处的绘图上下文自动调整渲染模式。  
UIImageRenderingModeAlwaysOriginal   // 始终绘制图片原始状态，不使用Tint Color。  
UIImageRenderingModeAlwaysTemplate   // 始终根据Tint Color绘制图片，忽略图片的颜色信息。

```
```
UIImage *image = [UIImage imageNamed:@"qr-code"];
self.ImageView.image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
[self.ImageView setTintColor:[UIColor redColor]];
```
## UIAlertController 改变主图色
```
+ (void)load {
    
    /// 这个方式,是 UIAlertController init 后改变颜色, 后续使用再改变颜色,以使用颜色为主
    [UIAlertController ax_replaceClassMethodWithOriginal:@selector(alertControllerWithTitle:message:preferredStyle:) newSelector:@selector(ax_alertControllerWithTitle:message:preferredStyle:)];
    
    [UIAlertController ax_replaceInstanceMethodWithOriginal:@selector(addAction:) newSelector:@selector(ax_addAction:)];
}
-(void)ax_addAction:(UIAlertAction *)action{
    [action setValue:UIColor.orangeColor forKey:@"_titleTextColor"];
    [self ax_addAction:action];
}

+ (UIAlertController *)ax_alertControllerWithTitle:(nullable NSString *)title message:(nullable NSString *)message preferredStyle:(UIAlertControllerStyle)preferredStyle {
    UIAlertController *alert =  [self ax_alertControllerWithTitle:title message:message preferredStyle:preferredStyle];
    if (alert.title.length) {
        //修改title字体及颜色
        NSMutableAttributedString *titleStr = [[NSMutableAttributedString alloc] initWithString:alert.title];
        [titleStr addAttribute:NSForegroundColorAttributeName value:[UIColor greenColor] range:NSMakeRange(0, titleStr.string.length)];
        [titleStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15] range:NSMakeRange(0, titleStr.string.length)];
        [alert setValue:titleStr forKey:@"attributedTitle"];
    }
    if(alert.message.length){
        // 修改message字体及颜色
        NSMutableAttributedString *messageStr = [[NSMutableAttributedString alloc] initWithString:alert.message];
        [messageStr addAttribute:NSForegroundColorAttributeName value: [UIColor greenColor] range:NSMakeRange(0, messageStr.string.length)];
        [messageStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12] range:NSMakeRange(0, messageStr.string.length)];
        [alert setValue:messageStr forKey:@"attributedMessage"];
    }
    return alert;
    
}
```
##  UIAlertController title ,msg nil 时候不弹出
```
[UIAlertController ax_replaceInstanceMethodWithOriginal:@selector(addAction:) newSelector:@selector(ax_addAction:)];

/// usingBlock: 第一个参数 调用对象,第二个是方法的第一次参数
[UIViewController aspect_hookSelector:@selector(presentViewController:animated:completion:) withOptions:AspectPositionInstead usingBlock:^(id<AspectInfo> aspectInfo,UIViewController *presentViewController) {
    /// aspectInfo.arguments.firstObject 就是 presentViewController
    if (![presentViewController isKindOfClass:[UIAlertController class]]) {
        [aspectInfo.originalInvocation invoke];
    }else{
        UIAlertController *alertController = (UIAlertController *)presentViewController;
        /// 这里用 == nil ,不要用length==0,业务需求不一样
        /// UIAlertControllerStyleAlert 才拦截
        if (alertController.title != nil || alertController.message != nil || alertController.preferredStyle !=UIAlertControllerStyleAlert) {
            [aspectInfo.originalInvocation invoke];
        }
    }
} error:nil];
```

iOS13 icon
```
UIImage *image = [UIImage systemImageNamed:@"ladybug.fill"];
```
