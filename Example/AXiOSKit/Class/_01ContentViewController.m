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
#import <AXiOSKit/UITextField+AXNumberKeyboard.h>
#import <AXiOSKit/AXNumberKeyboardView.h>
#import <AuthenticationServices/AuthenticationServices.h>
#import <Canvas/Canvas.h>
#import <Masonry/Masonry.h>
#import <ReactiveObjC/ReactiveObjC.h>
#import <SDWebImage/UIImageView+WebCache.h>
#import <SystemConfiguration/CaptiveNetwork.h>
#import <UserNotifications/UserNotifications.h>
#import <GDataXML_HTML/GDataXMLNode.h>
//#import "AXiOSKit_Example-Swift.h"
#import <MJExtension/MJExtension.h>

#import <VisionKit/VisionKit.h>
#import <LLDynamicLaunchScreen/LLDynamicLaunchScreen.h>
#import "_09AFNViewController.h"
#import "AXSwitchView.h"
#import "AXXSwitch.h"
#import <AVKit/AVKit.h>
#import "AXIBudyButton.h"
#import "XWShadow.h"
#import "MakeKeyAndVisible.h"
@interface _01ContentViewController ()<UITextViewDelegate,UIViewControllerTransitioningDelegate, ASAuthorizationControllerDelegate, ASAuthorizationControllerPresentationContextProviding,VNDocumentCameraViewControllerDelegate>

@property (nonatomic, strong) UILabel *label;

@property (nonatomic, strong) AXBiometryManager *manager;

@property (nonatomic, strong) UIPageControl *pageControl;

@property (nonatomic, strong) AXLocationManager *locationManager;

@property (nonatomic, assign) NSInteger age;

@end

@implementation _01ContentViewController
//- (void)injected {
//    NSLog(@"重启了 InjectionIII: %@", self);
//    [self viewDidLoad];
//}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden = YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor =  UIColor.whiteColor;
    self.navigationItem.title = @"内容";//设置标题
    
    __weak typeof(self) weakSelf = self;
    
    self.containerView.backgroundColor = [UIColor ax_colorWithNormalStyle:UIColor.whiteColor];
    
    self.ax_controllerObserve.isPushed(^{
        NSLog(@"isPushed");
    }).isPresented(^{
        NSLog(@"isPresented");
    });
    if (@available(iOS 13.0, *)) {
        AXLoger(@"模式>> %ld", ax_keyWindow().overrideUserInterfaceStyle);
    }
    
    [self _darkStyle];
    
    [self _buttonTitle:@"push" handler:^(UIButton * _Nonnull btn) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        _01ContentViewController *vc = [_01ContentViewController ax_init];
        [strongSelf ax_pushVC:vc];
        vc.ax_controllerObserve.hiddenNavigationBar = NO;
    }];
    
    [self _buttonTitle:@"show" handler:^(UIButton * _Nonnull btn) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        _01ContentViewController *vc = [_01ContentViewController ax_init];
        [strongSelf ax_showVC:vc];
    }];
    
    [self _buttonTitle:@"Lookin_2D" handler:^(UIButton * _Nonnull btn) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"Lookin_2D" object:nil];
    }];
    
    [self _buttonTitle:@"dismis 或者 pop" handler:^(UIButton * _Nonnull btn) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        [strongSelf ax_haveNav:^(UINavigationController *nav) {
            [strongSelf.navigationController popViewControllerAnimated:YES];
        } isPushNav:^(UINavigationController *nav) {
            [strongSelf.navigationController dismissViewControllerAnimated:YES completion:nil];
        } isPresentNav:^(UINavigationController *nav) {
            [strongSelf dismissViewControllerAnimated:YES completion:nil];
        } noneNav:^{
            [strongSelf dismissViewControllerAnimated:YES completion:nil];
        }];
    }];
    
    [self _buttonTitle:@"dismissToRoot" handler:^(UIButton * _Nonnull btn) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        
        UIViewController *controller = strongSelf;
        
        while (controller.presentingViewController)
            controller = controller.presentingViewController;
        
        [controller dismissViewControllerAnimated:YES completion:nil];
    }];
    
    [self _buttonTitle:@"汽包" handler:^(UIButton * _Nonnull btn) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        [strongSelf _qipao:btn];
    }];
    
    
    [self _buttonTitle:@"PresentedViewController" handler:^(UIButton * _Nonnull btn) {
        UIViewController *topRootViewController = ax_keyWindow().rootViewController;// 在这里加一个这个样式的循环
        while (topRootViewController.presentedViewController) // 这里固定写法
            topRootViewController = topRootViewController.presentedViewController; _01ContentViewController *vc = _01ContentViewController.alloc.init;
        ///然后再进行present操作
        [topRootViewController presentViewController:vc animated:YES completion:nil];
    }];
    
    [self _buttonTitle:@"popToRoot" handler:^(UIButton * _Nonnull btn) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        [strongSelf.navigationController popToRootViewControllerAnimated:YES];
    }];
    
    /// 可以禁止侧滑返回,但是无法禁止代码直接返回
    [self _buttonTitle:@"隐藏返回按钮" handler:^(UIButton * _Nonnull btn) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        [strongSelf.navigationItem setHidesBackButton:!strongSelf.navigationItem.hidesBackButton animated:YES];
    }];
    [self _buttonTitle:@"隐藏返回按钮 代码返回" handler:^(UIButton * _Nonnull btn) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        if (!strongSelf.navigationItem.hidesBackButton) {
            [strongSelf.navigationController popViewControllerAnimated:YES];
        }
    }];
    [self _p00Test_layer];
    [self _p00TestSwitch ];
    [self _p00AIBudyButton];
    [self _p01TextAndImage];
    [self _p01UITextView_link];
    [self _p01TextField];
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
    /// 会弹出 "想要查找并连接到本地网络上的设备" 弹窗
    [self _buttonTitle:@"NSProcessInfo" handler:^(UIButton * _Nonnull btn) {
        NSString *uuid1 = [[NSProcessInfo processInfo] globallyUniqueString];
        
        NSLog(@"processInfoww = %@", [NSProcessInfo.processInfo mj_JSONObject]);
        
        NSLog(@"uuid1 = %@", uuid1);
        NSLog(@"uuid2 = %@", [NSString ax_uuid]);
    }];
    
    [self _buttonTitle:@"_01ContentViewController" handler:^(UIButton * _Nonnull btn) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        _01ContentViewController *vc = [[_01ContentViewController alloc]init];
        [strongSelf.navigationController pushViewController:vc animated:YES];
    }];
    
    [self _buttonTitle:@"popToRootViewControllerAnimated" handler:^(UIButton * _Nonnull btn) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        [strongSelf.navigationController popToRootViewControllerAnimated:YES];
    }];
    [self _p17CSAnimationView];
    [self _p18appleLogin];
    
    [self _buttonTitle:@"系统时间" handler:^(UIButton * _Nonnull btn) {
        NSLog(@"CACurrentMediaTime :%f", CACurrentMediaTime());
        NSLog(@"NSProcessInfo :%f", [[NSProcessInfo processInfo] systemUptime]);
        NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:CACurrentMediaTime()];
        NSLog(@"confromTimesp = %@", confromTimesp);
    }];
    [self _p19VisionKit];
    
    //    UIImage *image = [UIImage imageNamed:@"launch_image"];
    //    self.containerView.layer.contents = (id)image.CGImage;
    [self _p20changeLanch];
    [self _p21stackView];
    
    [self _p23changeLanguages];
    
    /// 底部约束
    [self _loadBottomAttribute];
}

