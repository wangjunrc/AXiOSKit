//
//  _p01ContentViewController.m
//  AXiOSKitExample
//
//  Created by 小星星吃KFC on 2020/9/19.
//  Copyright © 2020 liuweixing. All rights reserved.
//

#import "_01ContentViewController.h"

#import <AXiOSKit/AXBiometryManager.h>
#import <AXiOSKit/AXLocationManager.h>
#import <AXiOSKit/AXiOSKit.h>
#import <AuthenticationServices/AuthenticationServices.h>
#import <Canvas/Canvas.h>
#import <Masonry/Masonry.h>
#import <ReactiveObjC/ReactiveObjC.h>
#import <SDWebImage/UIImageView+WebCache.h>
#import <SystemConfiguration/CaptiveNetwork.h>
#import <UserNotifications/UserNotifications.h>
#import <GDataXML_HTML/GDataXMLNode.h>
#import "AXiOSKit_Example-Swift.h"
#import <MJExtension/MJExtension.h>
@interface _01ContentViewController ()<UITextViewDelegate,ASAuthorizationControllerDelegate,ASAuthorizationControllerPresentationContextProviding>

@property (nonatomic, strong) MASConstraint *viewBottomConstraint;

@property(nonatomic, strong) AXBiometryManager *manager;

@property(nonatomic, strong) UIPageControl *pageControl;

@property(nonatomic, strong) AXLocationManager *locationManager;

@property(nonatomic, assign) NSInteger age;

@end

@implementation _01ContentViewController
//- (void)injected {
//    NSLog(@"重启了 InjectionIII: %@", self);
//    [self viewDidLoad];
//}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"02";
    
    __weak typeof(self) weakSelf = self;
    [self _p01UITextView_link];
    [self _p01loginTest];
    [self _p02AlternateIconName];
    [self _p03LocationManager];
    [self _p03wifi];
    [self _p03textToImg];
    [self _p04masron_uninstall];
    [self _p05DateVC];
    [self _p06per];
    [self _p07bubbleImage];
    [self _p08china];
    [self _p09lineSpacing];
    [self _p10flieExist];
    [self _p11ButtonAllEvent];
    [self _p12memoryUsage];
    [self _p12memoryUsage2];
    [self _p12memoryUsage3];
    [self _p13MoreAlter];
    [self _p14xmlToObj];
    [self _p15NSBlockOperation];
    [self _p16NSBlockOperation];
    /// 会弹出 "想要查找并连接到本地网络上的设备" 弹窗
    [self _p00ButtonTitle:@"NSProcessInfo" handler:^{
        
        NSString *uuid1 = [[NSProcessInfo processInfo] globallyUniqueString];
        
        NSLog(@"processInfoww = %@",[NSProcessInfo.processInfo mj_JSONObject] );
        
        NSLog(@"uuid1 = %@",uuid1);
        NSLog(@"uuid2 = %@",[NSString ax_uuid]);
    }];
    
    [self _p00ButtonTitle:@"_01ContentViewController" handler:^{
        __strong typeof(weakSelf) strongSelf = weakSelf;
        _01ContentViewController *vc = [[_01ContentViewController alloc]init];
        [strongSelf.navigationController pushViewController:vc animated:YES];
    }];
    
    [self _p00ButtonTitle:@"popToRootViewControllerAnimated" handler:^{
        __strong typeof(weakSelf) strongSelf = weakSelf;
        [strongSelf.navigationController popToRootViewControllerAnimated:YES];
    }];
    [self _p17CSAnimationView];
    [self _p18appleLogin];
    
    
    /// 底部约束
    [self _loadBottomAttribute];
    
}


-(void)_bottomView {
    
    UIView *bottomView = [UIView ax_init];
    [self.containerView addSubview:bottomView];
    bottomView.backgroundColor = UIColor.orangeColor;
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(50+ax_safe_area_insets_bottom_offset(0));
        make.bottom.mas_equalTo(-ax_safe_area_insets_bottom_zero_offset(10));
    }];
    
    UIView *subView = [UIView ax_init];
    [bottomView addSubview:subView];
    subView.backgroundColor = UIColor.greenColor;
    [subView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.mas_equalTo(0);
        //        make.bottom.mas_equalTo(-ax_safe_area_insets_bottom_offset(10));
        make.height.mas_equalTo(50);
    }];
}

//- (NSString *)application:(NSString *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions{
//    NSLog(@"name %@ %@",application,launchOptions);
//
//    return @"aaa";
//}
//-(void)test:(NSString *)name age:(NSString *)age age2:(NSString *)age2{
//    NSLog(@"name %@ %@",name,age);
//}


