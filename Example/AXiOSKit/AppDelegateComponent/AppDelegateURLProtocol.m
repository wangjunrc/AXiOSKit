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
#import <OHHTTPStubs/HTTPStubsPathHelpers.h>


@implementation AppDelegateURLProtocol

-(BOOL)shouldUseDelay {
    __block BOOL res = NO;
    dispatch_sync(dispatch_get_main_queue(), ^{
        res = YES;
    });
    return res;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [HTTPStubs stubRequestsPassingTest:^BOOL(NSURLRequest * _Nonnull request) {
        NSLog(@"拦截请求 = %@,\n HTTPBody = %@,\n allHTTPHeaderFields = %@",request.URL,request.HTTPBody, request.allHTTPHeaderFields);
        NSLog(@"HTTPBodyStream = %@",request.HTTPBodyStream);
        
        
        return [request.URL.host isEqualToString:@"www.ax.com"];
    } withStubResponse:^HTTPStubsResponse * _Nonnull(NSURLRequest * _Nonnull request) {
        //        NSLog(@"拦截请求 = %@,\n HTTPBody = %@,\n allHTTPHeaderFields = %@",request.URL,request.HTTPBody, request.allHTTPHeaderFields);
        
        NSDictionary *dict = @{
            @"name":@"jim",
            @"age":@10,
            @"height":[NSNull null],
        };
        return  [[HTTPStubsResponse responseWithJSONObject:dict statusCode:200 headers:nil] requestTime:1.0 responseTime:OHHTTPStubsDownloadSpeedSLOW];
        
        return [[HTTPStubsResponse responseWithFileAtPath:OHPathForFile(@"stub.txt", self.class)
                                               statusCode:200
                                                  headers:@{@"Content-Type":@"text/plain"}]
                requestTime:[self shouldUseDelay] ? 2.f: 0.f
                responseTime:OHHTTPStubsDownloadSpeedWifi];
        
        
        return [[HTTPStubsResponse responseWithFileAtPath:OHPathForFile(@"stub.jpg", self.class)
                                                 statusCode:200
                                                    headers:@{@"Content-Type":@"image/jpeg"}]
                requestTime:[self shouldUseDelay] ? 2.f: 0.f
                responseTime:OHHTTPStubsDownloadSpeedWifi];
        
    }];
    
    [HTTPStubs onStubActivation:^(NSURLRequest * _Nonnull request, id<HTTPStubsDescriptor>  _Nonnull stub, HTTPStubsResponse * _Nonnull responseStub) {
        NSLog(@"onStubActivation \n %@",request.URL);
    }];
    
    
    
    return YES;
}

@end