- (void)_darkStyle {
    CGFloat all_height = 50;
    [self _buttonTitle:@"改变模式" handler:^(UIButton * _Nonnull btn) {
        if (@available(iOS 13.0, *)) {
            ax_keyWindow().overrideUserInterfaceStyle = (ax_keyWindow().overrideUserInterfaceStyle != UIUserInterfaceStyleDark) ? UIUserInterfaceStyleDark : UIUserInterfaceStyleLight;
        }
    }];
    
    {
        UILabel *label = [[UILabel alloc] init];
        [self.containerView addSubview:label];
        label.backgroundColor = UIColor.blueColor;
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.bottomAttribute).mas_equalTo(20);
            make.left.mas_equalTo(10);
            make.right.mas_equalTo(-10);
        }];
        self.bottomAttribute = label.mas_bottom;
        if (@available(iOS 13.0, *)) {
            NSString *text = @"暂无";
            switch (ax_keyWindow().overrideUserInterfaceStyle) {
                case UIUserInterfaceStyleUnspecified:
                    text = @"模式 Unspecified";
                    break;
                case UIUserInterfaceStyleLight:
                    text = @"模式 Light";
                    break;
                case UIUserInterfaceStyleDark:
                    text = @"模式 Dark";
                    break;
                default:
                    break;
            }
            label.text = text;
        } else {
            label.text = @"不支持模式";
        }
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = [UIColor ax_colorWithNormalStyle:UIColor.greenColor darkStyle:UIColor.systemRedColor];
        label.layer.cornerRadius = 5;
        label.layer.masksToBounds = YES;
        self.label = label;
    }
    
    {
        UIImageView *imv = [[UIImageView alloc] init];
        imv.image = [UIImage imageNamed:@"ax_icon_weixin"];
        [self.containerView addSubview:imv];
        [imv mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.bottomAttribute).mas_equalTo(20);
            make.width.height.mas_equalTo(all_height);
            make.centerX.mas_equalTo(0);
        }];
        self.bottomAttribute = imv.mas_bottom;
    }
}

- (void)_bottomView {
    UIView *bottomView = [UIView ax_init];
    [self.containerView addSubview:bottomView];
    bottomView.backgroundColor = UIColor.orangeColor;
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(50 + ax_safe_area_insets_bottom_offset(0));
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

- (void)_kvoInt {
    __weak typeof(self) weakSelf = self;
    [RACObserve(self, age) subscribeNext:^(id _Nullable x) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        NSLog(@"age = %ld %@", strongSelf.age, x);
    }];
    
    [self ax_addFBKVOKeyPath:AX_FBKVOKeyPath(self.age) result:^(AXKVOResultModel *_Nonnull resultModel) {
        NSLog(@"age222 = %ld %@", self.age, resultModel.aNewValue);
    }];
    
    UIButton *btn1 = [[UIButton alloc]init];
    [btn1 setTitle:@"kvoInt" forState:UIControlStateNormal];
    btn1.backgroundColor = UIColor.orangeColor;
    [self.containerView addSubview:btn1];
    [btn1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(30);
    }];
    
    [btn1 ax_addTargetBlock:^(UIButton *_Nullable button) {
        self.age = ax_randomZeroToValue(100);
    }];
}

- (void)_p01TextField {
    {
        
        UITextField *keyboarTF = [[UITextField alloc]init];
        keyboarTF.placeholder = @"自定义键盘";
        [self.containerView addSubview:keyboarTF];
        [keyboarTF mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.bottomAttribute).mas_offset(20);
            make.left.mas_equalTo(10);
            make.right.mas_equalTo(-10);
            make.height.mas_equalTo(50);
        }];
        
        self.bottomAttribute = keyboarTF.mas_bottom;
        
        
        AXNumberKeyboardConfig *config = AXNumberKeyboardConfig.alloc.init;
        config.textInput = keyboarTF;
        config.inputType = AXNumberKeyboardTypeFloat;
        config.inputType = AXNumberKeyboardTypeIDCard;
        
        AXNumberKeyboardView *inputView = [[AXNumberKeyboardView alloc] initWithConfig:config];
        inputView.handler = ^{
            
        };
        //        inputView.textInput = keyboarTF;
        //        inputView.inputType = AXNumberKeyboardTypeIDCard;
        //        inputView.inputType = AXNumberKeyboardTypeFloat;
        keyboarTF.inputView = inputView;
        
        [self _buttonTitle:@"切换系统键盘" handler:^(UIButton * _Nonnull btn) {
            //
            keyboarTF.inputView = nil;
            [keyboarTF reloadInputViews];
        }];
        
        [self _buttonTitle:@"切换自定义键盘" handler:^(UIButton * _Nonnull btn) {
            keyboarTF.inputView = inputView;
            [keyboarTF reloadInputViews];
        }];
        
        
    }
    UITextField *nameTF = [[UITextField alloc]init];
    nameTF.ax_observe.maxTextLength = 2;
    
    nameTF.backgroundColor = UIColor.orangeColor;
    nameTF.autocapitalizationType = UITextAutocapitalizationTypeNone;
    nameTF.keyboardType = UIKeyboardTypeASCIICapable;
    nameTF.tag = -100;
    nameTF.placeholder = @"输入姓名";
    nameTF.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"输入姓名" attributes:@{ NSForegroundColorAttributeName: [UIColor redColor] }];
    
    nameTF.accessibilityIdentifier = @"nameTextField";
    [self.containerView addSubview:nameTF];
    [nameTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bottomAttribute).mas_offset(20);
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(-10);
        make.height.mas_equalTo(50);
    }];
    [NSNotificationCenter.defaultCenter addObserver:self
                                           selector:@selector(textFiledEditChanged:)
                                               name:UITextFieldTextDidChangeNotification
                                             object:nameTF];
    
    [nameTF addTarget:self action:@selector(editChange:) forControlEvents:UIControlEventEditingChanged];
    
    self.bottomAttribute = nameTF.mas_bottom;
    
    [self _buttonTitle:@"恢复键盘" handler:^(UIButton * _Nonnull btn) {
        [nameTF reloadInputViews];
    }];
    
    {
        UITextField *pswTF = [[UITextField alloc]init];
        pswTF.backgroundColor = UIColor.orangeColor;
        //        nameTF.placeholder = @"输入密码";
        pswTF.secureTextEntry = YES;
        pswTF.accessibilityIdentifier = @"pwdTextField";
        pswTF.enabled = NO;
        //        nameTF.hidden = YES;
        [self.containerView addSubview:pswTF];
        [pswTF mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.bottomAttribute).mas_equalTo(10);
            make.left.mas_equalTo(10);
            make.right.mas_equalTo(-10);
            make.height.mas_equalTo(50);
            //            make.height.mas_equalTo(1.0);
        }];
        self.bottomAttribute = pswTF.mas_bottom;
    }
}

#define kMaxLength 6

