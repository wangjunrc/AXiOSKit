//
//  AXWebVC.m
//  AXTools
//
//  Created by Mole Developer on 16/8/15.
//  Copyright © 2016年 MoleDeveloper. All rights reserved.
//

#import "AXWebVC.h"
#import "NJKWebViewProgressView.h"
#import "NJKWebViewProgress.h"
@interface AXWebVC ()<UIWebViewDelegate,NJKWebViewProgressDelegate>
@property (strong, nonatomic) IBOutlet UIWebView *webView;

@property (nonatomic, strong) NJKWebViewProgressView *progressView;
@property (nonatomic, strong) NJKWebViewProgress *progressProxy;

@end

@implementation AXWebVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(rightBarButtonItemEvents:)];
    [self setupProgress];
    [self setupBack];
  
}

-(void)setupProgress{
    self.progressProxy = [[NJKWebViewProgress alloc] init];
    self.webView.delegate = self.progressProxy;
    self.progressProxy.webViewProxyDelegate = self;
    self.progressProxy.progressDelegate = self;
    
    CGFloat progressBarHeight = 2.f;
    CGRect navigationBarBounds = self.navigationController.navigationBar.bounds;
    CGRect barFrame = CGRectMake(0, navigationBarBounds.size.height - progressBarHeight, navigationBarBounds.size.width, progressBarHeight);
    self.progressView = [[NJKWebViewProgressView alloc] initWithFrame:barFrame];
    self.progressView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
    
    [self loadGoogle];

}

-(void)setupBack{

    //是 moda出来的,没有返回按钮
//    if (!self.navigationItem.leftItemsSupplementBackButton) {
//        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(leftBarButtonItemEvnets:)];
//    }
    if (!self.navigationController.hash) {
//        self.webView.frame = CGRectMake(0, 20, self.view.width, self.view.height-20);
        
        UIButton *button = [[UIButton alloc]init];
        [self.webView.scrollView addSubview:button];
        
//        [self.view addSubview:button];
        NSString*title = @"取消";
       
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [button setTitle:title forState:UIControlStateNormal];
        [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:20];
         CGSize temp = [title ax_sizeWithaFont:button.titleLabel.font];
        button.frame = CGRectMake(20, 20, temp.width, temp.height);
//        button.backgroundColor = [UIColor lightGrayColor];
        [button addTarget:self action:@selector(buttonEvents:) forControlEvents:UIControlEventTouchUpInside];
    }
}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar addSubview:self.progressView];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.progressView removeFromSuperview];
}

-(void)rightBarButtonItemEvents:(UIBarButtonItem *)item{
    [self.webView reload];
}

-(void)loadGoogle{
    NSURLRequest *req = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:self.url]];
    [self.webView loadRequest:req];
}

#pragma mark - NJKWebViewProgressDelegate
-(void)webViewProgress:(NJKWebViewProgress *)webViewProgress updateProgress:(float)progress{
    [self.progressView setProgress:progress animated:YES];
    
//    self.title = [self.webView stringByEvaluatingJavaScriptFromString:@"document.title"];
}



-(void)leftBarButtonItemEvnets:(UIBarButtonItem *)item{
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(void)buttonEvents:(UIButton *)button{
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
