//
//  AppDelegateAppearance.m
//  AXiOSKit_Example
//
//  Created by 小星星吃KFC on 2020/10/27.
//  Copyright © 2020 axinger. All rights reserved.
//

#import "AppDelegateAppearance.h"
#import <AXiOSKit/NSString+AXKit.h>
#import "DemoNavigationController.h"
@implementation AppDelegateAppearance
-(BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions{
    
    //    [self adapterIOS11];
    
    //    UIView.appearance.backgroundColor = UIColor.whiteColor;
    [[UIBarButtonItem appearanceWhenContainedInInstancesOfClasses:@[UISearchBar.class]]
     setTitleTextAttributes:@{NSForegroundColorAttributeName:UIColor.redColor}
     forState:UIControlStateNormal];
    
    //    [[UIView appearance] setBackgroundColor:[UIColor whiteColor]];
    
    /// iOS 15 适配
    if (@available(iOS 15.0, *)) {
        /// iOS 15 UITableView sectionHeader下移22像素
        UITableView.appearance.sectionHeaderTopPadding = 0;
        
        /// iOS 15 上苹果改变了导航条的部分默认行为，开发者可以自己重写：
        [UINavigationBar.appearance setScrollEdgeAppearance:({
            UINavigationBarAppearance *app = UINavigationBarAppearance.alloc.init;
            [app configureWithDefaultBackground];
            // init app property
            // app.backgroundColor = xxx;
            // app.shadowColor = xxx;
            app;
        })];
        
        
    }
    
    
    
    //    UIImage *image = [UIImage imageNamed:@"ax_bar_back"];
    //
    //    if (image) {
    //        /// 这个不行,只能换图片,不能换文字
    //        UINavigationBar.appearance.backIndicatorTransitionMaskImage = image;
    //        UINavigationBar.appearance.backIndicatorImage= image;
    //                UINavigationBar.appearance.backItem.title = @"";
    //                UINavigationBar.appearance.topItem.title = @"";
    //                [UINavigationBar appearanceWhenContainedInInstancesOfClasses:@[UINavigationController.class,DemoNavigationController.class]];
    //
    //    }
    
    //    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(-30, -60) forBarMetrics:UIBarMetricsDefault];
    //    [UIBarButtonItem.appearance setBackButtonBackgroundVerticalPositionAdjustment:30 forBarMetrics:UIBarMetricsDefault];
    
    //    //获取document路径
    //    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    //    NSString *documentDirectory = [paths objectAtIndex:0];
    //
    //    //文件名及其路径
    //    NSString *fileName = @"test.txt";
    //    NSString *filePath = [documentDirectory stringByAppendingPathComponent:fileName];
    //
    //    //建立一个char数组，并归档写入到沙盒中
    //    char *a = "hello, world";
    //    NSData *data = [NSData dataWithBytes:a length:12];
    //    [data writeToFile:filePath atomically:YES];
    
    
    //    BOOL isDirectory = NO;
    //      [NSFileManager.defaultManager fileExistsAtPath:obj isDirectory:&isDirectory];
    //    if (!isDirectory) {
    //
    //    }
    //    NSLog(@"isDirectory = %d",isDirectory);
    
    
    //    NSNumber *isDirectory = @(NO);
    //    NSURL *fileUrl = [NSURL fileURLWithPath:obj];
    //    [fileUrl getResourceValue:&isDirectory forKey:NSURLIsExcludedFromBackupKey error:nil];
    
    /// 解决放在资源Document目录下，会被iTunes同步的问题
    NSString *path = [NSString.ax_documentDirectory stringByAppendingPathComponent:@"notiTunesSync"];
    if (![NSFileManager.defaultManager fileExistsAtPath:path]) {
        [NSFileManager.defaultManager createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
    }
    NSURL *URL= [NSURL fileURLWithPath:path];
    NSError *error = nil;
    BOOL success = [URL setResourceValue:[NSNumber numberWithBool:YES] forKey:NSURLIsExcludedFromBackupKey error:&error];
    NSLog(@"阻止iTunes同步的问题  %@", success? @"成功" : @"失败");
    
    
    //    [UISearchBar.appearance setBarTintColor:UIColor.redColor];
    
    // 修改message字体及颜色
    //    NSMutableAttributedString *messageStr = [[NSMutableAttributedString alloc] initWithString:message];
    //    [messageStr addAttribute:NSForegroundColorAttributeName value: [UIColor colorWithHexString:@"#E02020"] range:NSMakeRange(0, messageStr.length)];
    //    [messageStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12] range:NSMakeRange(0, messageStr.length)];
    //    [alertController setValue:messageStr forKey:@"attributedMessage"];
    
    /// 按钮颜色
    //    [UIView appearanceWhenContainedInInstancesOfClasses:@[UIAlertController.class]].tintColor = UIColor.redColor;
    
    
    //    [UIView appearanceWhenContainedInInstancesOfClasses:@[UIAlertController.class]].tintColor = UIColor.redColor;
    //    [UILabel appearanceWhenContainedInInstancesOfClasses:@[UIAlertController.class,UIAlertView.class]].textColor = UIColor.redColor;
    //
    //    //实现模糊效果
    //       UIBlurEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    //       //毛玻璃视图
    //       UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:effect];;
    //
    //
    ////    @property (nonatomic, copy, nullable) UIVisualEffect *effect;
    ////    [UIVisualEffectView appearanceWhenContainedInInstancesOfClasses:@[UIAlertController.class]].effect = effectView;
    //    [UILabel appearanceWhenContainedInInstancesOfClasses:@[UIAlertController.class]].textColor = UIColor.orangeColor;
    //    [UILabel appearanceWhenContainedInInstancesOfClasses:@[UIAlertController.class]].tintColor = UIColor.greenColor;
    //
    //    NSMutableAttributedString *messageStr = [[NSMutableAttributedString alloc] initWithString:@"AA"];
    //    [messageStr addAttribute:NSForegroundColorAttributeName value: [UIColor orangeColor] range:NSMakeRange(0, messageStr.length)];
    //    [messageStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12] range:NSMakeRange(0, messageStr.length)];
    ////    [alertController setValue:messageStr forKey:@"attributedMessage"];
    //
    //    [UILabel appearanceWhenContainedInInstancesOfClasses:@[UIAlertController.class]].backgroundColor =UIColor.orangeColor;
    
    
    
    //    [UIBarButtonItem.appearance setTintColor:UIColor.redColor];;
    //    [UIButton.appearance setTitleColor:UIColor.blueColor forState:UIControlStateNormal];
    //    [UIButton.appearance setBackgroundColor:UIColor.grayColor];
    
    
    
    //    [[UIButton appearanceWhenContainedInInstancesOfClasses:@[[UINavigationController class]]] setBackgroundColor:[UIColor clearColor]];
    
    //    [[UIButton appearanceWhenContainedInInstancesOfClasses:@[[UIViewController class]]] setBackgroundColor:[UIColor grayColor]];
    //    [ax_libraryPaths ]
    //    [NSString ]
    /// 清除启动图缓存
    //    NSString *path=[NSString.ax_libraryPaths stringByAppendingPathComponent:@"SplashBoard"];
    //    [NSFileManager.defaultManager removeItemAtPath:path error:nil];
    return YES;
}

- (void)adapterIOS11{
    // 适配iOS11以上UITableview 、UICollectionView、UIScrollview 列表/页面偏移
    if (@available(iOS 11.0, *)){
        [[UIScrollView appearance] setContentInsetAdjustmentBehavior:UIScrollViewContentInsetAdjustmentNever];
        [[UITableView appearance] setEstimatedRowHeight:0];
        [[UITableView appearance] setEstimatedSectionFooterHeight:0];
        [[UITableView appearance] setEstimatedSectionHeaderHeight:0];
    }
}
@end