- (void)editChange:(UITextField *)textfield {
    NSString *toBeString = textfield.text;
    NSString *lang = [[UIApplication sharedApplication]textInputMode].primaryLanguage; // 键盘输入模
    NSLog(@"lang = %@", lang);
    if ([lang isEqualToString:@"zh-Hans"]) { // 简体中文输入，包括简体拼音，健体五笔，简体手写
        UITextRange *selectedRange = [textfield markedTextRange];
        //获取高亮部分
        UITextPosition *position = [textfield positionFromPosition:selectedRange.start offset:0];
        // 没有高亮选择的字，则对已输入的文字进行字数统计和限制
        if (!position) {
            if (toBeString.length > kMaxLength) {
                NSRange rangeIndex = [toBeString rangeOfComposedCharacterSequenceAtIndex:kMaxLength];
                if (rangeIndex.length == 1) {
                    textfield.text = [toBeString substringToIndex:kMaxLength];
                } else {
                    NSRange rangeRange = [toBeString rangeOfComposedCharacterSequencesForRange:NSMakeRange(0, kMaxLength)];
                    textfield.text = [toBeString substringWithRange:rangeRange];
                }
            }
        }
    }
    // 中文输入法以外的直接对其统计限制即可，不考虑其他语种情况
    else {
        if (toBeString.length > kMaxLength) {
            NSRange rangeIndex = [toBeString rangeOfComposedCharacterSequenceAtIndex:kMaxLength];
            if (rangeIndex.length == 1) {
                textfield.text = [toBeString substringToIndex:kMaxLength];
            } else {
                NSRange rangeRange = [toBeString rangeOfComposedCharacterSequencesForRange:NSMakeRange(0, kMaxLength)];
                textfield.text = [toBeString substringWithRange:rangeRange];
            }
        }
    }
}

- (void)textFiledEditChanged:(NSNotification *)notification {
    UITextField *textField = notification.object;
    
    if (!textField) {
        return;
    }
    //    NSString*str = textField.text;
    /// 屏蔽中文
    //    for (int i = 0; i<str.length; i++)
    //
    //    {
    //
    //        NSString*string = [str substringFromIndex:i];
    //
    //        NSString *regex = @"[\u4e00-\u9fa5]{0,}$"; // 中文
    //
    //        // 2、拼接谓词
    //
    //        NSPredicate *predicateRe1 = [NSPredicate predicateWithFormat:@"self matches %@", regex];
    //
    //        // 3、匹配字符串
    //
    //        BOOL resualt = [predicateRe1 evaluateWithObject:string];
    //
    //
    //
    //        if (resualt)
    //
    //        {
    //
    //　　　　//是中文替换为空字符串
    //
    //            str =  [str stringByReplacingOccurrencesOfString:[str substringFromIndex:i] withString:@""];
    //        }
    //
    //    }
    //
    //    textField.text = str;
    
    ///判断是否正在输入拼音，高亮状态
    UITextRange *selectedRange = [textField markedTextRange];
    
    //获取高亮部分
    
    UITextPosition *position = [textField positionFromPosition:selectedRange.start offset:0];
    
    // 没有高亮选择的字，说明不是拼音输入
    
    if (!position) {
        NSString *upperCaseString = [textField.text uppercaseString];
        
        textField.text = upperCaseString;
    } else {// 有高亮选择的字符串，不做处理
    }
}

- (void)_p00Test_layer {
    UILabel *label = UILabel.alloc.init;
    label.text = @"代码就可以避免离屏渲染";
    
    [self.containerView addSubview:label];
    
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bottomAttribute).mas_offset(10);
        make.centerX.mas_equalTo(0);
    }];
    self.bottomAttribute = label.mas_bottom;
    
    UIView *aView = UIView.alloc.init;
    aView.backgroundColor = UIColor.redColor;
    [self.containerView addSubview:aView];
    
    aView.layer.cornerRadius = 4;
    aView.layer.shadowColor = [UIColor blackColor].CGColor;//shadowColor阴影颜色
    aView.layer.shadowOffset = CGSizeMake(0, 0);//shadowOffset阴影偏移,x向右偏移2，y向下偏移6，默认(0, -3),这个跟shadowRadius配合使用
    aView.layer.shadowOpacity = 0.3;//阴影透明度，默认0
    aView.layer.shadowRadius = 4;//阴影半径，默认3
    
    [aView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bottomAttribute).mas_offset(10);
        make.centerX.mas_equalTo(0);
        make.width.height.mas_equalTo(50);
    }];
    /// 立即得到尺寸
    [aView layoutIfNeeded];
    
    aView.layer.shadowPath = [UIBezierPath bezierPathWithRoundedRect:aView.bounds byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(aView.layer.cornerRadius, aView.layer.cornerRadius)].CGPath;//参数依次为大小，设置四个角圆角状态，圆角曲度  设置阴影路径可避免离屏渲染
    
    self.bottomAttribute = aView.mas_bottom;
}

- (void)_p00TestSwitch  {
    UISwitch *aSwitch = UISwitch.alloc.init;
    aSwitch.onTintColor = UIColor.redColor;
    aSwitch.thumbTintColor = UIColor.orangeColor;
    
    [self.containerView addSubview:aSwitch];
    //
    //    aSwitch.transform = CGAffineTransformMakeScale( 10, 10.0);
    
    //    [aSwitch.widthAnchor constraintEqualToConstant:200].active =YES;
    //    [aSwitch.heightAnchor constraintEqualToConstant:200].active =YES;
    
    [aSwitch mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bottomAttribute).mas_offset(10);
        make.centerX.mas_equalTo(0);
        //        make.width.mas_equalTo(200);
        //        make.height.mas_equalTo(60);
    }];
    
    self.bottomAttribute = aSwitch.mas_bottom;
    
    
    AXSwitchView *aS = [AXSwitchView.alloc init];
    //    aS.transform = CGAffineTransformRotate(aS.transform, -M_PI_2);
    
    
    //    aS.backgroundColor = UIColor.greenColor;
    //    aS.frame = CGRectMake(0, 400, 30, 30);
    [self.containerView addSubview:aS];
    NSLog(@"didMoveToSuperview =containerView %p",self.containerView);
    [aS mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bottomAttribute).mas_offset(10);
        make.centerX.mas_equalTo(0);
        make.width.mas_equalTo(30);
        make.height.mas_equalTo(30);
    }];
    self.bottomAttribute = aS.mas_bottom;
    
}
// iOS——实现点击人体部位响应

- (void)_p00AIBudyButton  {
    AXIBudyButton *btn = AXIBudyButton.alloc.init;
    [self.containerView addSubview:btn];
    [btn setTitle:@"非白色触发事件,白色不触发" forState:UIControlStateNormal];
    [btn setTitleColor:UIColor.redColor forState:UIControlStateNormal];
    btn.backgroundColor = UIColor.orangeColor;
    [btn setBackgroundImage:[UIImage imageNamed:@"children_body"] forState:UIControlStateNormal];
    btn.contentVerticalAlignment = UIControlContentVerticalAlignmentFill;//垂直方向拉伸
    btn.contentHorizontalAlignment= UIControlContentHorizontalAlignmentFill;//水平方向拉伸
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bottomAttribute).mas_offset(10);
        make.centerX.mas_equalTo(0);
        make.width.mas_equalTo(300);
        make.height.mas_equalTo(300);
    }];
    
    self.bottomAttribute = btn.mas_bottom;
    
    
}
- (void)_p01TextAndImage {
    NSString *title = @"图文混排";
    NSMutableAttributedString *titleAtt = [[NSMutableAttributedString alloc] initWithString:title];
    [titleAtt addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, title.length)];
    [titleAtt addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12] range:NSMakeRange(0, title.length)];
    {
        // 创建图片图片附件
        NSTextAttachment *attach = [[NSTextAttachment alloc] init];
        if (@available(iOS 13.0, *)) {
            attach.image = [[UIImage systemImageNamed:@"sun.max.fill"] imageWithTintColor:UIColor.greenColor];
        }
        
        attach.bounds = CGRectMake(0, 0, 50, 50);
        NSMutableAttributedString *attachString =   [NSMutableAttributedString attributedStringWithAttachment:attach].mutableCopy;
        [titleAtt appendAttributedString:attachString];
    }
    
    {
        NSString *str = @"结尾";
        NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:str];
        [attStr addAttribute:NSForegroundColorAttributeName value:[UIColor orangeColor] range:NSMakeRange(0, str.length)];
        [attStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12] range:NSMakeRange(0, str.length)];
        [titleAtt appendAttributedString:attStr];
    }
    
    UILabel *lable = [UILabel.alloc init];
    [self.containerView addSubview:lable];
    [lable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bottomAttribute).mas_offset(10);
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(-10);
    }];
    lable.attributedText = titleAtt;
    
    self.bottomAttribute = lable.mas_bottom;
}

