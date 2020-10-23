//
//  _01ContentViewController.m
//  AXiOSKitExample
//
//  Created by 小星星吃KFC on 2020/9/19.
//  Copyright © 2020 liuweixing. All rights reserved.
//

#import "_01ContentViewController.h"
#import <Masonry/Masonry.h>
#import <AXiOSKit/AXiOSKit.h>
#import <AXiOSKit/AXLocationManager.h>

#import <SDWebImage/UIImageView+WebCache.h>
#import <AuthenticationServices/AuthenticationServices.h>
#import <AXiOSKit/AXBiometryManager.h>
#import <UserNotifications/UserNotifications.h>
#import <Canvas/Canvas.h>
#import  <SystemConfiguration/CaptiveNetwork.h>

#import <ReactiveObjC/ReactiveObjC.h>

@interface _01ContentViewController ()<UITextViewDelegate>
@property (nonatomic, strong) MASConstraint *viewBottomConstraint;

@property(nonatomic, strong) AXBiometryManager *manager;

@property(nonatomic, strong) UIPageControl *pageControl;

@property(nonatomic, strong) AXLocationManager *locationManager;

@property(nonatomic, assign) NSInteger age;
@end

@implementation _01ContentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    
// self.locationManager =   [AXLocationManager managerWithState:AXLocationStateWhenInUseAuthorization result:^(BOOL resultState, CLLocation *location) {
//
//        [self _WiFi];
//    }];
//    [self _WiFi];
    //    [self _UITextView_link];
//    [self _setAlternateIconName];
   
    
//    [self _loginTest];
    [self _kvoInt];
}

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
    [self.view addSubview:btn1];
    [btn1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(30);
        
    }];
    
    [btn1 ax_addTargetBlock:^(UIButton * _Nullable button) {
        self.age = ax_randomZeroToValue(100);
        
    }];
}

-(void)_loginTest {
    
    
    
    UIView *topView = self.view;
    
    {
        UITextField *nameTF = [[UITextField alloc]init];
        nameTF.backgroundColor = UIColor.orangeColor;
        nameTF.placeholder = @"输入姓名";
        nameTF.accessibilityIdentifier = @"pwdTextField";
        [self.view addSubview:nameTF];
        [nameTF mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(topView).mas_offset(10);
            make.left.mas_equalTo(10);
            make.width.mas_equalTo(200);
            make.height.mas_equalTo(50);
        }];
        topView = nameTF;
    }
    {
        UITextField *nameTF = [[UITextField alloc]init];
        nameTF.backgroundColor = UIColor.orangeColor;
        nameTF.placeholder = @"输入密码";
        nameTF.accessibilityIdentifier = @"nameTextField";
        [self.view addSubview:nameTF];
        [nameTF mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(topView.mas_bottom).mas_equalTo(10);
            make.left.mas_equalTo(10);
            make.width.mas_equalTo(200);
            make.height.mas_equalTo(50);
        }];
        topView = nameTF;
    }
    
}

