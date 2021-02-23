//
//  Target_News.m
//  AXiOSKit_Example
//
//  Created by 小星星吃KFC on 2021/2/23.
//  Copyright © 2021 axinger. All rights reserved.
//

#import "Target_News.h"
#import "_09AFNViewController.h"
@implementation Target_News

- (UIViewController *)Action_NativeToNewsViewController:(NSDictionary *)params {
    _09AFNViewController *newsVC = [[_09AFNViewController alloc] init];
    NSLog(@"params = %@",params);
    
    if ([params valueForKey:@"newsID"]) {
        
    }
    
    return newsVC;
}

@end