- (void)_p01UITextView_link {
    NSString *str1 = @"点击“立即体验”按钮，\n即表示你同意";
    NSString *str3 = @"《许可及服务协议》";
    NSString *str = [NSString stringWithFormat:@"%@%@", str1, str3];
    NSRange range3 = [str rangeOfString:str3];
    
    NSMutableAttributedString *mastring = [[NSMutableAttributedString alloc] initWithString:str attributes:@{ NSFontAttributeName: [UIFont systemFontOfSize:12], NSForegroundColorAttributeName: [UIColor blackColor] }];
    
    [mastring addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:range3];
    NSString *link = [[NSString stringWithFormat:@"license://%@", str3] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]];
    /// 这里修改UITextView链接字体颜色无效
    [mastring addAttribute:NSLinkAttributeName value:link range:range3];
    
    UITextView *textView = [[UITextView alloc] init];
    textView.editable = NO;
    textView.scrollEnabled = NO;
    textView.delegate = self;
    textView.attributedText = mastring;
    textView.textAlignment = NSTextAlignmentCenter;
    textView.backgroundColor = UIColor.clearColor;
    /// 链接字体颜色
    textView.linkTextAttributes = @{ NSForegroundColorAttributeName: [UIColor redColor], NSUnderlineStyleAttributeName: @1 };
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
        NSString *titleString = [NSString stringWithFormat:@"你点击了第一个文字:%@", [URL host]];
        
        NSLog(@"%@", titleString);
        
        return NO;
    }
    return YES;
}

- (void)_p02AlternateIconName {
    __weak typeof(self) weakSelf = self;
    [self _buttonTitle:@"换icon" handler:^(UIButton * _Nonnull btn) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        [strongSelf setIconname:@"Alternate_AppIcon_2"];
    }];
    [self _buttonTitle:@"换icon-还原" handler:^(UIButton * _Nonnull btn) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        [strongSelf setIconname:nil];
    }];
}

- (void)setIconname:(NSString *)name {
    //    UIApplication *appli = [UIApplication sharedApplication];
    //    //判断系统是否支持切换icon
    //    if (@available(iOS 10.3, *)) {
    //        if ([appli supportsAlternateIcons]) {
    //            //切换icon
    //            [appli setAlternateIconName:name completionHandler:^(NSError *_Nullable error) {
    //                if (error) {
    //                    NSLog(@"error==> %@", error.localizedDescription);
    //                } else {
    //                    NSLog(@"done!!!");
    //                }
    //            }];
    //        }
    //    } else {
    //        // Fallback on earlier versions
    //    }
    
    
    
    if ([[UIApplication sharedApplication] respondsToSelector:@selector(supportsAlternateIcons)] &&
        [[UIApplication sharedApplication] supportsAlternateIcons])
    {
        NSMutableString *selectorString = [[NSMutableString alloc] initWithCapacity:40];
        [selectorString appendString:@"_setAlternate"];
        [selectorString appendString:@"IconName:"];
        [selectorString appendString:@"completionHandler:"];
        
        SEL selector = NSSelectorFromString(selectorString);
        IMP imp = [[UIApplication sharedApplication] methodForSelector:selector];
        void (*func)(id, SEL, id, id) = (void *)imp;
        if (func)
        {
            func([UIApplication sharedApplication], selector, name, ^(NSError * _Nullable error) {});
        }
    }
    
    
    
}

- (void)_p03LocationManager {
    __weak typeof(self) weakSelf = self;
    return [self _buttonTitle:@"定位" handler:^(UIButton * _Nonnull btn) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        strongSelf.locationManager =   [AXLocationManager managerWithState:AXLocationStateWhenInUseAuthorization result:^(BOOL resultState, CLLocation *location) {
            NSLog(@"定位 = %@", location);
        }];
    }];
}

- (void)_p03wifi {
    __weak typeof(self) weakSelf = self;
    return [self _buttonTitle:@"wifi信息" handler:^(UIButton * _Nonnull btn) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        [strongSelf _WiFi];
    }];
}

- (void)_p03textToImg {
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

- (void)_p04masron_uninstall {
    CGFloat width = 100;
    __block MASConstraint *viewWidthConstraint = nil;
    __block MASConstraint *viewRightConstraint = nil;
    __weak typeof(self) weakSelf = self;
    UILabel *label1 = [[UILabel alloc]init];
    label1.text = @"默认宽度30";
    [self.containerView addSubview:label1];
    label1.backgroundColor = UIColor.orangeColor;
    [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bottomAttribute).mas_equalTo(10);
        make.left.mas_equalTo(30);
        make.height.mas_equalTo(100);
        viewWidthConstraint = make.width.mas_equalTo(width);
    }];
    self.bottomAttribute = label1.mas_bottom;
    //    [label1 ax_addLineDirection:AXLineDirectionTop color:UIColor.redColor height:2];
    {
        UILabel *label2 = [[UILabel alloc]init];
        label2.text = @"和上面宽度一样";
        
        [self.containerView addSubview:label2];
        label2.backgroundColor = UIColor.orangeColor;
        [label2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.bottomAttribute).mas_equalTo(10);
            make.left.mas_equalTo(30);
            make.height.mas_equalTo(100);
            
            make.width.equalTo(label1).priorityLow();
            //            make.width.mas_equalTo(width+50).priorityHigh();
            
            //            make.width.equalTo(label1);
            
            make.width.mas_lessThanOrEqualTo(width + 50);
        }];
        //        label2.preferredMaxLayoutWidth = width+50;
        //        [label2 setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
        self.bottomAttribute = label2.mas_bottom;
    }
    
    [self _buttonTitle:@"04-masron - uninstall - 加大" handler:^(UIButton * _Nonnull btn) {
        [viewWidthConstraint uninstall];
        [label1.superview setNeedsUpdateConstraints];
        [UIView animateWithDuration:1 animations:^{
            [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
                viewRightConstraint =  make.right.mas_equalTo(-30);
            }];
            [label1.superview layoutIfNeeded];
        }];
    }];
    
    [self _buttonTitle:@"04-masron - uninstall - 减小" handler:^(UIButton * _Nonnull btn) {
        [viewRightConstraint uninstall];
        //        [label1.superview setNeedsUpdateConstraints];
        [UIView animateWithDuration:1 animations:^{
            [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
                make.width.mas_equalTo(100);
            }];
            [label1.superview layoutIfNeeded];
        }];
    }];
    
    [self _buttonTitle:@"04-masron动画 -加大" handler:^(UIButton * _Nonnull btn) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        //        [label1.superview layoutIfNeeded];
        [strongSelf.view setNeedsUpdateConstraints];
        [UIView animateWithDuration:1 animations:^{
            [label1 mas_updateConstraints:^(MASConstraintMaker *make) {
                make.width.mas_equalTo(300);
            }];
            //            viewWidthConstraint.mas_equalTo(300);
            [label1.superview layoutIfNeeded];
        }];
    }];
    
    [self _buttonTitle:@"04-masron动画 - 减小" handler:^(UIButton * _Nonnull btn) {
        //        [label1.superview layoutIfNeeded];
        __strong typeof(weakSelf) strongSelf = weakSelf;
        [strongSelf.view setNeedsUpdateConstraints];
        [UIView animateWithDuration:1 animations:^{
            [label1 mas_updateConstraints:^(MASConstraintMaker *make) {
                make.width.mas_equalTo(100);
            }];
            //            viewWidthConstraint.mas_equalTo(100);
            [label1.superview layoutIfNeeded];
        }];
    }];
}