-(void)_setAlternateIconName{
    UIButton *btn1 = [[UIButton alloc]init];
    [btn1 setTitle:@"换icon" forState:UIControlStateNormal];
    btn1.backgroundColor = UIColor.orangeColor;
    [self.view addSubview:btn1];
    [btn1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(30);
        
    }];
    
    [btn1 ax_addTargetBlock:^(UIButton * _Nullable button) {
        
        
//        [self setIconname:nil];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://www.baidu.com/"]];
        
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
    NSLog(@"ssid:%@ \nssid:%@",ssid,bssid);
    
    
//    NSString *ssid = nil;
//       NSArray *ifs = (__bridge_transfer id)CNCopySupportedInterfaces();
//       for (NSString *ifnam in ifs) {
//           NSDictionary *info = (__bridge_transfer id)CNCopyCurrentNetworkInfo((__bridge CFStringRef)ifnam);
//           if (info[@"SSID"]) {
//               ssid = info[@"SSID"];
//           }
//       }
//    NSLog(@"sssid = %@",ssid);
    
    
}
-(void)_CSAnimationView{
    UIButton *btn1 = [[UIButton alloc]init];
    [btn1 setTitle:@"btn1" forState:UIControlStateNormal];
    btn1.backgroundColor = UIColor.orangeColor;
    [self.view addSubview:btn1];
    [btn1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(30);
        
    }];
    
    [btn1 ax_addTargetBlock:^(UIButton * _Nullable button) {
        
        CSAnimationView *animationView = [[CSAnimationView alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
        animationView.backgroundColor = [UIColor redColor];
        animationView.duration = 0.5;
        animationView.delay = 0;
        animationView.type = CSAnimationTypeFadeOutRight;
        [self.view addSubview:animationView];
        
        //添加你想增加效果的 View 为 animationView 的子视图
        // [animationView addSubview:<#(UIView *)#>]
        
        [animationView startCanvasAnimation];
        
    }];
}
-(void)_UITextView_link{
    
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
    [self.view addSubview:textView];
    [textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_offset(0);
        make.top.mas_offset(100);
    }];
    
    
    UILabel *label = UILabel.alloc.init;
    {
        NSString *str1 = @"点击“立即体验”按钮，\n即表示你同意";
        NSString *str3 = @"《许可及服务协议》";
        NSString *str = [NSString stringWithFormat:@"%@%@",str1,str3];
        NSRange range3 = [str rangeOfString:str3];
        
        NSMutableAttributedString *mastring = [[NSMutableAttributedString alloc] initWithString:str attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12],NSForegroundColorAttributeName: [UIColor blackColor]}];
        [mastring addAttributes:@{
            NSForegroundColorAttributeName:[UIColor redColor],
            NSUnderlineStyleAttributeName:@1
        } range:range3];
        label.attributedText =mastring;
        label.numberOfLines = 0;
        [self.view addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_offset(0);
            make.top.equalTo(textView.mas_bottom).mas_offset(20);
        }];
    }
    
    
}

- (BOOL)textView:(UITextView *)textView shouldInteractWithURL:(NSURL *)URL inRange:(NSRange)characterRange {
    
    if ([[URL scheme] isEqualToString:@"license"]) {
        
        NSString *titleString = [NSString stringWithFormat:@"你点击了第一个文字:%@",[URL host]];
        
        NSLog(@"%@",titleString);
        
        return NO;
        
    }
    return YES;
    
}


- (void)didMoveToParentViewController:(UIViewController *)parent {
    AXLogFunc;
}

