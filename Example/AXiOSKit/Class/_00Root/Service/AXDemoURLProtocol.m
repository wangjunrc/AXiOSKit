//
//  AXDemoURLProtocol.m
//  AXiOSKit_Example
//
//  Created by 小星星吃KFC on 2021/5/24.
//  Copyright © 2021 axinger. All rights reserved.
//

#import "AXDemoURLProtocol.h"
@interface AXDemoURLProtocol ()<NSURLSessionDelegate>

@property (nonnull,strong) NSURLSessionDataTask *task;

@end


@implementation AXDemoURLProtocol


+ (BOOL)canInitWithRequest:(NSURLRequest *)request{
    NSLog(@"request.URL.absoluteString = %@",request.URL.absoluteString);
    NSString *scheme = [[request URL] scheme];
    if ( ([scheme caseInsensitiveCompare:@"http"]  == NSOrderedSame ||
          [scheme caseInsensitiveCompare:@"https"] == NSOrderedSame )){
        //看看是否已经处理过了，防止无限循环
        if ([NSURLProtocol propertyForKey:request.URL.absoluteString inRequest:request]){
            return NO;
        }
        
        return YES;
    }
    
    return YES;
}

+ (NSURLRequest *)canonicalRequestForRequest:(NSURLRequest *)request{
    
    NSLog(@"canonicalRequestForRequest = %@",request.URL.absoluteString);
    
    
    NSMutableURLRequest *mutableReqeust = [request mutableCopy];
    
    //request截取重定向
    //    if ([request.URL.pathExtension isEqualToString:@"png"] ||
    //        [request.URL.pathExtension isEqualToString:@"jgep"] )
    //    {
    //        NSURL* url1 = [NSURL URLWithString:localUrl];
    //        mutableReqeust = [NSMutableURLRequest requestWithURL:url1];
    //    }
    
    return mutableReqeust;
}

+ (BOOL)requestIsCacheEquivalent:(NSURLRequest *)a toRequest:(NSURLRequest *)b{
    return [super requestIsCacheEquivalent:a toRequest:b];
}

- (void)startLoading{
    
    NSLog(@"startLoading = %@",self.request.URL.absoluteString);
    
    NSMutableURLRequest *mutableReqeust = [[self request] mutableCopy];
    //给我们处理过的请求设置一个标识符, 防止无限循环,
    [NSURLProtocol setProperty:@(YES) forKey:self.request.URL.absoluteString inRequest:mutableReqeust];
    
    //这里最好加上缓存判断，加载本地离线文件， 这个直接简单的例子。
    // 测试拦截png,不拦截jpeg
    NSString *pathExtension = mutableReqeust.URL.pathExtension;
    if ([pathExtension isEqualToString:@"png"]) {
        
        
        
        NSData* data = UIImagePNGRepresentation([UIImage imageNamed:@"西瓜"]);
        //        NSURLResponse* response = [[NSURLResponse alloc] initWithURL:self.request.URL MIMEType:@"image/png" expectedContentLength:data.length textEncodingName:nil];
        //        [self.client URLProtocol:self didReceiveResponse:response cacheStoragePolicy:NSURLCacheStorageAllowed];
        [self.client URLProtocol:self didLoadData:data];
        [self.client URLProtocolDidFinishLoading:self];
    }else {
        
        NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:self delegateQueue:nil];
        self.task = [session dataTaskWithRequest:self.request];
        [self.task resume];
        
    }
    
}
- (void)stopLoading{
    NSLog(@"stopLoading = %@",self.request.URL.absoluteString);
}

- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveResponse:(NSURLResponse *)response completionHandler:(void (^)(NSURLSessionResponseDisposition))completionHandler {
    [[self client] URLProtocol:self didReceiveResponse:response cacheStoragePolicy:NSURLCacheStorageAllowed];
    
    completionHandler(NSURLSessionResponseAllow);
}

- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveData:(NSData *)data {
    [[self client] URLProtocol:self didLoadData:data];
}

- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(nullable NSError *)error {
    [self.client URLProtocolDidFinishLoading:self];
}

@end
