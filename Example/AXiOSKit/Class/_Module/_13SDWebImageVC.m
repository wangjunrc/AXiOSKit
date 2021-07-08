//
//  _13SDWebImageVC.m
//  AXiOSKit
//
//  Created by 小星星吃KFC on 2021/3/15.
//  Copyright © 2021 axinger. All rights reserved.
//

#import "_13SDWebImageVC.h"
#import <SDWebImageFLPlugin/SDWebImageFLPlugin.h>
#import <SDWebImageWebPCoder/UIImage+WebP.h>

@interface _13SDWebImageVC ()

@end

@implementation _13SDWebImageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIImageView *imgView1 = [UIImageView.alloc init];
    imgView1.backgroundColor = UIColor.grayColor;
    [self.containerView addSubview:imgView1];
    [imgView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.bottomAttribute).mas_equalTo(20);
        make.width.height.mas_equalTo(60);
        make.centerX.mas_equalTo(0);
    }];
    
    [SDImageCache.sharedImageCache containsImageForKey:@"key_1234" cacheType:SDImageCacheTypeAll completion:^(SDImageCacheType containsCacheType) {
        NSLog(@"containsImageForKey %ld",containsCacheType);
        
        if (containsCacheType == SDImageCacheTypeNone) {
            NSLog(@"缓存一下");
            [SDImageCache.sharedImageCache storeImage:[UIImage imageNamed:@"no_data"] forKey:@"key_1234" completion:^{
                NSLog(@"缓存一下,成功");
                imgView1.image =  [SDImageCache.sharedImageCache imageFromMemoryCacheForKey:@"key_1234"];
            }];
        }else {
            NSLog(@"有缓存,直接取值");
            imgView1.image =  [SDImageCache.sharedImageCache imageFromMemoryCacheForKey:@"key_1234"];
        }
    }];
    
    
    [self _lastLoadBottomAttribute];
    
    
}

@end