-(void)_test1 {
    
    UIButton *btn1 = [[UIButton alloc]init];
    [btn1 setTitle:@"btn1" forState:UIControlStateNormal];
    btn1.backgroundColor = UIColor.orangeColor;
    [self.view addSubview:btn1];
    [btn1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(30);
        
    }];
    
    CGFloat width = 100;
    
    UIView *view1 = [[UIView alloc]init];
    [self.view addSubview:view1];
    view1.backgroundColor = UIColor.orangeColor;
    [view1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(30);
        make.top.equalTo(btn1.mas_bottom).mas_offset(50);
        make.height.mas_equalTo(100);
        
        self.viewBottomConstraint = make.width.mas_equalTo(width);
    }];
    
    
    __block typeof(width)weakWwidth = width;
    
    //    [btn1 ax_addTargetBlock:^(UIButton * _Nullable button) {
    //
    //
    //        [view1 mas_updateConstraints:^(MASConstraintMaker *make) {
    ////            make.left.mas_equalTo(30);
    ////            make.top.equalTo(btn1.mas_bottom).mas_offset(50);
    ////            make.height.mas_equalTo(100);
    //
    //            if (weakWwidth ==100) {
    //                weakWwidth =200;
    //            }else{
    //                weakWwidth = 100;
    //            }
    //            NSLog(@"weakWwidth %lf",weakWwidth);
    //            make.width.mas_equalTo(weakWwidth);
    //        }];
    //    }];
    
    __weak typeof(self) weakSelf = self;
    [btn1 ax_addTargetBlock:^(UIButton * _Nullable button) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        [strongSelf.viewBottomConstraint uninstall];
        
        //        [view1.superview setNeedsUpdateConstraints];
        //        [UIView animateWithDuration:1 animations:^{
        //            [view1 mas_makeConstraints:^(MASConstraintMaker *make) {
        //                make.right.mas_equalTo(-30);
        //
        //            }];
        //
        //            [view1.superview layoutIfNeeded];
        //        }];
        AXDateVC *vc = [[AXDateVC alloc]init];
        [strongSelf ax_showVC:vc];
        
        
    }];
    //
    //    UIDatePicker *picker = [[UIDatePicker alloc]initWithFrame:CGRectMake(0, 200, self.view.width, 150)];
    //
    //
    //
    //    picker.datePickerMode = UIDatePickerModeCountDownTimer;
    ////    picker.calendar = [NSCalendar currentCalendar];
    //    picker.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_GB"];
    ////    picker.timeZone =[NSTimeZone systemTimeZone];
    //
    //    picker.backgroundColor = UIColor.orangeColor;
    //    picker.tintColor = UIColor.redColor;
    //
    //    [self.view addSubview:picker];
    //
    //    UIImageView *view = [[UIImageView alloc]initWithFrame:CGRectMake(10, 200, 100, 100)];
    //    view.image = [UIImage imageNamed:@"exporte"];
    //    view.backgroundColor=[UIColor yellowColor];
    //    view.layer.masksToBounds=YES;
    //    view.layer.cornerRadius=10;
    //    view.layer.borderWidth = 1.5;
    //    view.layer.borderColor = [UIColor redColor].CGColor;;
    ////    view.layer.shadowColor=[UIColor redColor].CGColor;
    ////    view.layer.shadowOffset=CGSizeMake(10, 10);
    ////    view.layer.shadowOpacity=0.5;
    ////    view.layer.shadowRadius=5;
    //    [self.view addSubview:view];
    //
    //
    //    [view  ax_shadowWith:UIColor.redColor];
    //
    //
    //    NSMutableArray<UIView *> *aryy = [NSMutableArray array];
    //    UIView * _imgViewBgView = [UIView.alloc init];
    //    _imgViewBgView.layer.cornerRadius = 6;
    //    _imgViewBgView.backgroundColor = UIColor.blueColor;
    ////    _imgViewBgView.axis = UILayoutConstraintAxisHorizontal;
    ////    _imgViewBgView.alignment = UIStackViewAlignmentFill;
    ////    _imgViewBgView.spacing = 10;
    ////    _imgViewBgView.distribution = UIStackViewDistributionEqualCentering;
    //    [self.view addSubview:_imgViewBgView];
    //    [_imgViewBgView mas_makeConstraints:^(MASConstraintMaker *make) {
    //        make.left.mas_offset(20);
    //        make.right.bottom.mas_offset(-20);
    ////        make.height.mas_equalTo(300);
    //    }];
    //
    //
    //    for(int i=0;i<3;i++){
    //        UIImageView *imgView = [UIImageView.alloc init];
    //        imgView.layer.cornerRadius = 6;
    //        [_imgViewBgView addSubview:imgView];
    //        [aryy addObject:imgView];
    //        if (i==0) {
    //            imgView.backgroundColor = UIColor.greenColor;
    //        }else  if (i==1){
    //
    //            imgView.backgroundColor = UIColor.orangeColor;
    //        }else {
    //
    //            imgView.backgroundColor = UIColor.redColor;
    //        }
    //    }
    //
    //
    //    [aryy mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:15 leadSpacing:10 tailSpacing:10];
    ////    [aryy mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedItemLength:80 leadSpacing:10 tailSpacing:10];
    //
    //    [aryy mas_makeConstraints:^(MASConstraintMaker *make) {
    //        make.top.bottom.mas_equalTo(0);
    ////        make.height.mas_equalTo(150);
    //    }];
    //
    //    [_imgViewBgView mas_makeConstraints:^(MASConstraintMaker *make) {
    //
    //        make.bottom.equalTo(aryy.firstObject.mas_bottom);
    //    }];
    //
    
    //    UIView *bgView = [UIView.alloc init];
    //    [self.view addSubview:bgView];
    //    bgView.backgroundColor = UIColor.greenColor;
    //    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
    //        make.left.top.mas_offset(100);
    //        make.right.mas_offset(-100);
    //
    //    }];
    //
    //
    //
    //    UIImageView *contentImageView = UIImageView.alloc.init;
    //    [bgView addSubview:contentImageView];
    //    contentImageView.layer.cornerRadius = 6;
    //    contentImageView.layer.masksToBounds = YES;
    //    contentImageView.contentMode = 0;
    //    contentImageView.backgroundColor = UIColor.redColor;
    //    [contentImageView mas_makeConstraints:^(MASConstraintMaker *make) {
    //        make.left.top.mas_offset(20);
    //        make.right.mas_offset(-20);
    ////        make.width.equalTo(self.bgView).dividedBy(3);
    //        make.bottom.mas_offset(-20);
    //
    //    }];
    //
    //    [contentImageView sd_setImageWithURL:[NSURL URLWithString:@"https://bing.ioliu.cn/v1/rand?key=b0&w=200&h=300"] placeholderImage:[UIImage imageNamed:@"hot_load"]];
    
    //    UILabel *label = [UILabel.alloc initWithFrame:CGRectMake(100, 400, 100, 20)];
    //    [self.view addSubview:label];
    //    label.font = [UIFont systemFontOfSize:30];
    //    label.attributedText = [@"HH12KK" ax_smallerNumberWitSize:10];
    //
    //    [self configUI];
    
    
}


