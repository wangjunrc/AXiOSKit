//
//  AXUIWebJSDemoVC.m
//  AXiOSTools
//
//  Created by liuweixing on 16/8/15.
//  Copyright © 2016年 liuweixing. All rights reserved.
//

#import "AXUIWebJSDemoVC.h"
#import <JavaScriptCore/JavaScriptCore.h>
#import "AXJSContext.h"

@interface AXUIWebJSDemoVC ()<UIWebViewDelegate>

@property (strong, nonatomic)UIWebView *webView;

/**js交互上下文*/
@property (nonatomic, strong) AXJSContext *axJSContext;

@end

@implementation AXUIWebJSDemoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.webView = [[UIWebView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:self.webView];
    self.webView.delegate = self;
    [self setupProgress];
    
    [self.webView setMediaPlaybackRequiresUserAction:NO];
}

- (void)setupProgress{
    
    NSString *path = [[NSBundle mainBundle]pathForResource:@"UIWebViewPage" ofType:@"html"];
    
    NSURL *URL =  [NSURL fileURLWithPath:path];
    
    NSMutableURLRequest *req = [[NSMutableURLRequest alloc] initWithURL:URL];
    
    [self.webView loadRequest:req];
    
    
    self.axJSContext = [AXJSContext contextForWebView:self.webView];
    
    
    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, self.view.bounds.size.height-400, self.view.bounds.size.width, 400)];
    [self.view addSubview:bgView];
    bgView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    UITextField *tf = [[UITextField alloc]initWithFrame:CGRectMake(0, 0, bgView.bounds.size.width, 50)];
    tf.placeholder = @"输入文字";
    [bgView addSubview:tf];
    tf.backgroundColor = [UIColor orangeColor];
    tf.tag = 100;
    
    
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 60, bgView.bounds.size.width, 50)];
    [bgView addSubview:btn];
    btn.backgroundColor = [UIColor redColor];
    [btn setTitle:@"oc传值给js" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnAction) forControlEvents:UIControlEventTouchUpInside];

}


-(void)btnAction{
    [self.axJSContext stringByEvaluatingJavaScriptFromString:@"js_callBack('JIM')"];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    
    [self.axJSContext registerHandler:@"goHome" handler:^(id data) {
        NSLog(@"callHandler %@",data);
    }];
    
    [ self.axJSContext registerHandler:@"goHome2" handler:^(id data) {
        NSLog(@"callHandler %@",data);
    }];
    
}

-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSString *url = request.URL.absoluteString;
    if ([url rangeOfString:@"toyun://"].location != NSNotFound) {
        // url的协议头是toyun
        NSLog(@"callCamera");
        return NO;
    }
    return YES;
}


@end