- (void)_p05DateVC {
    __weak typeof(self) weakSelf = self;
    return [self _buttonTitle:@"date" handler:^(UIButton * _Nonnull btn) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        AXDateVC *vc = [[AXDateVC alloc]init];
        [strongSelf ax_showVC:vc];
    }];
}

- (void)_p06per {
    //    __weak typeof(self) weakSelf = self;
    return [self _buttonTitle:@"奔溃拦截" handler:^(UIButton * _Nonnull btn) {
        //        __strong typeof(weakSelf) strongSelf = weakSelf;
        //        [self performSelector:@selector(test:age:age2:) withObjects:@[@"JIM",@"20"]];
        //        id obj =[self performSelector:@selector(application:didFinishLaunchingWithOptions:) withObjects:@[@"JIM",@"20"]];
        //        NSLog(@"obj = %@",obj);
        NSMutableArray *array = [NSMutableArray array];
        [array addObject:nil];
    }];
}

- (void)_p07bubbleImage {
    //leftCapWidth: 左边不拉伸的像素
    //topCapHeight:上边不拉伸的像素
    UIImage *image = [UIImage imageNamed:@"chat_bubble"];
    UIImageView *imgView = [[UIImageView alloc] initWithImage:[image stretchableImageWithLeftCapWidth:30 topCapHeight:30]];
    
    [self.containerView addSubview:imgView];
    [imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bottomAttribute).mas_equalTo(10);
        make.left.mas_equalTo(30);
        make.right.mas_equalTo(-30);
    }];
    
    self.bottomAttribute = imgView.mas_bottom;
}

- (void)_p08china {
    __weak typeof(self) weakSelf = self;
    return [self _buttonTitle:@"中英文排序" handler:^(UIButton * _Nonnull btn) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        [strongSelf _chinaText];
    }];
}

- (void)_chinaText {
    //模拟后台返回数据
    NSArray *array1 = @[@"陕西", @"山东", @"上海", @"内蒙古", @"新疆", @"西藏", @"北京", @"安徽", @"重庆", @"湖北", @"江苏", @"浙江", @"天津", @"California", @"贵州", @"云南", @"广东", @"甘肃", @"青海", @"宁夏", @"黑龙江", @"辽宁", @"吉林", @"江西", @"LosAngels", @"OKC", @"GSW"];
    
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
            NSMutableArray *mCityArray = mDic[firstLetter];
            if (mCityArray) {
                [mCityArray addObject:city];
                mDic[firstLetter] = mCityArray;
            } else {
                mDic[firstLetter] = [NSMutableArray arrayWithArray:@[city]];
            }
        } else {
            [mDic setObject:[NSMutableArray arrayWithArray:@[city]] forKey:firstLetter];
        }
    }
    //获取索引栏数据 获得字母
    NSArray *titlesArray = [self reqDiction:mDic];
    
    NSLog(@"mDic %@", mDic.allValues);
    NSLog(@"titlesArray %@", titlesArray);
}

- (void)_p09lineSpacing {
    {
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
        
        [self _buttonTitle:@"kvc修改间距" handler:^(UIButton * _Nonnull btn) {
            [label setValue:@40 forKey:@"lineSpacing"];
        }];
    }
    
    {
        UILabel *label = UILabel.ax_init;
        NSString *text = @"横向文字";
        
        NSRange range = NSMakeRange(0,  text.length);
        NSMutableAttributedString *mAttStr = [[NSMutableAttributedString alloc] initWithString:text];
        
        [mAttStr addAttributes:@{
            NSVerticalGlyphFormAttributeName: @1
        } range:range];
        
        label.attributedText = mAttStr;
        
        label.backgroundColor = UIColor.orangeColor;
        [self.containerView addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.bottomAttribute).mas_offset(10);
            make.left.mas_equalTo(10);
            make.right.mas_equalTo(-10);
        }];
        self.bottomAttribute = label.mas_bottom;
        [self _buttonTitle:@"kvc修改方向距" handler:^(UIButton * _Nonnull btn) {
            NSRange range = [label.text rangeOfString:label.text];
            NSMutableAttributedString *mAttStr = [[NSMutableAttributedString alloc] initWithString:label.text];
            
            [mAttStr addAttributes:@{
                NSVerticalGlyphFormAttributeName: @1
            } range:range];
            
            label.attributedText = mAttStr;
        }];
    }
}

- (void)_p10flieExist {
    return [self _buttonTitle:@"字符串是否包含另一字符串,不区分大小写" handler:^(UIButton * _Nonnull btn) {
        NSString *string = @"HelloChina";
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
        NSLog(@"b = %d", b);
    }];
}

- (void)_p11ButtonAllEvent {
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

- (void)_p12memoryUsage {
    UILabel *label = UILabel.ax_init;
    [self.containerView addSubview:label];
    label.textColor = UIColor.blackColor;
    label.text = [NSString stringWithFormat:@"%lf/MB", [UIDevice ax_memoryUsage] / 1024.0 / 1024.0];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bottomAttribute).mas_equalTo(20);
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(-10);
    }];
    self.bottomAttribute = label.mas_bottom;
}

- (void)_p12memoryUsage2 {
    UILabel *label = UILabel.ax_init;
    [self.containerView addSubview:label];
    label.textColor = UIColor.blackColor;
    label.text = [NSString stringWithFormat:@"%lfMB", [UIDevice ax_memoryUsage2] / 1024.0 / 1024.0];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bottomAttribute).mas_equalTo(20);
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(-10);
    }];
    self.bottomAttribute = label.mas_bottom;
}

- (void)_p12memoryUsage3 {
    UILabel *label = UILabel.ax_init;
    [self.containerView addSubview:label];
    label.textColor = UIColor.blackColor;
    label.text = [NSString stringWithFormat:@"%lfMB", [UIDevice ax_memoryUsage3] / 1024.0 / 1024.];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bottomAttribute).mas_equalTo(20);
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(-10);
    }];
    self.bottomAttribute = label.mas_bottom;
}

- (void)_p13MoreAlter {
    __weak typeof(self) weakSelf = self;
    return [self _buttonTitle:@"多个alert" handler:^(UIButton * _Nonnull btn) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        // 第一个UIAlertController
        UIAlertController *alertController1 = [UIAlertController alertControllerWithTitle:@"测试1" message:@"测试1" preferredStyle:UIAlertControllerStyleAlert];
        [alertController1 addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *_Nonnull action) {
        }]];
        [alertController1 addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *_Nonnull action) {
        }]];
        [strongSelf presentViewController:alertController1 animated:YES completion:nil];
        
        // 第二个UIAlertController
        UIAlertController *alertController2 = [UIAlertController alertControllerWithTitle:@"测试2" message:@"测试2" preferredStyle:UIAlertControllerStyleAlert];
        [alertController2 addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *_Nonnull action) {
        }]];
        [alertController2 addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *_Nonnull action) {
        }]];
        /// UIAlertController
        [alertController1 presentViewController:alertController2 animated:YES completion:nil];
    }];
}

