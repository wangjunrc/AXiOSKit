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

#import <SDWebImage/UIImageView+WebCache.h>
#import <AuthenticationServices/AuthenticationServices.h>
#import <AXiOSKit/AXBiometryManager.h>

@interface _01ContentViewController ()
@property (nonatomic, strong) MASConstraint *viewBottomConstraint;

@property(nonatomic, strong) AXBiometryManager *manager;

@property(nonatomic, strong) UIPageControl *pageControl;
@end

@implementation _01ContentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    
    UIButton *btn1 = [[UIButton alloc]init];
    [btn1 setTitle:@"btn1" forState:UIControlStateNormal];
    btn1.backgroundColor = UIColor.orangeColor;
    [self.view addSubview:btn1];
    [btn1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(30);
        
    }];
    
    
    NSLog(@"=== %@",[self subStringWithEmoji:@"哈哈😝😝😝" limitLength:3]);
    
}


//截取字符前多少位，处理emoji表情问题
////🐒🐒🐒🐒 + 截取3 = 🐒🐒🐒
-(NSString *)subStringWithEmoji:(NSString *)emojiString
                    limitLength:(NSInteger)limitLength{
    if(emojiString.length < limitLength) return emojiString;
    
    @autoreleasepool {
        NSString * subStr = emojiString;
        NSRange  range;
        NSInteger index = 0;
        for(int i=0; i< emojiString.length; i += range.length){
            range = [emojiString rangeOfComposedCharacterSequenceAtIndex:i];
            NSString * charrrr = [emojiString substringToIndex:range.location + range.length];
            index ++;
            if(index == limitLength){
                subStr = charrrr;
                break;
            }
        }
        return subStr;
    }
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
    
    //    [btn1 ax_addActionBlock:^(UIButton * _Nullable button) {
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
    [btn1 ax_addActionBlock:^(UIButton * _Nullable button) {
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
    
    UILabel *label = [UILabel.alloc initWithFrame:CGRectMake(100, 400, 100, 20)];
    [self.view addSubview:label];
    label.font = [UIFont systemFontOfSize:30];
    label.attributedText = [@"HH12KK" ax_smallerNumberWitSize:10];
    
    [self configUI];
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
