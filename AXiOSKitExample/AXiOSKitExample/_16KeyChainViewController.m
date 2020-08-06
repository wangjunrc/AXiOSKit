//
//  _16KeyChainViewController.m
//  AXiOSKitExample
//
//  Created by 小星星吃KFC on 2020/8/3.
//  Copyright © 2020 liuweixing. All rights reserved.
//

#import "_16KeyChainViewController.h"
#import <Masonry/Masonry.h>
#import <AXiOSKit/AXiOSKit.h>
#import <SSKeychain/SSKeychain.h>

@interface _16KeyChainViewController ()

@property (strong, nonatomic) NSDictionary *query;

@end

@implementation _16KeyChainViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = UIColor.whiteColor;

    UIButton *btn = UIButton.alloc.init;
    [btn setTitle:@"get" forState:UIControlStateNormal];
    btn.backgroundColor = UIColor.orangeColor;
    [self.view addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(100);
        make.top.mas_equalTo(100);
    }];
    [btn ax_addActionBlock:^(UIButton *_Nullable button) {
        NSString *pas =    [SSKeychain passwordForService:@"com.ax.group" account:@"user"];
        AXLoger(@"%@", pas);
    }];

    UIButton *btn2 = UIButton.alloc.init;
    [btn2 setTitle:@"set" forState:UIControlStateNormal];
    btn2.backgroundColor = UIColor.orangeColor;
    [self.view addSubview:btn2];
    [btn2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(100);
        make.top.equalTo(btn.mas_bottom).offset(10);
    }];
    [btn2 ax_addActionBlock:^(UIButton *_Nullable button) {
        AXLoger(@"%@", [NSBundle mainBundle].bundleIdentifier);
        NSError *error = nil;
        BOOL result = [ SSKeychain setPassword:@"abc123" forService:@"com.ax.group" account:@"user" error:&error];
        AXLoger(@"result = %d", result);
    }];
}

static NSString *const KEYCHAIN_SERVICE = @"flutter_keychain";


- (instancetype)init {
    self = [super init];
    if (self){
        self.query = @{
            (__bridge id)kSecClass :(__bridge id)kSecClassGenericPassword,
            (__bridge id)kSecAttrService :KEYCHAIN_SERVICE,
        };
    }
    return self;
}

static NSString *const getDeviceIDKey = @"getDeviceIDKey";


-(NSString *)getDeviceID{
    
  NSString *value = [self get:getDeviceIDKey];
    if (value.length==0) {
        value = [self ax_uuid];
        [self set:value forKey:getDeviceIDKey];
    }
    
    return value;
}

/// 生成uuid
-(NSString *)ax_uuid{
    CFUUIDRef uuidRef = CFUUIDCreate(NULL);
    CFStringRef uuidStrRef= CFUUIDCreateString(NULL, uuidRef);
    CFRelease(uuidRef);
    NSString *uuidStr = (__bridge NSString *)uuidStrRef;
    CFRelease(uuidStrRef);
    return uuidStr;
}



///============================通用key========================================
- (NSString *)get:(NSString *)key {
    NSMutableDictionary *search = [self.query mutableCopy];
    search[(__bridge id)kSecAttrAccount] = key;
    search[(__bridge id)kSecReturnData] = (__bridge id)kCFBooleanTrue;

    CFDataRef resultData = NULL;

    OSStatus status;
    status = SecItemCopyMatching((__bridge CFDictionaryRef)search, (CFTypeRef*)&resultData);
    NSString *value;
    if (status == noErr){
        NSData *data = (__bridge NSData*)resultData;
        value = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    }
    return value;
}


- (void)set:(NSString *)value forKey:(NSString *)key {
    NSMutableDictionary *search = [self.query mutableCopy];
    search[(__bridge id)kSecAttrAccount] = key;
    search[(__bridge id)kSecMatchLimit] = (__bridge id)kSecMatchLimitOne;

    OSStatus status;
    status = SecItemCopyMatching((__bridge CFDictionaryRef)search, NULL);
    if (status == noErr){
        search[(__bridge id)kSecMatchLimit] = nil;

        NSDictionary *update = @{(__bridge id)kSecValueData: [value dataUsingEncoding:NSUTF8StringEncoding]};

        status = SecItemUpdate((__bridge CFDictionaryRef)search, (__bridge CFDictionaryRef)update);
        if (status != noErr){
            NSLog(@"SecItemUpdate status = %d", status);
        }
    }else{
        search[(__bridge id)kSecValueData] = [value dataUsingEncoding:NSUTF8StringEncoding];
        search[(__bridge id)kSecMatchLimit] = nil;

        status = SecItemAdd((__bridge CFDictionaryRef)search, NULL);
        if (status != noErr){
            NSLog(@"SecItemAdd status = %d", status);
        }
    }
}

- (void)remove:(NSString *)key {
    NSMutableDictionary *search = [self.query mutableCopy];
    search[(__bridge id)kSecAttrAccount] = key;
    search[(__bridge id)kSecReturnData] = (__bridge id)kCFBooleanTrue;
    SecItemDelete((__bridge CFDictionaryRef)search);
}

- (void)clear {
    NSMutableDictionary *search = [self.query mutableCopy];
    SecItemDelete((__bridge CFDictionaryRef)search);
}



@end
