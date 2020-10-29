//
//  AppDelegateAppearance.m
//  AXiOSKit_Example
//
//  Created by 小星星吃KFC on 2020/10/27.
//  Copyright © 2020 axinger. All rights reserved.
//

#import "AppDelegateAppearance.h"
#import <AXiOSKit/NSString+AXKit.h>

@implementation AppDelegateAppearance
-(BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions{
    
    [self adapterIOS11];
    
    [[UIBarButtonItem appearanceWhenContainedInInstancesOfClasses:@[UISearchBar.class]]
     setTitleTextAttributes:@{NSForegroundColorAttributeName:UIColor.redColor}
     forState:UIControlStateNormal];
    
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
    
    NSString *obj = @"home/cs046_js@mam1.ft-power.com.cn";
//    BOOL isDirectory = NO;
//      [[NSFileManager defaultManager] fileExistsAtPath:obj isDirectory:&isDirectory];
//    if (!isDirectory) {
//
//    }
//    NSLog(@"isDirectory = %d",isDirectory);

    NSNumber *isDirectory = @(NO);
      NSURL *fileUrl = [NSURL fileURLWithPath:obj];
      [fileUrl getResourceValue:&isDirectory forKey:NSURLIsExcludedFromBackupKey error:nil];

//    if (!isDirectory.boolValue ) {
//        NSLog(@"isDirectory = %@",obj);
//    }
    NSLog(@"isDirectory = %d",isDirectory.boolValue);
    
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
    NSString *path=[NSString.ax_libraryPaths stringByAppendingPathComponent:@"SplashBoard"];
    [NSFileManager.defaultManager removeItemAtPath:path error:nil];
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