-(void)_kvoInt{
    
    __weak typeof(self) weakSelf = self;
    [RACObserve(self, age) subscribeNext:^(id  _Nullable x) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        NSLog(@"age = %ld %@",strongSelf.age,x);
    }];
    
    [self ax_addFBKVOKeyPath:AX_FBKVOKeyPath(self.age) result:^(AXKVOResultModel * _Nonnull resultModel) {
        NSLog(@"age222 = %ld %@",self.age,resultModel.aNewValue);
    }];
    
    UIButton *btn1 = [[UIButton alloc]init];
    [btn1 setTitle:@"kvoInt" forState:UIControlStateNormal];
    btn1.backgroundColor = UIColor.orangeColor;
    [self.containerView addSubview:btn1];
    [btn1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(30);
        
    }];
    
    [btn1 ax_addTargetBlock:^(UIButton * _Nullable button) {
        self.age = ax_randomZeroToValue(100);
        
    }];
}

-(void)_p01loginTest {
    
    
    {
        UITextField *nameTF = [[UITextField alloc]init];
        nameTF.backgroundColor = UIColor.orangeColor;
        nameTF.placeholder = @"输入姓名";
        nameTF.accessibilityIdentifier = @"pwdTextField";
        [self.containerView addSubview:nameTF];
        [nameTF mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.bottomAttribute).mas_offset(20);
            make.left.mas_equalTo(10);
            make.right.mas_equalTo(-10);
            make.height.mas_equalTo(50);
        }];
        self.bottomAttribute = nameTF.mas_bottom;
    }
    {
        UITextField *nameTF = [[UITextField alloc]init];
        nameTF.backgroundColor = UIColor.orangeColor;
        nameTF.placeholder = @"输入密码";
        nameTF.accessibilityIdentifier = @"nameTextField";
        [self.containerView addSubview:nameTF];
        [nameTF mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.bottomAttribute).mas_equalTo(10);
            make.left.mas_equalTo(10);
            make.right.mas_equalTo(-10);
            make.height.mas_equalTo(50);
        }];
        self.bottomAttribute = nameTF.mas_bottom;
    }
}

-(void)_p01UITextView_link {
    
    NSString *str1 = @"点击“立即体验”按钮，\n即表示你同意";
    NSString *str3 = @"《许可及服务协议》";
    NSString *str = [NSString stringWithFormat:@"%@%@",str1,str3];
    NSRange range3 = [str rangeOfString:str3];
    
    NSMutableAttributedString *mastring = [[NSMutableAttributedString alloc] initWithString:str attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12],NSForegroundColorAttributeName: [UIColor blackColor]}];
    
    [mastring addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:range3];
    NSString *link = [[NSString stringWithFormat:@"license://%@",str3] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]];
    /// 这里修改UITextView链接字体颜色无效
    [mastring addAttribute:NSLinkAttributeName value:link range:range3];
    
    UITextView *textView = [[UITextView alloc] init];
    textView.editable = NO;
    textView. scrollEnabled= NO;
    textView.delegate = self;
    textView.attributedText = mastring;
    textView.textAlignment = NSTextAlignmentCenter;
    textView.backgroundColor = UIColor.clearColor;
    /// 链接字体颜色
    textView.linkTextAttributes = @{NSForegroundColorAttributeName:[UIColor redColor],NSUnderlineStyleAttributeName:@1};
    [self.containerView addSubview:textView];
    [textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bottomAttribute).mas_offset(10);
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(-10);
        make.height.mas_equalTo(50);
    }];
    
    self.bottomAttribute = textView.mas_bottom;
    
}

//- (BOOL)textView:(UITextView *)textView shouldInteractWithURL:(NSURL *)URL inRange:(NSRange)characterRange {
//
//    if ([[URL scheme] isEqualToString:@"license"]) {
//
//        NSString *titleString = [NSString stringWithFormat:@"你点击了第一个文字:%@",[URL host]];
//
//        NSLog(@"%@",titleString);
//
//        return NO;
//
//    }
//    return YES;
//
//}
- (BOOL)textView:(UITextView *)textView shouldInteractWithURL:(NSURL *)URL inRange:(NSRange)characterRange interaction:(UITextItemInteraction)interaction {
    
    if ([[URL scheme] isEqualToString:@"license"]) {
        
        NSString *titleString = [NSString stringWithFormat:@"你点击了第一个文字:%@",[URL host]];
        
        NSLog(@"%@",titleString);
        
        return NO;
        
    }
    return YES;
}


