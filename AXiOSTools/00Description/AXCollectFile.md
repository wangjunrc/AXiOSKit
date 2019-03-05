


# import 不同类型
#if __has_include(<YYWebImage/YYWebImage.h>)
#import <YYWebImage/YYWebImage.h>
#else
#import "YYWebImage.h"
#endif





# GitHub汇总
https://github.com/Tim9Liu9/TimLiu-iOS

# 消除 过期警告 top
#pragma clang diagnostic push
#pragma clang diagnostic ignored"-Wdeprecated-declarations"

/* 代码放这中间*/
/**
* 消除 过期警告 botton
*/
#pragma clang diagnostic pop

// 将此行放在出现警告的. m 文件中。 消除所有警告
#pragma GCC diagnostic ignored"-Wundeclared-selector"




# 过期宏 三种方式都是 第一种的宏

__attribute__((deprecated(" ")));

DEPRECATED_MSG_ATTRIBUTE ()

DEPRECATED_ATTRIBUTE

#  禁用宏
NS_UNAVAILABLE 当我们不想要其他开发人员，用普通的 init 方法去初始化一个类，我们可以在.h 文件里这样写：
- (instancetype)init NS_UNAVAILABLE;

NS_DESIGNATED_INITIALIZER 指定的初始化方法。当一个类提供多种初始化方法时，所有的初始化方法最终都会调用这个指定的初始化方法。比较常见的有：
- (instancetype)initWithFrame:(CGRect)frame NS_DESIGNATED_INITIALIZER;

一个子类如果有自己的 designed initializer，则必须要实现父类的 designed initializer。比如一个继承自 NSObject 的 Person 类，就必须要重写 init 方法，并在 init 方法中，调用自己的 designed initializer，而不是调用 super 的初始化方法。如果未实现，可以看到编译警告：
Method override for the designed initializer of the superclass ‘- init’ not found.
所以，对于 Person 来说，如果 initWithName: 被标记了 NS_DESIGNED_INITIALIZER ，那么实现应该为：


```

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

# 1 NSSet / NSHashTable 、NSDictionary/ NSMapTable 的学习

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





# 代码触发点击事件
```
sendActionsForControlEvents
```



NSMutableAttributedString 常见的属性：

NSFontAttributeName 字体

NSForegroundColorAttributeName 文字颜色

NSBackgroundColorAttributeName 背景颜色

NSStrikethroughStyleAttributeName 删除线（默认是0，无删除线）

NSUnderlineStyleAttributeName 下划线(默认是0，无下划线)

NSParagraphStyleAttributeName 设置段落／间距 vlue>> NSMutableParagraphStyle





# pod github资源 格式
```
pod 'AXiOSTools',  :git => 'https://github.com/liuweixingGitHub/AXiOSTools.git'
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
1.建立一个bundle文件
2.把js,css,html文件拖入
3.直接加载相对路径
NSString *filePath= [[NSBundle ax_mainBundle] pathForResource:@"HTML.bundle/wk_index.html" ofType:nil];
NSURL *url = [NSURL fileURLWithPath:filePath];
NSURLRequest *request = [NSURLRequest requestWithURL:url];
[self.webView loadRequest:request];


<!--//获取bundlePath 路径-->
<!--NSString *bundlePath = [[NSBundle mainBundle] bundlePath];-->
<!--//获取本地html目录 basePath-->
<!--NSString *basePath = [NSString stringWithFormat: @"%@/www", bundlePath];-->
<!--//获取本地html目录 baseUrl-->
<!--//html 路径-->
<!--NSString *indexPath = [NSString stringWithFormat: @"%@/%@.html", basePath,url];-->
<!--NSURL *fileUrl = [NSURL fileURLWithPath:indexPath];-->
<!--NSURL *baseUrl = [NSURL fileURLWithPath: basePath isDirectory: YES];-->
<!--[self.webView loadFileURL:[NSURL fileURLWithPath:indexPath] allowingReadAccessToURL: baseUrl];-->




# scrollView 滚动方向,x 判断左右, y判断上下

```
CGPoint point =  [scrollView.panGestureRecognizer translationInView:self.view];

if (point.x < 0 ) {
// 往右滚动

}
}
}
```



#同时多个aler 顺序弹出
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




//类属性
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
 集合类(NSMutable,NS) 属性用 copy
@property(nonatomic, copy) 
 非集合 属性用 strong
@property( nonatomic,  strong)   

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
pod search 不到,删除以下文件
~/Library/Caches/CocoaPods/Pods/search_index

本地仓库路径
.cocoapods/repos/master

pod update --no-repo-update

pod repo update 


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

pod 'JJException'

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



# 2个APP中间通信(如微信分享)
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



