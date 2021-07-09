//
//  _22LoginViewModel.m
//  AXiOSKit_Example
//
//  Created by 小星星吃KFC on 2021/7/9.
//  Copyright © 2021 axinger. All rights reserved.
//

#import "_22LoginViewModel.h"

@interface _22LoginViewModel ()

@property (nonatomic,strong) RACCommand *loginCommand;

@end

@implementation _22LoginViewModel

- (instancetype)init {
    
    self = [super init];
    
    if (!self) {
        return nil;
    }
    
    @weakify(self)
    self.loginCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        
        @strongify(self)
        return [self loginWithUsername:self.username password:self.password];
        
        
    }];
    
    
    return self;
    
}

//有效性判断
- (RACSignal *)validateLoginInputs {
    
    return [RACSignal combineLatest:@[RACObserve(self, username), RACObserve(self, password)] reduce:^id(NSString *username,NSString *password){
        return @(username.length > 0 && password.length > 0);
    }];
    
}

//真正登录的执行代码
- (RACSignal *)loginWithUsername:(NSString *)username password:(NSString *)password {
    
    return [[[RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        NSLog(@"beigin login");
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [subscriber sendNext:@"login"];
            [subscriber sendCompleted];
            NSLog(@"end login");
        });
        return nil;
    }] publish] autoconnect];
}
@end