-(void)_p02AlternateIconName {
    
    __weak typeof(self) weakSelf = self;
    return [self _p00ButtonTitle:@"换icon" handler:^{
        __strong typeof(weakSelf) strongSelf = weakSelf;
        [strongSelf setIconname:@"Alternate_AppIcon_2"];
    }];
    
    
    
}



- (void)setIconname:(NSString *)name {
    UIApplication *appli = [UIApplication sharedApplication];
    //判断系统是否支持切换icon
    if (@available(iOS 10.3, *)) {
        if ([appli supportsAlternateIcons]) {
            //切换icon
            [appli setAlternateIconName:name completionHandler:^(NSError * _Nullable error) {
                if (error) {
                    NSLog(@"error==> %@",error.localizedDescription);
                }else{
                    NSLog(@"done!!!");
                }
            }];
        }
    } else {
        // Fallback on earlier versions
    }
}
-(void)_p03LocationManager {
    __weak typeof(self) weakSelf = self;
    return [self _p00ButtonTitle:@"定位" handler:^{
        __strong typeof(weakSelf) strongSelf = weakSelf;
        strongSelf.locationManager =   [AXLocationManager managerWithState:AXLocationStateWhenInUseAuthorization result:^(BOOL resultState, CLLocation *location) {
            NSLog(@"定位 = %@",location);
        }];
    }];
}

-(void)_p03wifi {
    __weak typeof(self) weakSelf = self;
    return [self _p00ButtonTitle:@"wifi信息" handler:^{
        __strong typeof(weakSelf) strongSelf = weakSelf;
        [strongSelf _WiFi];
    }];
}

-(void)_p03textToImg {
    
    UIImageView *img = [[UIImageView alloc]initWithFrame:CGRectMake(100, 100, 100, 50)];
    
    [self.containerView addSubview:img];
    [img mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bottomAttribute).mas_equalTo(10);
        make.left.mas_equalTo(10);
        make.height.mas_equalTo(50);
    }];
    img.backgroundColor = UIColor.orangeColor;
    //    img.contentMode = UIViewContentModeCenter;
    //    img.image =   [UIImage imageFromText:@[@"jim"] withFont:20 withTextColor:UIColor.redColor withBgImage:nil withBgColor:UIColor.blueColor];
    img.contentMode = UIViewContentModeScaleAspectFill;
    img.image = [UIImage imageFromText:@[@"jim"]  withFont:100];
    self.bottomAttribute = img.mas_bottom;
}

-(void)_p04masron_uninstall {
    
    CGFloat width = 100;
    
    UIView *view1 = [[UIView alloc]init];
    [self.containerView addSubview:view1];
    view1.backgroundColor = UIColor.orangeColor;
    [view1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bottomAttribute).mas_equalTo(10);
        make.left.mas_equalTo(30);
        make.height.mas_equalTo(100);
        
        self.viewBottomConstraint = make.width.mas_equalTo(width);
    }];
    
    
    [view1 ax_addLineDirection:AXLineDirectionTop color:UIColor.redColor height:2];
    
    
    self.bottomAttribute = view1.mas_bottom; ;
    
    __weak typeof(self) weakSelf = self;
    [self _p00ButtonTitle:@"masron - uninstall" handler:^{
        __strong typeof(weakSelf) strongSelf = weakSelf;
        [strongSelf.viewBottomConstraint uninstall];
        [view1.superview setNeedsUpdateConstraints];
        [UIView animateWithDuration:1 animations:^{
            [view1 mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.mas_equalTo(-30);
            }];
            [view1.superview layoutIfNeeded];
        }];
    }];
}

-(void)_p05DateVC {
    __weak typeof(self) weakSelf = self;
    return [self _p00ButtonTitle:@"date" handler:^{
        __strong typeof(weakSelf) strongSelf = weakSelf;
        AXDateVC *vc = [[AXDateVC alloc]init];
        [strongSelf ax_showVC:vc];
    }];
}

-(void)_p06per {
    
    //    __weak typeof(self) weakSelf = self;
    return [self _p00ButtonTitle:@"奔溃拦截" handler:^{
        //        __strong typeof(weakSelf) strongSelf = weakSelf;
        //        [self performSelector:@selector(test:age:age2:) withObjects:@[@"JIM",@"20"]];
        //        id obj =[self performSelector:@selector(application:didFinishLaunchingWithOptions:) withObjects:@[@"JIM",@"20"]];
        //        NSLog(@"obj = %@",obj);
        NSMutableArray *array = [NSMutableArray array];
        [array addObject:nil];
    }];
    
}