- (void)_p14xmlToObj {
    //    __weak typeof(self) weakSelf = self;
    return [self _buttonTitle:@"xml解析" handler:^(UIButton * _Nonnull btn) {
        //        __strong typeof(weakSelf) strongSelf = weakSelf;
        
        NSString *path = [[NSBundle mainBundle]pathForResource:@"testXML" ofType:@"xml"];
        GDataXMLDocument *document = [[GDataXMLDocument alloc] initWithData:[NSData dataWithContentsOfFile:path] encoding:NSUTF8StringEncoding error:NULL];
        NSLog(@"attributes = %@", document.rootElement.attributes);
        
        /// 这一层是 xmlns
        for (GDataXMLElement *element in document.rootElement.attributes) {
            NSLog(@"attributes node.name = %@----node.stringValue = %@", element.name, element.stringValue);
        }
        /// 这一层是 body
        for (GDataXMLElement *element in document.rootElement.children) {
            NSLog(@"element.attributes = %@", element.attributes);
            NSLog(@"children node.name = %@----node.stringValue = %@", element.name, element.stringValue);
            ///再解析一下 properties
            
            for (GDataXMLElement *node in element.children) {
                NSLog(@"node.name = %@----node.stringValue = %@", node.name, node.stringValue);
                
                //                        [video setValue:node.stringValue forKeyPath:node.name];
            }
            for (GDataXMLNode *att in element.attributes) {
                NSLog(@"att.stringValue = %@", att.stringValue);
            }
        }
    }];
}

- (NSArray *)getOrderArraywithArray:(NSArray *)array {
    //数组排序
    //定义一个数字数组
    //对数组进行排序
    NSArray *result = [array sortedArrayUsingComparator:^NSComparisonResult (id _Nonnull obj1, id _Nonnull obj2) {
        return [obj1 compare:obj2]; //升序
    }];
    return result;
}

- (NSArray *)reqDiction:(NSDictionary *)dict {
    NSArray *allKeyArray = [dict allKeys];
    NSArray *afterSortKeyArray = [allKeyArray sortedArrayUsingComparator:^NSComparisonResult (id _Nonnull obj1, id _Nonnull obj2) {
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

- (void)_WiFi {
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
    NSLog(@"wifi ssid:%@ \nssid:%@", ssid, bssid);
}

- (void)_p17CSAnimationView {
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
    
    [btn1 ax_addTargetBlock:^(UIButton *_Nullable button) {
        //添加你想增加效果的 View 为 animationView 的子视图
        // [animationView addSubview:<#(void)#>]
        
        //        [animationView startCanvasAnimation];
    }];
}

- (void)_p18appleLogin {
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

- (void)_p19VisionKit {
    __weak typeof(self) weakSelf = self;
    [self _buttonTitle:@"VisionKit" handler:^(UIButton * _Nonnull btn) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        if (@available(iOS 13.0, *)) {
            VNDocumentCameraViewController *vc =  VNDocumentCameraViewController.alloc.init;
            vc.delegate = strongSelf;
            [strongSelf ax_showVC:vc];
        }
        
    }];
    
}

- (void)_p20changeLanch {
    __weak typeof(self) weakSelf = self;
    [self _buttonTitle:@"选择照片 替换启动图" handler:^(UIButton * _Nonnull btn) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        [strongSelf ax_showCameraWithEditing:NO block:^(UIImage *originalImage, UIImage *editedImage) {
            [strongSelf _p20Image:originalImage];
        }];
        
    }];
    [self _buttonTitle:@"恢复如初 启动图" handler:^(UIButton * _Nonnull btn) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        [LLDynamicLaunchScreen restoreAsBefore];
        [strongSelf showAlertView:@"启动图已恢复，APP即将退出"];
    }];
}

-(void)_p20Image:(UIImage *)selectedImage {
    
    NSMutableArray<AXActionItem *> *temp = NSMutableArray.array;
    {
        AXActionItem *item = AXActionItem.alloc.init;
        item.title = @"替换浅色竖屏启动图";
        item.style = UIAlertActionStyleDefault;
        item.handler = ^{
            [LLDynamicLaunchScreen replaceVerticalLaunchImage:selectedImage];
            //            [LLDynamicLaunchScreen replaceLaunchImage:selectedImage type:LLLaunchImageTypeVerticalLight compressionQuality:0.8 customValidation:nil];
            [self showAlertView:@"浅色竖屏启动图替换成功，APP即将退出"];
            
        };
        [temp addObject:item];
    }
    
    {
        AXActionItem *item = AXActionItem.alloc.init;
        item.title = @"替换浅色横屏启动图";
        item.style = UIAlertActionStyleDefault;
        item.handler = ^{
            
            [LLDynamicLaunchScreen replaceHorizontalLaunchImage:selectedImage];
            //            [LLDynamicLaunchScreen replaceLaunchImage:selectedImage type:LLLaunchImageTypeHorizontalLight compressionQuality:0.8 customValidation:nil];
            [self showAlertView:@"浅色横屏启动图替换成功，APP即将退出"];
            
        };
        
        [temp addObject:item];
    }
    {
        AXActionItem *item = AXActionItem.alloc.init;
        item.title = @"替换深色横屏启动图";
        item.style = UIAlertActionStyleDefault;
        item.handler = ^{
            
            if (@available(iOS 13.0, *)) {
                //                [LLDynamicLaunchScreen replaceLaunchImage:selectedImage type:LLLaunchImageTypeVerticalDark compressionQuality:0.8 customValidation:nil];
                [LLDynamicLaunchScreen replaceVerticalLaunchImage:selectedImage];
                [self showAlertView:@"深色竖屏启动图替换成功，APP即将退出"];
            } else {
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"iOS13以下系统不支持替换深色启动图" message:nil preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
                [alert addAction:cancelAction];
                [self presentViewController:alert animated:YES completion:nil];
            }
        };
        
        [temp addObject:item];
    }
    {
        AXActionItem *item = AXActionItem.alloc.init;
        item.title = @"替换深色横屏启动图";
        item.style = UIAlertActionStyleDefault;
        item.handler = ^{
            
            if (@available(iOS 13.0, *)) {
                [LLDynamicLaunchScreen replaceHorizontalLaunchImage:selectedImage];
                //                [LLDynamicLaunchScreen replaceLaunchImage:selectedImage type:LLLaunchImageTypeHorizontalDark compressionQuality:0.8 customValidation:nil];
                [self showAlertView:@"深色横屏启动图替换成功，APP即将退出"];
            } else {
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"iOS13以下系统不支持替换深色启动图" message:nil preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
                [alert addAction:cancelAction];
                [self presentViewController:alert animated:YES completion:nil];
            }
            
        };
        [temp addObject:item];
    }
    
    [self ax_showSheetByTitle:@"请选择替换方式" message:@"" actionItems:temp confirm:^(NSInteger index) {
        
    } cancel:^{
        
    }];
}

-(void)_p21stackView {
    /// https://www.jianshu.com/p/19a267be1347
    UIStackView *stackView = [[UIStackView alloc] init];
    /***
     @property(nonatomic) UILayoutConstraintAxis axis;
     // 枚举
     typedef NS_ENUM(NSInteger, UILayoutConstraintAxis) {
     // 水平布局
     UILayoutConstraintAxisHorizontal = 0,
     // 垂直布局
     UILayoutConstraintAxisVertical = 1
     };
     
     */
    stackView.axis = UILayoutConstraintAxisHorizontal;  // 水平方向
    /***
     @property(nonatomic) UIStackViewDistribution distribution;
     // 枚举
     typedef NS_ENUM(NSInteger, UIStackViewDistribution) {
     // 轴方向上填充
     UIStackViewDistributionFill = 0,
     // 子视图在轴方向上等宽或等高
     UIStackViewDistributionFillEqually,
     // 根据原先子视图的比例，来拉伸或压缩子视图的宽或高
     UIStackViewDistributionFillProportionally,
     // 保持子视图的宽高，子视图中间的间隔保持一致
     UIStackViewDistributionEqualSpacing,
     // 控制子视图的中心之间的距离保持一致
     UIStackViewDistributionEqualCentering,
     } API_AVAILABLE(ios(9.0));
     
     */
    stackView.distribution = UIStackViewDistributionFillEqually;    // 每个Item宽度相等
    /***
     @property(nonatomic) UIStackViewAlignment alignment;
     // 枚举
     typedef NS_ENUM(NSInteger, UIStackViewAlignment) {
     // 子视图填充
     UIStackViewAlignmentFill,
     // 子视图左对齐(axis为垂直方向而言)
     UIStackViewAlignmentLeading,
     // 子视图顶部对齐(axis为水平方向而言)
     UIStackViewAlignmentTop = UIStackViewAlignmentLeading,
     //  按照第一个子视图的文字的第一行对齐，同时保证高度最大的子视图底部对齐(只在axis为水平方向有效)
     UIStackViewAlignmentFirstBaseline,
     // 子视图居中对齐
     UIStackViewAlignmentCenter,
     // 子视图右对齐(axis为垂直方向而言)
     UIStackViewAlignmentTrailing,
     // 子视图底部对齐(axis为水平方向而言)
     UIStackViewAlignmentBottom = UIStackViewAlignmentTrailing,
     // 按照最后一个子视图的文字的最后一行对齐，同时保证高度最大的子视图顶部对齐(只在axis为水平方向有效)
     UIStackViewAlignmentLastBaseline,
     } API_AVAILABLE(ios(9.0));
     
     */
    stackView.alignment = UIStackViewAlignmentFill;     // 水平布局, 子控件的垂直方向填充满stackView
    /***
     @property(nonatomic) CGFloat spacing;
     */
    stackView.spacing = 10;
    [self.containerView addSubview:stackView];
    
    for (NSUInteger i = 0; i < 3; i++) {
        UIView *view = [[UIView alloc] init];
        view.backgroundColor = [UIColor ax_randomColor];
        [stackView addArrangedSubview:view];
    }
    
    [stackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10.f);     // 左边距：10
        make.right.mas_equalTo(-10.f);  // 右边距：10
        make.height.mas_equalTo(30.f);   // 设置高度
        make.top.equalTo(self.bottomAttribute).mas_equalTo(20);
        
    }];
    
    self.bottomAttribute = stackView.mas_bottom;
}


