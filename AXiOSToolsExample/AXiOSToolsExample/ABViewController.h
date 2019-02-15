//
//  ABViewController.h
//  AXiOSToolsExample
//
//  Created by AXing on 2019/1/19.
//  Copyright © 2019 liu.weixing. All rights reserved.
//

#import "AXWKWebVC.h"
#import "ViewController.h"

typedef void (^FlutterResult)(id _Nullable result);

typedef void (^FlutterMethodCallHandler)(NSString *call, FlutterResult result);


NS_ASSUME_NONNULL_BEGIN

@interface ABViewController : AXWKWebVC

- (void)setMethodCallHandler:(FlutterMethodCallHandler _Nullable)handler;

/**<#description#>*/
@property (nonatomic, strong) ViewController *vc;
@end

NS_ASSUME_NONNULL_END