-(void)_p07bubbleImage {
    //leftCapWidth: 左边不拉伸的像素
    //topCapHeight:上边不拉伸的像素
    UIImage *image = [UIImage imageNamed:@"chat_bubble"];
    UIImageView * imgView = [[UIImageView alloc] initWithImage:[image stretchableImageWithLeftCapWidth:30 topCapHeight:30]];
    
    [self.containerView addSubview:imgView];
    [imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bottomAttribute).mas_equalTo(10);
        make.left.mas_equalTo(30);
        make.right.mas_equalTo(-30);
    }];
    
    self.bottomAttribute = imgView.mas_bottom;
}

-(void)_p08china {
    __weak typeof(self) weakSelf = self;
    return [self _p00ButtonTitle:@"中英文排序" handler:^{
        __strong typeof(weakSelf) strongSelf = weakSelf;
        [strongSelf _chinaText];
    }];
}

-(void)_chinaText {
    //模拟后台返回数据
    NSArray * array1 = @[@"陕西",@"山东",@"上海",@"内蒙古",@"新疆",@"西藏",@"北京",@"安徽",@"重庆",@"湖北",@"江苏",@"浙江",@"天津",@"California",@"贵州",@"云南",@"广东",@"甘肃",@"青海",@"宁夏",@"黑龙江",@"辽宁",@"吉林",@"江西",@"LosAngels",@"OKC",@"GSW"];
    
    //对数组按照首字母进行排序
    NSArray *array = [self getOrderArraywithArray:array1];
    //创建可变字典保存处理后的数据@{@"A":@[@"A",@"AB"]};数据格式
    NSMutableDictionary *mDic = [NSMutableDictionary new];
    for (NSString *city in array) {
        // 将中文转换为拼音
        NSString *cityMutableString = [NSMutableString stringWithString:city];
        CFStringTransform((__bridge CFMutableStringRef)cityMutableString, NULL, kCFStringTransformMandarinLatin, NO);
        CFStringTransform((__bridge CFMutableStringRef)cityMutableString, NULL, kCFStringTransformStripCombiningMarks, NO);
        // 拿到首字母作为key
        NSString *firstLetter = [[cityMutableString uppercaseString]substringToIndex:1];
        // 检查是否有firstLetter对应的分组存在, 有的话直接把city添加到对应的分组中
        // 没有的话, 新建一个以firstLetter为key的分组
        
        if ([mDic objectForKey:firstLetter]) {
            NSMutableArray * mCityArray = mDic[firstLetter];
            if (mCityArray) {
                [mCityArray addObject:city];
                mDic[firstLetter] = mCityArray;
            }else{
                mDic[firstLetter] = [NSMutableArray arrayWithArray:@[city]];
            }
        }else{
            [mDic setObject:[NSMutableArray arrayWithArray:@[city]] forKey:firstLetter];
        }
    }
    //获取索引栏数据 获得字母
    NSArray *titlesArray = [self reqDiction:mDic];
    
    NSLog(@"mDic %@",mDic.allValues);
    NSLog(@"titlesArray %@",titlesArray);
    
}


-(void)_p09lineSpacing {
    UILabel *label = UILabel.ax_init;
    label.numberOfLines = 0;
    label.text = @"aaa\nbbb\nccc\n";
    label.backgroundColor = UIColor.orangeColor;
    [self.containerView addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bottomAttribute).mas_offset(10);
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(-10);
    }];
    self.bottomAttribute = label.mas_bottom;
    
    return [self _p00ButtonTitle:@"kvc修改间距" handler:^{
        [label setValue:@40 forKey:@"lineSpacing"];
        //        label.text = @"1111\n222\n333\n";
    }];
}


-(void)_p10flieExist {
    
    
    return [self _p00ButtonTitle:@"字符串是否包含另一字符串,不区分大小写" handler:^{
        
        
        NSString * string = @"HelloChina";
        if ([string localizedCaseInsensitiveContainsString:@"OCHI"]) {
            NSLog(@"localizedCaseInsensitiveContainsString 包含");
        } else {
            NSLog(@"localizedCaseInsensitiveContainsString 不包含");
        }
        
        if ([string containsString:@"OCHI"]) {
            NSLog(@"containsString 包含");
        } else {
            NSLog(@"containsString 不包含");
        }
        if ([string localizedStandardContainsString:@"OCHI"]) {
            NSLog(@"localizedStandardContainsString 包含");
        } else {
            NSLog(@"localizedStandardContainsString 不包含");
        }
        
        
        NSRange r = [string rangeOfString:@"OCHI"
                                  options:NSCaseInsensitiveSearch];
        BOOL b = r.location != NSNotFound;
        NSLog(@"b = %d",b);
        
        
    }];
}


