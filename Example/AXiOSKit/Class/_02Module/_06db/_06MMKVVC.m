//
//  _06MMKVVC.m
//  AXiOSKit
//
//  Created by 小星星吃KFC on 2021/7/29.
//  Copyright © 2021 axinger. All rights reserved.
//

#import "_06MMKVVC.h"
@import MMKV;

@interface _06MMKVVC ()

@end

@implementation _06MMKVVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self _titlelabel:@"MMKV.defaultMMKV"];
    [self _buttonTitle:@"setString" handler:^(UIButton * _Nonnull btn) {
        [MMKV.defaultMMKV setString:@"124" forKey:@"key_123"];
        
    }];
    
    [self _buttonTitle:@"getStringForKey" handler:^(UIButton * _Nonnull btn) {
        NSString *val = [MMKV.defaultMMKV getStringForKey:@"key_123"];
        NSLog(@"val=%@",val);
    }];
    
    
    [self _titlelabel:@"MMKV mmkvWithID"];
    [self _buttonTitle:@"ax_user-setString" handler:^(UIButton * _Nonnull btn) {
        [[MMKV mmkvWithID:@"ax_user.default"] setString:@"123" forKey:@"ax_user_key_123"];
    }];
    
    [self _buttonTitle:@"ax_user-getStringForKey" handler:^(UIButton * _Nonnull btn) {
        NSString *val = [[MMKV mmkvWithID:@"ax_user.default"] getStringForKey:@"ax_user_key_123"];
        NSLog(@"val=%@",val);
    }];
    
    [self _buttonTitle:@"ax_user-setString" handler:^(UIButton * _Nonnull btn) {
        [[MMKV mmkvWithID:@"ax_setting.default"] setString:@"abc" forKey:@"ax_user_key_123"];
    }];
    
    [self _buttonTitle:@"ax_user-getStringForKey" handler:^(UIButton * _Nonnull btn) {
        NSString *val = [[MMKV mmkvWithID:@"ax_setting.default"] getStringForKey:@"ax_user_key_123"];
        NSLog(@"val=%@",val);
    }];
    
    [self _buttonTitle:@"ax_setting-clearAll" handler:^(UIButton * _Nonnull btn) {
        [[MMKV mmkvWithID:@"ax_setting.default"] clearAll];
    }];
    
    [self _lastLoadBottomAttribute];
}


@end
