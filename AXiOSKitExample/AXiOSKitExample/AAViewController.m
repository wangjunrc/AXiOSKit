//
//  AAViewController.m
//  AXiOSKitExample
//
//  Created by AXing on 2019/6/19.
//  Copyright © 2019 liu.weixing. All rights reserved.
//

#import "AAViewController.h"
#import <AXiOSKit/AXiOSKit.h>
//#import <AXiOSKit/UIColor+AXKit.h>
#import "FBKVOController.h"

@interface AAViewController ()
@property (nonatomic, copy)NSString *name;
@property (nonatomic   , copy    )NSString *aaaaaaaaaaaaaname;
@end

@implementation AAViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    if (@available(iOS 13.0, *)) {
          self.view.backgroundColor = [UIColor ax_colorWithNormalStyle:UIColor.whiteColor darkStyle:UIColor.systemBackgroundColor];
      }
    
//    AXLoger(@"模式>> %ld",self.overrideUserInterfaceStyle);
    if (@available(iOS 13.0, *)) {
        AXLoger(@"模式>> %ld",ax_keyWindow().overrideUserInterfaceStyle);
    } else {
        // Fallback on earlier versions
    }
    
       

    UIImageView *imv = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"ax_icon_weixin"]];
    [self.view addSubview:imv];
    imv.frame= CGRectMake(100, 300, 100, 100);
    
    
    UIButton *btn = [[UIButton alloc]init];
    [self.view addSubview:btn];
    btn.frame = CGRectMake(0, 0, 100, 50);
    btn.backgroundColor = UIColor.blueColor;
    [btn ax_setTitleStateNormal:@"改变模式"];
    btn.ax_top = imv.ax_bottom+10;
    btn.ax_left = imv.ax_left;
    [btn ax_addActionBlock:^(UIButton * _Nullable button) {
        if (@available(iOS 13.0, *)) {
//            if ( self.overrideUserInterfaceStyle == UIUserInterfaceStyleLight) {
//                self.overrideUserInterfaceStyle = UIUserInterfaceStyleDark;
//
//            }else{
//                self.overrideUserInterfaceStyle = UIUserInterfaceStyleLight;
//            }
                 if (ax_keyWindow().overrideUserInterfaceStyle != UIUserInterfaceStyleDark) {
                ax_keyWindow().overrideUserInterfaceStyle = UIUserInterfaceStyleDark;
                
            }else{
                ax_keyWindow().overrideUserInterfaceStyle = UIUserInterfaceStyleLight;
            }
              AXLoger(@"模式>> %ld", ax_keyWindow().overrideUserInterfaceStyle);
        }
    }];
    

}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    self.view.backgroundColor = [UIColor ax_randomColor];
}


- (void) traitCollectionDidChange: (UITraitCollection *) previousTraitCollection {
    
    
    [super traitCollectionDidChange: previousTraitCollection];
    
    if ((self.traitCollection.verticalSizeClass != previousTraitCollection.verticalSizeClass)
        || (self.traitCollection.horizontalSizeClass != previousTraitCollection.horizontalSizeClass)) {
        //         your custom implementation here
        NSLog(@"traitCollectionDidChange");
    }
    
    //    改变当前模式
    //
    //    self.overrideUserInterfaceStyle = UIUserInterfaceStyleDark;
    
    
    
}

- (void)dealloc
{
    axLong_dealloc;
}
@end