-(void)_p11ButtonAllEvent {
    
    
    UIButton *btn = [[UIButton alloc] init];
    [self.containerView addSubview:btn];
    btn.backgroundColor = UIColor.blueColor;
    [btn ax_setTitleStateNormal:@"按钮各种事件"];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bottomAttribute).mas_equalTo(20);
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(-10);
    }];
    /// 按钮事件
    [[btn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(UIButton *x) {
        NSLog(@"UIControlEventTouchUpInside 所有在控件之内触摸抬起事件");
    }];
    [[btn rac_signalForControlEvents:UIControlEventTouchUpOutside] subscribeNext:^(UIButton *x) {
        NSLog(@"UIControlEventTouchUpOutside 所有在控件之外触摸抬起事件(点触必须开始与控件内部才会发送通知");
    }];
    
    [[btn rac_signalForControlEvents:UIControlEventTouchDown] subscribeNext:^(UIButton *x) {
        NSLog(@"UIControlEventTouchDown 单点触摸按下事件：用户点触屏幕，或者又有新手指落下的时候");
    }];
    
    [[btn rac_signalForControlEvents:UIControlEventTouchDragEnter] subscribeNext:^(UIButton *x) {
        NSLog(@"UIControlEventTouchDragEnter 当一次触摸从控件窗口之外拖动到内部时");
    }];
    [[btn rac_signalForControlEvents:UIControlEventTouchDragInside] subscribeNext:^(UIButton *x) {
        NSLog(@"UIControlEventTouchDragInside 当一次触摸在控件窗口内拖动时。");
    }];
    [[btn rac_signalForControlEvents:UIControlEventTouchDragOutside] subscribeNext:^(UIButton *x) {
        NSLog(@"UIControlEventTouchDragOutside 当一次触摸在控件窗口之外拖动时");
    }];
    [[btn rac_signalForControlEvents:UIControlEventTouchDragExit] subscribeNext:^(UIButton *x) {
        NSLog(@"UIControlEventTouchDragExit 当一次触摸从控件窗口内部拖动到外部时");
    }];
    [[btn rac_signalForControlEvents:UIControlEventTouchDownRepeat] subscribeNext:^(UIButton *x) {
        NSLog(@"UIControlEventTouchDownRepeat 多点触摸按下事件，点触计数大于1");
    }];
    
    self.bottomAttribute = btn.mas_bottom;
}


-(void)_p12memoryUsage {
    UILabel *label = UILabel.ax_init;
    [self.containerView addSubview:label];
    label.textColor = UIColor.blackColor;
    label.text = [NSString stringWithFormat:@"%lf/MB",[UIDevice ax_memoryUsage]/1024.0/1024.0];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bottomAttribute).mas_equalTo(20);
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(-10);
    }];
    self.bottomAttribute = label.mas_bottom;
}
-(void)_p12memoryUsage2 {
    UILabel *label = UILabel.ax_init;
    [self.containerView addSubview:label];
    label.textColor = UIColor.blackColor;
    label.text = [NSString stringWithFormat:@"%lfMB",[UIDevice ax_memoryUsage2]/1024.0/1024.0];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bottomAttribute).mas_equalTo(20);
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(-10);
    }];
    self.bottomAttribute = label.mas_bottom;
}
-(void)_p12memoryUsage3 {
    UILabel *label = UILabel.ax_init;
    [self.containerView addSubview:label];
    label.textColor = UIColor.blackColor;
    label.text = [NSString stringWithFormat:@"%lfMB",[UIDevice ax_memoryUsage3]/1024.0/1024.];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bottomAttribute).mas_equalTo(20);
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(-10);
    }];
    self.bottomAttribute = label.mas_bottom;
}

-(void)_p13MoreAlter{
    
    __weak typeof(self) weakSelf = self;
    return [self _p00ButtonTitle:@"多个alert" handler:^{
        __strong typeof(weakSelf) strongSelf = weakSelf;
        // 第一个UIAlertController
        UIAlertController *alertController1 = [UIAlertController alertControllerWithTitle:@"测试1" message:@"测试1" preferredStyle:UIAlertControllerStyleAlert];
        [alertController1 addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }]];
        [alertController1 addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }]];
        [strongSelf presentViewController:alertController1 animated:YES completion:nil];
        
        
        // 第二个UIAlertController
        UIAlertController *alertController2 = [UIAlertController alertControllerWithTitle:@"测试2" message:@"测试2" preferredStyle:UIAlertControllerStyleAlert];
        [alertController2 addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }]];
        [alertController2 addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }]];
        /// UIAlertController
        [alertController1 presentViewController:alertController2 animated:YES completion:nil];
    }];
    
}