/// app内修改语言
-(void)_p23changeLanguages {
    // https://www.jianshu.com/p/c7e8e999c8c7
    
    NSLog(@"key_myDemo =  %@",NSLocalizedString(@"key_myDemo", nil));
    NSString *currentLan = [NSLocale preferredLanguages].firstObject;
    NSLog(@"currentLan =  %@",currentLan);
    
    {
        
        UILabel *label = UILabel.alloc.init;
        [self.containerView addSubview:label];
        label.text = currentLan;
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10.f);     // 左边距：10
            make.right.mas_equalTo(-10.f);  // 右边距：10
            make.height.mas_equalTo(30.f);   // 设置高度
            make.top.equalTo(self.bottomAttribute).mas_equalTo(20);
        }];
        self.bottomAttribute = label.mas_bottom;
        
    }
    UILabel *label = UILabel.alloc.init;
    [self.containerView addSubview:label];
    //    label.text = AXKitLocalizedString(@"确定");
    label.text =NSLocalizedString(@"key_myDemo", nil);
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10.f);     // 左边距：10
        make.right.mas_equalTo(-10.f);  // 右边距：10
        make.height.mas_equalTo(30.f);   // 设置高度
        make.top.equalTo(self.bottomAttribute).mas_equalTo(20);
    }];
    self.bottomAttribute = label.mas_bottom;
    __weak typeof(self) weakSelf = self;
    [self _buttonTitle:@"下一页面" handler:^(UIButton * _Nonnull btn) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        _01ContentViewController *vc = _01ContentViewController.alloc.init;
        [strongSelf ax_pushVC:vc];
    }];
    
    if (![currentLan isEqualToString:@"zh-Hans"]) {
        
        [self _buttonTitle:@"切换语言中文" handler:^(UIButton * _Nonnull btn) {
            __strong typeof(weakSelf) strongSelf = weakSelf;
            AXLog(@"切换语言中文 前 %@", [NSLocale preferredLanguages].firstObject);
            //        [[NSUserDefaults standardUserDefaults] setValue:nil forKey:@"AppleLanguages"];
            [[NSUserDefaults standardUserDefaults] setValue:@[@"zh-Hans"] forKey:@"AppleLanguages"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            AXLog(@"切换语言中文 后 %@", [NSLocale preferredLanguages].firstObject);
            NSLog(@"key_myDemo =  %@",NSLocalizedString(@"key_myDemo", nil));
            //        [self loadViewIfNeeded];
            [strongSelf _chanageRoot];
        }];
    }else  if (![currentLan isEqualToString:@"en"]) {
        
        
        [self _buttonTitle:@"切换语言英文" handler:^(UIButton * _Nonnull btn) {
            AXLog(@"切换语言英文 前 %@", [NSLocale preferredLanguages].firstObject);
            __strong typeof(weakSelf) strongSelf = weakSelf;
            //        [[NSUserDefaults standardUserDefaults] setValue:nil forKey:@"AppleLanguages"];
            
            [[NSUserDefaults standardUserDefaults] setValue:@[@"en"] forKey:@"AppleLanguages"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            AXLog(@"切换语言英文 后 %@", [NSLocale preferredLanguages].firstObject);
            NSLog(@"key_myDemo =  %@",NSLocalizedString(@"key_myDemo", nil));
            //        [self loadViewIfNeeded];
            [strongSelf _chanageRoot];
        }];
    }
}

-(void)_chanageRoot {
    UITabBarController *tabbarController =(UITabBarController *)[MakeKeyAndVisible makeKeyAndVisible];
    
    UINavigationController *navigationController = tabbarController.selectedViewController;
    NSMutableArray *viewControllers = navigationController.viewControllers.mutableCopy;
    
    //    UIViewController *me = (UIViewController *)[viewControllers firstObject];
    //    [me loadViewIfNeeded];
    
    
    _01ContentViewController *languageController = [[_01ContentViewController alloc] init];
    languageController.hidesBottomBarWhenPushed = YES;
    [viewControllers addObject:languageController];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        ax_setRootViewController(tabbarController);
        navigationController.viewControllers = viewControllers;
        AXLog(@"切换语言完成 %@ + %@", [NSLocale preferredLanguages].firstObject,NSLocalizedString(@"key_myDemo", nil));
    });
    
    
}

- (void)showAlertView:(NSString *)text {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        exit(0);
    });
}


- (void)documentCameraViewController:(VNDocumentCameraViewController *)controller didFinishWithScan:(VNDocumentCameraScan *)scan API_AVAILABLE(ios(13.0)){
    [controller dismissViewControllerAnimated:YES completion:nil];
    
    NSLog(@"title %@,pageCount %ld",scan.title,scan.pageCount);
    
}

