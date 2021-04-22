//
//  AppDelegateDebug.m
//  AXiOSKit_Example
//
//  Created by 小星星吃KFC on 2020/11/14.
//  Copyright © 2020 axinger. All rights reserved.
//

#import "AppDelegateDebug.h"
#ifdef DEBUG
    @import CocoaDebug;
#endif

@implementation AppDelegateDebug

-(BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions{
    
#if DEBUG
    /// 只能模拟器
    /// for iOS
    [[NSBundle bundleWithPath:@"/Applications/InjectionIII.app/Contents/Resources/iOSInjection.bundle"] load];
    /// for tvOS
    [[NSBundle bundleWithPath:@"/Applications/InjectionIII.app/Contents/Resources/tvOSInjection.bundle"] load];
    /// for masOS
    [[NSBundle bundleWithPath:@"/Applications/InjectionIII.app/Contents/Resources/macOSInjection.bundle"] load];
#endif
    
        #ifdef DEBUG
    //        //--- If Want to Custom CocoaDebug Settings ---
    //        CocoaDebug.serverURL = @"google.com";
    //        CocoaDebug.ignoredURLs = @[@"aaa.com", @"bbb.com"];
    //        CocoaDebug.onlyURLs = @[@"ccc.com", @"ddd.com"];
    //        CocoaDebug.ignoredPrefixLogs = @[@"aaa", @"bbb"];
    //        CocoaDebug.onlyPrefixLogs = @[@"ccc", @"ddd"];
            CocoaDebug.logMaxCount = 1000;
    //        CocoaDebug.emailToRecipients = @[@"aaa@gmail.com", @"bbb@gmail.com"];
    //        CocoaDebug.emailCcRecipients = @[@"ccc@gmail.com", @"ddd@gmail.com"];
            CocoaDebug.mainColor = @"#fd9727";
    //        CocoaDebug.additionalViewController = [AdditionalTestController new];
    //
    //        //--- If Use Google's Protocol buffers ---
    //        CocoaDebug.protobufTransferMap = @{
    //            @"your_api_keywords_1": @[@"your_protobuf_className_1"],
    //            @"your_api_keywords_2": @[@"your_protobuf_className_2"],
    //            @"your_api_keywords_3": @[@"your_protobuf_className_3"]
    //        };
        #endif
    
    return YES;
}
@end