-(void)_p14xmlToObj{
    
    __weak typeof(self) weakSelf = self;
    return [self _p00ButtonTitle:@"xml解析" handler:^{
        __strong typeof(weakSelf) strongSelf = weakSelf;
        
        NSString *path = [[NSBundle mainBundle]pathForResource:@"testXML" ofType:@"xml"];
        GDataXMLDocument *document = [[GDataXMLDocument alloc] initWithData:[NSData dataWithContentsOfFile:path] encoding:NSUTF8StringEncoding  error:NULL];
        NSLog(@"attributes = %@",document.rootElement.attributes);
        
        /// 这一层是 xmlns
        for (GDataXMLElement *element in document.rootElement.attributes) {
            NSLog(@"attributes node.name = %@----node.stringValue = %@",element.name,element.stringValue);
            
        }
        /// 这一层是 body
        for (GDataXMLElement *element in document.rootElement.children) {
            NSLog(@"element.attributes = %@",element.attributes);
            NSLog(@"children node.name = %@----node.stringValue = %@",element.name,element.stringValue);
            ///再解析一下 properties
            
            for (GDataXMLElement *node in element.children) {
                NSLog(@"node.name = %@----node.stringValue = %@",node.name,node.stringValue);
                
                //                        [video setValue:node.stringValue forKeyPath:node.name];
            }
            for (GDataXMLNode *att in element.attributes) {
                NSLog(@"att.stringValue = %@",att.stringValue);
            }
        }
        
        
    }];
    
}

-(void)_p15NSBlockOperation {
    return [self _p00ButtonTitle:@"NSBlockOperation" handler:^{
        
        //2.NSBlockOperation(最常使用)
        NSBlockOperation * blockOp = [NSBlockOperation blockOperationWithBlock:^{
            //要执行的操作，目前是主线程
            //            NSLog(@"NSBlockOperation 创建，线程：%@",[NSThread currentThread]);
            
            for (int i = 0; i < 2; i++) {
                [NSThread sleepForTimeInterval:2]; // 模拟耗时操作
                NSLog(@"1---%@", [NSThread currentThread]); // 打印当前线程
            }
            
        }];
        //2.1 追加任务，在子线程中执行
        [blockOp addExecutionBlock:^{
            NSLog(@"追加任务一, %@",[NSThread currentThread]);
            
            for (int i = 0; i < 2; i++) {
                [NSThread sleepForTimeInterval:2]; // 模拟耗时操作
                NSLog(@"追加任务一: %@", [NSThread currentThread]); // 打印当前线程
            }
        }];
        //        [blockOp addExecutionBlock:^{
        //            NSLog(@"追加任务二, %@",[NSThread currentThread]);
        //        }];
        [blockOp start];
        
    }];
}

-(void)_p16NSBlockOperation {
    return [self _p00ButtonTitle:@"NSOperationQueue222" handler:^{
        // 1.创建队列
        NSOperationQueue *queue = [[NSOperationQueue alloc] init];
        
        // 2.使用 addOperationWithBlock: 添加操作到队列中
        [queue addOperationWithBlock:^{
            for (int i = 0; i < 2; i++) {
                [NSThread sleepForTimeInterval:2]; // 模拟耗时操作
                NSLog(@"1---%@", [NSThread currentThread]); // 打印当前线程
            }
        }];
        [queue addOperationWithBlock:^{
            for (int i = 0; i < 2; i++) {
                [NSThread sleepForTimeInterval:2]; // 模拟耗时操作
                NSLog(@"2---%@", [NSThread currentThread]); // 打印当前线程
            }
        }];
        [queue addOperationWithBlock:^{
            for (int i = 0; i < 2; i++) {
                [NSThread sleepForTimeInterval:2]; // 模拟耗时操作
                NSLog(@"3---%@", [NSThread currentThread]); // 打印当前线程
            }
        }];
        
    }];
}

- (NSArray *)getOrderArraywithArray:(NSArray *)array{
    //数组排序
    //定义一个数字数组
    //对数组进行排序
    NSArray *result = [array sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        return [obj1 compare:obj2]; //升序
    }];
    return result;
}

- (NSArray *)reqDiction:(NSDictionary *)dict{
    
    NSArray *allKeyArray = [dict allKeys];
    NSArray *afterSortKeyArray = [allKeyArray sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        NSComparisonResult resuest = [obj1 compare:obj2];  //[obj1 compare:obj2]：升序
        return resuest;
    }];
    
    //通过排列的key值获取value
    NSMutableArray *valueArray = [NSMutableArray array];
    for (NSString *sortsing in afterSortKeyArray) {
        NSString *valueString = [dict objectForKey:sortsing];
        [valueArray addObject:valueString];
    }
    
    return afterSortKeyArray;
}