// The delegate will receive this call when the user cancels.
- (void)documentCameraViewControllerDidCancel:(VNDocumentCameraViewController *)controller API_AVAILABLE(ios(13.0)){
    [controller dismissViewControllerAnimated:YES completion:nil];
    
}

// The delegate will receive this call when the user is unable to scan, with the following error.
- (void)documentCameraViewController:(VNDocumentCameraViewController *)controller didFailWithError:(NSError *)error API_AVAILABLE(ios(13.0)){
    
    [self ax_showAlertByTitle:@"失败" message:error.localizedDescription confirm:^{
        
    }];
}


#pragma mark- apple授权状态 更改通知
- (void)handleSignInWithAppleStateChanged:(NSNotification *)notification
{
    NSLog(@"ASAuthorizationAppleIDProviderCredentialRevokedNotification = %@", notification.userInfo);
}

- (void)didCustomBtnClicked {
    if (@available(iOS 13.0, *)) {
        // 基于用户的Apple ID授权用户，生成用户授权请求的一种机制
        ASAuthorizationAppleIDProvider *appleIDProvider = [[ASAuthorizationAppleIDProvider alloc] init];
        
        NSMutableArray <ASAuthorizationRequest *> *array = [NSMutableArray arrayWithCapacity:2];
        
        // 创建新的AppleID 授权请求
        ASAuthorizationAppleIDRequest *appleIDRequest = [appleIDProvider createRequest];
        // 在用户授权期间请求的联系信息
        appleIDRequest.requestedScopes = @[ASAuthorizationScopeFullName, ASAuthorizationScopeEmail];
        
        if (appleIDRequest) {
            [array addObject:appleIDRequest];
        }
        
        ASAuthorizationPasswordRequest *passwordRequest = [[[ASAuthorizationPasswordProvider alloc] init] createRequest];
        
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
    } else {
        // 处理不支持系统版本
        NSLog(@"该系统版本不可用Apple登录");
    }
}

#pragma mark- 授权成功的回调
// 授权成功
- (void)authorizationController:(ASAuthorizationController *)controller didCompleteWithAuthorization:(ASAuthorization *)authorization API_AVAILABLE(ios(13.0))
{
    if ([authorization.credential isKindOfClass:[ASAuthorizationAppleIDCredential class]]) {
        ASAuthorizationAppleIDCredential *credential = (ASAuthorizationAppleIDCredential *)authorization.credential;
        // 苹果用户唯一标识符，该值在同一个开发者账号下的所有 App 下是一样的，开发者可以用该唯一标识符与自己后台系统的账号体系绑定起来。
        NSString *userID = credential.user;
        // 苹果用户信息 如果授权过，可能无法再次获取该信息
        NSPersonNameComponents *fullName = credential.fullName;
        NSString *email = credential.email;
        // 服务器验证需要使用的参数
        NSString *authorizationCode = [[NSString alloc] initWithData:credential.authorizationCode encoding:NSUTF8StringEncoding];
        NSString *identityToken = [[NSString alloc] initWithData:credential.identityToken encoding:NSUTF8StringEncoding];
        // 用于判断当前登录的苹果账号是否是一个真实用户，取值有：unsupported、unknown、likelyReal
        ASUserDetectionStatus realUserStatus = credential.realUserStatus;
        NSLog(@"userID: %@", userID);
        NSLog(@"fullName: %@", fullName);
        NSLog(@"email: %@", email);
        NSLog(@"authorizationCode: %@", authorizationCode);
        NSLog(@"identityToken: %@", identityToken);
        NSLog(@"realUserStatus: %@", @(realUserStatus));
    } else if ([authorization.credential isKindOfClass:[ASPasswordCredential class]]) {
        // 用户登录使用现有的密码凭证
        ASPasswordCredential *passwordCredential = (ASPasswordCredential *)authorization.credential;
        // 密码凭证对象的用户标识 用户的唯一标识
        NSString *user = passwordCredential.user;
        // 密码凭证对象的密码
        NSString *password = passwordCredential.password;
        NSLog(@"userID: %@", user);
        NSLog(@"password: %@", password);
    } else {
    }
}

- (void)authorizationController:(ASAuthorizationController *)controller didCompleteWithError:(NSError *)error API_AVAILABLE(ios(13.0))
{
    NSString *errorMsg = nil;
    
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
    NSLog(@"errorMsg = %@", errorMsg);
}

/// ASAuthorizationControllerPresentationContextProviding 就一个方法，主要是告诉 ASAuthorizationController 展示在哪个 window 上。
- (ASPresentationAnchor)presentationAnchorForAuthorizationController:(ASAuthorizationController *)controller
API_AVAILABLE(ios(13.0))
{
    return self.view.window;
}

#pragma mark - 主题变化
- (void)traitCollectionDidChange:(UITraitCollection *)previousTraitCollection {
    [super traitCollectionDidChange:previousTraitCollection];
    
    if ((self.traitCollection.verticalSizeClass != previousTraitCollection.verticalSizeClass)
        || (self.traitCollection.horizontalSizeClass != previousTraitCollection.horizontalSizeClass)) {
        NSLog(@"traitCollectionDidChange");
    }
    
    //    改变当前模式
    if (@available(iOS 13.0, *)) {
        AXLoger(@"模式>>1 %ld", ax_keyWindow().overrideUserInterfaceStyle);
        AXLoger(@"模式>>2 %ld", self.overrideUserInterfaceStyle);
        
        NSString *text = @"暂无";
        switch (ax_keyWindow().overrideUserInterfaceStyle) {
            case UIUserInterfaceStyleUnspecified:
                text = @"模式 Unspecified";
                break;
            case UIUserInterfaceStyleLight:
                text = @"模式 Light";
                break;
            case UIUserInterfaceStyleDark:
                text = @"模式 Dark";
                break;
            default:
                break;
        }
        self.label.text = text;
    }
}

#pragma mark - 气泡弹窗 -
-(void)_qipao:(UIButton *)btn {
    
    //初始化内容视图控制器
    _09AFNViewController *  contentVC = [[_09AFNViewController alloc]init];
    // 设置弹出效果
    contentVC.modalPresentationStyle = UIModalPresentationPopover;
    //设置大小
    contentVC.preferredContentSize = CGSizeMake(110, 160);
    //初始化一个popover
    UIPopoverPresentationController *popover = contentVC.popoverPresentationController;
    popover.delegate = self;
    //设置弹出视图的颜色
    popover.backgroundColor = [UIColor greenColor];
    //设置popover的来源按钮（以button谁为参照）
    popover.sourceView =btn;
    //设置弹出视图的位置（以button谁为参照）
    popover.sourceRect = btn.bounds;
    //箭头的方向 设置成UIPopoverArrowDirectionAny 会自动转换方向
    popover.permittedArrowDirections = UIPopoverArrowDirectionAny;
    //模态出弹框
    [self presentViewController:contentVC animated:YES completion:nil];//推出popover
    
}
#pragma mark --  实现代理方法
//默认返回的是覆盖整个屏幕，需设置成UIModalPresentationNone。
- (UIModalPresentationStyle)adaptivePresentationStyleForPresentationController:(UIPresentationController *)controller{
    return UIModalPresentationNone;
}

//点击蒙版是否消失，默认为yes；

-(BOOL)popoverPresentationControllerShouldDismissPopover:(UIPopoverPresentationController *)popoverPresentationController{
    return YES;
}

//弹框消失时调用的方法
-(void)popoverPresentationControllerDidDismissPopover:(UIPopoverPresentationController *)popoverPresentationController{
    
    NSLog(@"弹框已经消失");
    
}


- (void)dealloc {
    axLong_dealloc;
}
@end
