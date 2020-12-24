//
//  AXImageSchemeHanlder.m
//  AFNetworking
//
//  Created by 小星星吃KFC on 2020/12/24.
//

#import "AXImageSchemeHanlder.h"
@import WebKit;
#import <SDWebImage/SDWebImage.h>
#import "NSData+AXKit.h"


@implementation AXImageSchemeHanlder

- (void)webView:(nonnull WKWebView *)webView startURLSchemeTask:(nonnull id<WKURLSchemeTask>)urlSchemeTask {
    
    UIImage *image = self.placeholderImage;
    NSData *data = UIImageJPEGRepresentation(image, 1.0);
    NSURLResponse *response = [[NSURLResponse alloc] initWithURL:urlSchemeTask.request.URL MIMEType:@"image/jpeg" expectedContentLength:data.length textEncodingName:nil];
    [urlSchemeTask didReceiveResponse:response];
    [urlSchemeTask didReceiveData:data];
    [urlSchemeTask didFinish];
    
    if (self.updateImageBlock) {
        self.updateImageBlock();
    }
    
    NSString *htmlImageUrlStr = [NSString stringWithFormat:@"%@",urlSchemeTask.request.URL];
    NSString *dloadImageUrlStr = [htmlImageUrlStr stringByReplacingOccurrencesOfString:XXXCustomImageScheme withString:self.oriImageScheme];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{

        [self readImageForKey:dloadImageUrlStr htmlImageUrlStr:htmlImageUrlStr webView:webView];
    });
}



- (void)readImageForKey:(NSString *)dloadImageUrlStr htmlImageUrlStr:(NSString *)htmlImageUrlStr webView:(WKWebView *)webView {
    
    __weak typeof(self) weakSelf = self;
    NSURL *url = [NSURL URLWithString:dloadImageUrlStr];
    [[SDWebImageManager sharedManager] loadImageWithURL:url options:SDWebImageRetryFailed progress:nil completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, SDImageCacheType cacheType, BOOL finished, NSURL * _Nullable imageURL) {
        
        if (image || data) {
            NSData *imgData = data;
            
            if (!imgData) imgData = UIImageJPEGRepresentation(image, 1);
            
            [weakSelf callJsUpdateImage:webView imageData:imgData htmlImageUrlStr:htmlImageUrlStr];
        }
        if (error) {}
    }];
}




- (void)callJsUpdateImage:(WKWebView *)webView imageData:(NSData *)imageData htmlImageUrlStr:(NSString *)imageUrlString {
    
    __weak typeof(self) weakSelf = self;
    NSString *imageDataStr = [NSString stringWithFormat:@"data:image/png;base64,%@",[imageData ax_toBase64]];
    NSString *func = [NSString stringWithFormat:@"xxxUpdateImage('%@','%@')",imageUrlString,imageDataStr];
    [webView evaluateJavaScript:func completionHandler:^(id _Nullable response, NSError * _Nullable error) {
        if (weakSelf.updateImageBlock && !error) {
            weakSelf.updateImageBlock();
        }
    }];
}

- (void)webView:(nonnull WKWebView *)webView stopURLSchemeTask:(nonnull id<WKURLSchemeTask>)urlSchemeTask {
    
}



@end