-(void)_WiFi{
    
    NSArray *ifs = CFBridgingRelease(CNCopySupportedInterfaces());
    id info = nil;
    for (NSString *ifnam in ifs) {
        info = (__bridge_transfer id)CNCopyCurrentNetworkInfo((CFStringRef)ifnam);
        if (info && [info count]) {
            break;
        }
    }
    NSDictionary *dic = (NSDictionary *)info;
    NSString *ssid = [[dic objectForKey:@"SSID"] lowercaseString];
    NSString *bssid = [dic objectForKey:@"BSSID"];
    NSLog(@"wifi ssid:%@ \nssid:%@",ssid,bssid);
}

-(void)_p17CSAnimationView{
    
    CSAnimationView *animationView = [[CSAnimationView alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    
    [self.containerView addSubview:animationView];
    [animationView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bottomAttribute).mas_equalTo(20);
        make.centerX.mas_equalTo(0);
        make.width.height.mas_equalTo(100);
    }];
    
    animationView.backgroundColor = [UIColor redColor];
    animationView.duration = 0.5;
    animationView.delay = 0;
    animationView.type = CSAnimationTypeFadeOutRight;
    
    self.bottomAttribute = animationView.mas_bottom;
    
    UIButton *btn1 = [[UIButton alloc]init];
    [btn1 setTitle:@"CSAnimationView" forState:UIControlStateNormal];
    btn1.backgroundColor = UIColor.orangeColor;
    [self.containerView addSubview:btn1];
    [btn1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bottomAttribute).mas_equalTo(20);
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(-10);
    }];
    self.bottomAttribute = btn1.mas_bottom;
    
    [btn1 ax_addTargetBlock:^(UIButton * _Nullable button) {
        //添加你想增加效果的 View 为 animationView 的子视图
        // [animationView addSubview:<#(void)#>]
        
        //        [animationView startCanvasAnimation];
        
    }];
}


- (void)_p18appleLogin{
    // 使用系统提供的按钮，要注意不支持系统版本的处理
    if (@available(iOS 13.0, *)) {
        // Sign In With Apple Button
        ASAuthorizationAppleIDButton *appleIDBtn = [ASAuthorizationAppleIDButton buttonWithType:ASAuthorizationAppleIDButtonTypeDefault style:ASAuthorizationAppleIDButtonStyleWhite];
        [self.containerView addSubview:appleIDBtn];
        [appleIDBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.bottomAttribute).mas_equalTo(20);
            make.left.mas_equalTo(10);
            make.right.mas_equalTo(-10);
        }];
        appleIDBtn.backgroundColor = [UIColor orangeColor];
        [appleIDBtn addTarget:self action:@selector(didCustomBtnClicked) forControlEvents:UIControlEventTouchUpInside];
        self.bottomAttribute = appleIDBtn.mas_bottom;
    }
    
    // 或者自己用UIButton实现按钮样式
    UIButton *addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.containerView addSubview:addBtn];
    [addBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bottomAttribute).mas_equalTo(20);
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(-10);
    }];
    addBtn.backgroundColor = [UIColor redColor];
    [addBtn setBackgroundImage:[UIImage ax_imageSquareWithColor:UIColor.orangeColor] forState:UIControlStateNormal];
     [addBtn setBackgroundImage:[UIImage ax_imageSquareWithColor:UIColor.greenColor] forState:UIControlStateHighlighted];
    [addBtn setTitle:@"苹果登录" forState:UIControlStateNormal];
    [addBtn setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
    [addBtn addTarget:self action:@selector(didCustomBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    
    self.bottomAttribute = addBtn.mas_bottom;
    
    /// 监听 ASAuthorizationAppleIDProviderCredentialRevokedNotification 通知
    // 注册通知
    if (@available(iOS 13.0, *)) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleSignInWithAppleStateChanged:) name:ASAuthorizationAppleIDProviderCredentialRevokedNotification object:nil];
    }
}
#pragma mark- apple授权状态 更改通知
- (void)handleSignInWithAppleStateChanged:(NSNotification *)notification
{
    NSLog(@"ASAuthorizationAppleIDProviderCredentialRevokedNotification = %@", notification.userInfo);
}


