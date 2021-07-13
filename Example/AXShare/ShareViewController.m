//
//  ShareViewController.m
//  分享
//
//  Created by liuweixing on 2020/5/20.
//  Copyright © 2020 liuweixing. All rights reserved.
//

#import "ShareViewController.h"
#import "AXShareContentViewController.h"
//#import <ReactiveObjC/ReactiveObjC.h>
//#import <Masonry/Masonry.h>

@implementation ShareViewController

- (BOOL)isContentValid {
    // Do validation of contentText and/or NSExtensionContext attachments here
    return YES;
}

- (void)didSelectPost {
    // This is called after the user selects Post. Do the upload of contentText and/or NSExtensionContext attachments.
    
    // Inform the host that we're done, so it un-blocks its UI. Note: Alternatively you could call super's -didSelectPost, which will similarly complete the extension context.
    [self.extensionContext completeRequestReturningItems:@[] completionHandler:nil];
}

- (NSArray *)configurationItems {
    // To add configuration options via table cells at the bottom of the sheet, return an array of SLComposeSheetConfigurationItem here.
    return @[];
}



- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.redColor;
    AXShareContentViewController *vc = [AXShareContentViewController.alloc init];
    [self setViewControllers:@[vc]];
    
}

@end
