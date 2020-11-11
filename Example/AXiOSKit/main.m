//
//  main.m
//  AXiOSKitExample
//
//  Created by liuweixing on 2020/5/6.
//  Copyright © 2020 liuweixing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "Application.h"
int main(int argc, char * argv[]) {
    NSString * appDelegateClassName;
    NSString * applicationName;
    @autoreleasepool {
        // Setup code that might create autoreleased objects goes here.
        appDelegateClassName = NSStringFromClass([AppDelegate class]);
        applicationName = NSStringFromClass([Application class]);
    }
//    return UIApplicationMain(argc, argv, nil, appDelegateClassName);
    
    /// (argc, argv, nil, NSStringFromClass([AppDelegate class]));
      ///4个参数中，前两个参数为main（）函数传递进来的，我们可以忽略，第三个参数设置应用程序类，需要我们将其设置为UIApplication或其子类，如果不设置，则默认为UIApplication，最后一个参数是设置应用程序的代理类
      return UIApplicationMain(argc, argv, applicationName, appDelegateClassName);

//    return UIApplicationMain(argc, argv, nil, appDelegateClassName);
}