- (void)didCustomBtnClicked{
    
    if (@available(iOS 13.0, *)) {
        // 基于用户的Apple ID授权用户，生成用户授权请求的一种机制
        ASAuthorizationAppleIDProvider *appleIDProvider = [[ASAuthorizationAppleIDProvider alloc] init];
        
        
        NSMutableArray <ASAuthorizationRequest *> * array = [NSMutableArray arrayWithCapacity:2];
        
        // 创建新的AppleID 授权请求
        ASAuthorizationAppleIDRequest *appleIDRequest = [appleIDProvider createRequest];
        // 在用户授权期间请求的联系信息
        appleIDRequest.requestedScopes = @[ASAuthorizationScopeFullName, ASAuthorizationScopeEmail];
        
        if (appleIDRequest) {
            [array addObject:appleIDRequest];
        }
        
        ASAuthorizationPasswordRequest * passwordRequest = [[[ASAuthorizationPasswordProvider alloc] init] createRequest];
        
        
        if (passwordRequest) {
            [array addObject:passwordRequest];
        }
        
        // 由ASAuthorizationAppleIDProvider创建的授权请求 管理授权请求的控制器
        ASAuthorizationController *authorizationController = [[ASAuthorizationController alloc] initWithAuthorizationRequests:array.copy];
        // 设置授权控制器通知授权请求的成功与失败的代理
        authorizationController.delegate = self;
        // 设置提供 展示上下文的代理，在这个上下文中 系统可以展示授权界面给用户
        authorizationController.presentationContextProvider = self;
        // 在控制器初始化期间启动授权流
        [authorizationController performRequests];
    }else{
        // 处理不支持系统版本
        NSLog(@"该系统版本不可用Apple登录");
    }
}

#pragma mark- 授权成功的回调
// 授权成功
- (void)authorizationController:(ASAuthorizationController *)controller didCompleteWithAuthorization:(ASAuthorization *)authorization API_AVAILABLE(ios(13.0)) {
    if ([authorization.credential isKindOfClass:[ASAuthorizationAppleIDCredential class]]) {
        ASAuthorizationAppleIDCredential * credential = (ASAuthorizationAppleIDCredential *)authorization.credential;
        // 苹果用户唯一标识符，该值在同一个开发者账号下的所有 App 下是一样的，开发者可以用该唯一标识符与自己后台系统的账号体系绑定起来。
        NSString * userID = credential.user;
        // 苹果用户信息 如果授权过，可能无法再次获取该信息
        NSPersonNameComponents * fullName = credential.fullName;
        NSString * email = credential.email;
        // 服务器验证需要使用的参数
        NSString * authorizationCode = [[NSString alloc] initWithData:credential.authorizationCode encoding:NSUTF8StringEncoding];
        NSString * identityToken = [[NSString alloc] initWithData:credential.identityToken encoding:NSUTF8StringEncoding];
        // 用于判断当前登录的苹果账号是否是一个真实用户，取值有：unsupported、unknown、likelyReal
        ASUserDetectionStatus realUserStatus = credential.realUserStatus;
        NSLog(@"userID: %@", userID);
        NSLog(@"fullName: %@", fullName);
        NSLog(@"email: %@", email);
        NSLog(@"authorizationCode: %@", authorizationCode);
        NSLog(@"identityToken: %@", identityToken);
        NSLog(@"realUserStatus: %@", @(realUserStatus));
    }
    else if ([authorization.credential isKindOfClass:[ASPasswordCredential class]]) {
        // 用户登录使用现有的密码凭证
        ASPasswordCredential * passwordCredential = (ASPasswordCredential *)authorization.credential;
        // 密码凭证对象的用户标识 用户的唯一标识
        NSString * user = passwordCredential.user;
        // 密码凭证对象的密码
        NSString * password = passwordCredential.password;
        NSLog(@"userID: %@", user);
        NSLog(@"password: %@", password);
    } else {
    }
}

- (void)authorizationController:(ASAuthorizationController *)controller didCompleteWithError:(NSError *)error API_AVAILABLE(ios(13.0)){
    
    NSString * errorMsg = nil;
    
    switch (error.code) {
        case ASAuthorizationErrorCanceled:
            errorMsg = @"用户取消了授权请求";
            break;
        case ASAuthorizationErrorFailed:
            errorMsg = @"授权请求失败";
            break;
        case ASAuthorizationErrorInvalidResponse:
            errorMsg = @"授权请求响应无效";
            break;
        case ASAuthorizationErrorNotHandled:
            errorMsg = @"未能处理授权请求";
            break;
        case ASAuthorizationErrorUnknown:
            errorMsg = @"授权请求失败未知原因";
            break;
    }
    NSLog(@"errorMsg = %@",errorMsg);
    
}

/// ASAuthorizationControllerPresentationContextProviding 就一个方法，主要是告诉 ASAuthorizationController 展示在哪个 window 上。
-(ASPresentationAnchor)presentationAnchorForAuthorizationController:(ASAuthorizationController *)controller
API_AVAILABLE(ios(13.0)){
    return  self.view.window;
}

@end
