//
//  AppDelegateURLProtocol.m
//  AXiOSKit
//
//  Created by 小星星吃KFC on 2021/2/20.
//  Copyright © 2021 axinger. All rights reserved.
//

#import "AppDelegateURLProtocol.h"
#import <OHHTTPStubs/HTTPStubs.h>
#import <OHHTTPStubs/HTTPStubsResponse+JSON.h>
@implementation AppDelegateURLProtocol

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [HTTPStubs stubRequestsPassingTest:^BOOL(NSURLRequest * _Nonnull request) {
        NSLog(@"拦截请求 = %@,\n HTTPBody = %@,\n allHTTPHeaderFields = %@",request.URL,request.HTTPBody, request.allHTTPHeaderFields);
    
        return [request.URL.host isEqualToString:@"www.ax.com"];
    } withStubResponse:^HTTPStubsResponse * _Nonnull(NSURLRequest * _Nonnull request) {
        NSDictionary *dict = @{
            @"name":@"jim",
            @"age":@10
        };
        return  [[HTTPStubsResponse responseWithJSONObject:dict statusCode:200 headers:nil] requestTime:1.0 responseTime:OHHTTPStubsDownloadSpeedSLOW];
    }];
    
    [HTTPStubs onStubActivation:^(NSURLRequest * _Nonnull request, id<HTTPStubsDescriptor>  _Nonnull stub, HTTPStubsResponse * _Nonnull responseStub) {
        NSLog(@"onStubActivation \n %@",request.URL);
    }];
    return YES;
}

@end