- (void)configUI{
    // 使用系统提供的按钮，要注意不支持系统版本的处理
    if (@available(iOS 13.0, *)) {
        // Sign In With Apple Button
        ASAuthorizationAppleIDButton *appleIDBtn = [ASAuthorizationAppleIDButton buttonWithType:ASAuthorizationAppleIDButtonTypeDefault style:ASAuthorizationAppleIDButtonStyleWhite];
        appleIDBtn.frame = CGRectMake(30, self.view.bounds.size.height - 180, self.view.bounds.size.width - 60, 100);
        //    appleBtn.cornerRadius = 22.f;
        [appleIDBtn addTarget:self action:@selector(didAppleIDBtnClicked) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:appleIDBtn];
    }
    
    // 或者自己用UIButton实现按钮样式
    UIButton *addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    addBtn.frame = CGRectMake(30, 80, self.view.bounds.size.width - 60, 44);
    addBtn.backgroundColor = [UIColor orangeColor];
    [addBtn setTitle:@"Sign in with Apple" forState:UIControlStateNormal];
    [addBtn addTarget:self action:@selector(didCustomBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:addBtn];
}

// 自己用UIButton按钮调用处理授权的方法
- (void)didCustomBtnClicked{
    // 封装Sign In with Apple 登录工具类，使用这个类时要把类对象设置为全局变量，或者直接把这个工具类做成单例，如果使用局部变量，和IAP支付工具类一样，会导致苹果回调不会执行
    //    self.signInApple = [[SignInApple alloc] init];
    //    [self.signInApple handleAuthorizationAppleIDButtonPress];
    
    if (@available(iOS 13.0, *)) {
        ASAuthorizationAppleIDProvider *appleIDProvider = [ASAuthorizationAppleIDProvider new];
        ASAuthorizationAppleIDRequest *request = appleIDProvider.createRequest;
        [request setRequestedScopes:@[ASAuthorizationScopeFullName,ASAuthorizationScopeEmail]];
    } else {
        // Fallback on earlier versions
    }
    
}
// 使用系统提供的按钮调用处理授权的方法
- (void)didAppleIDBtnClicked{
    // 封装Sign In with Apple 登录工具类，使用这个类时要把类对象设置为全局变量，或者直接把这个工具类做成单例，如果使用局部变量，和IAP支付工具类一样，会导致苹果回调不会执行
    //    self.signInApple = [[SignInApple alloc] init];
    //    [self.signInApple handleAuthorizationAppleIDButtonPress];
}

// 处理授权
- (void)handleAuthorizationAppleIDButtonPress{
    NSLog(@"////////");
    
    if (@available(iOS 13.0, *)) {
        // 基于用户的Apple ID授权用户，生成用户授权请求的一种机制
        ASAuthorizationAppleIDProvider *appleIDProvider = [[ASAuthorizationAppleIDProvider alloc] init];
        // 创建新的AppleID 授权请求
        ASAuthorizationAppleIDRequest *appleIDRequest = [appleIDProvider createRequest];
        // 在用户授权期间请求的联系信息
        appleIDRequest.requestedScopes = @[ASAuthorizationScopeFullName, ASAuthorizationScopeEmail];
        // 由ASAuthorizationAppleIDProvider创建的授权请求 管理授权请求的控制器
        ASAuthorizationController *authorizationController = [[ASAuthorizationController alloc] initWithAuthorizationRequests:@[appleIDRequest]];
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



@end
