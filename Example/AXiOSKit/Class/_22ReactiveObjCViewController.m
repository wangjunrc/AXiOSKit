//
//  _22ReactiveObjCViewController.m
//  AXiOSKitExample
//
//  Created by 小星星吃KFC on 2020/9/24.
//  Copyright © 2020 liuweixing. All rights reserved.
//

#import "_22ReactiveObjCViewController.h"
#import <ReactiveObjC/ReactiveObjC.h>
#import <Masonry/Masonry.h>
#import <AXiOSKit/AXiOSKit.h>




@interface NSString (EmailAdditions)


- (BOOL)isValidEmail;
@end


@implementation NSString (EmailAdditions)

- (BOOL)isValidEmail {
    NSString *emailPattern =
    @"(?:[a-z0-9!#$%\\&'*+/=?\\^_`{|}~-]+(?:\\.[a-z0-9!#$%\\&'*+/=?\\^_`{|}"
    @"~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\"
    @"x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[a-z0-9](?:[a-"
    @"z0-9-]*[a-z0-9])?\\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\\[(?:(?:25[0-5"
    @"]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-"
    @"9][0-9]?|[a-z0-9-]*[a-z0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21"
    @"-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])";
    NSError *error = nil;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:emailPattern options:NSRegularExpressionCaseInsensitive error:&error];
    NSTextCheckingResult *match = [regex firstMatchInString:self options:0 range:NSMakeRange(0, [self length])];
    return match != nil;
}

@end


@interface SubscribeViewModel : NSObject

@property(nonatomic, strong) RACCommand *subscribeCommand;

// write to this property
@property(nonatomic, strong) NSString *email;

// read from this property
@property(nonatomic, strong) NSString *statusMessage;

@end



static NSString *const kSubscribeURL = @"http://reactivetest.apiary.io/subscribers";

@interface SubscribeViewModel ()
@property(nonatomic, strong) RACSignal *emailValidSignal;
@end

@implementation SubscribeViewModel

- (id)init {
    self = [super init];
    if (self) {
        [self mapSubscribeCommandStateToStatusMessage];
    }
    return self;
}

- (void)mapSubscribeCommandStateToStatusMessage {
    RACSignal *startedMessageSource = [self.subscribeCommand.executionSignals map:^id(RACSignal *subscribeSignal) {
        NSLog(@"请求=========发送");
        
        return @"请求=========发送";
    }];
    
    
    
    RACSignal *completedMessageSource = [self.subscribeCommand.executionSignals flattenMap:^RACSignal *(RACSignal *subscribeSignal) {
        
        NSLog(@"请求=========收到 %@",subscribeSignal);
        
        return [[[subscribeSignal materialize] filter:^BOOL(RACEvent *event) {
            
            
            return event.eventType == RACEventTypeCompleted;
        }] map:^id(id value) {
            
            NSString *str = @"tom";
            
            __block typeof(str)strB = str;
            [subscribeSignal subscribeNext:^(NSDictionary *x) {
                NSLog(@"请求=========发送  %@",x);
                if ([x isKindOfClass:NSDictionary.class]) {
                    strB = x[@"myname"];
                }
                
            }];
            
            
            return str;
            
        }];
        
        
        
    }];
    
    
    RACSignal *failedMessageSource = [[self.subscribeCommand.errors subscribeOn:[RACScheduler mainThreadScheduler]] map:^id(NSError *error) {
        
        NSLog(@"请求=========失败 %@",error);
        return @"请求=========失败";
    }];
    
    RAC(self, statusMessage) = [RACSignal merge:@[startedMessageSource, completedMessageSource, failedMessageSource]];
}

- (RACCommand *)subscribeCommand {
    if (!_subscribeCommand) {
        @weakify(self);
        /// 判断按钮的 是否可用 根据 emailValidSignal
        _subscribeCommand = [[RACCommand alloc] initWithEnabled:self.emailValidSignal signalBlock:^RACSignal *(id input) {
            @strongify(self);
            return [SubscribeViewModel postEmail:self.email];
        }];
    }
    return _subscribeCommand;
}

+ (RACSignal *)postEmail:(NSString *)email {
    
    return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            int num = arc4random() % 10;
            if ((num%2)==0) {
                
                [subscriber sendNext:@{@"myname" : @"jim"}];
                [subscriber sendCompleted];
            }else{
                [subscriber sendError:nil];
            }
        });
        return [RACDisposable disposableWithBlock:^{
            
        }];
        
    }];
    
    
}

- (RACSignal *)emailValidSignal {
    if (!_emailValidSignal) {
        _emailValidSignal = [RACObserve(self, email) map:^id(NSString *email) {
            return @([email isValidEmail]);
        }];
    }
    return _emailValidSignal;
}

@end





@interface _22ReactiveObjCViewController ()

@property(nonatomic, strong) SubscribeViewModel *viewModel;

@property(nonatomic, strong) UITextField *emailTextField;
@property(nonatomic, strong) UIButton *subscribeButton;
@property(nonatomic, strong) UILabel *statusLabel;

@end

@implementation _22ReactiveObjCViewController


#pragma mark - Life cycle methods

- (id)init {
    self = [super init];
    if (self) {
        self.viewModel = [SubscribeViewModel new];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = NSLocalizedString(@"Subscribe Example", nil);
    
    [self addViews];
    [self defineLayout];
    [self bindWithViewModel];
}

#pragma mark -

- (void)addViews {
    [self.view addSubview:self.emailTextField];
    [self.view addSubview:self.subscribeButton];
    [self.view addSubview:self.statusLabel];
}

- (void)defineLayout {
    @weakify(self);
    
    [self.emailTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.top.equalTo(self.view).with.offset(100.f);
        make.left.equalTo(self.view).with.offset(20.f);
        make.height.equalTo(@50.f);
    }];
    
    [self.subscribeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.centerY.equalTo(self.emailTextField);
        make.right.equalTo(self.view).with.offset(-25.f);
        make.width.equalTo(@70.f);
        make.height.equalTo(@30.f);
        make.left.equalTo(self.emailTextField.mas_right).with.offset(20.f);
    }];
    
    [self.statusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.top.equalTo(self.emailTextField.mas_bottom).with.offset(20.f);
        make.left.equalTo(self.emailTextField);
        make.right.equalTo(self.subscribeButton);
        make.height.equalTo(@30.f);
    }];
}

- (void)bindWithViewModel {
    RAC(self.viewModel, email) = self.emailTextField.rac_textSignal;
    self.subscribeButton.rac_command = self.viewModel.subscribeCommand;
    RAC(self.statusLabel, text) = RACObserve(self.viewModel, statusMessage);
}

#pragma mark - Views

- (UITextField *)emailTextField {
    if (!_emailTextField) {
        _emailTextField = [UITextField new];
        _emailTextField.borderStyle = UITextBorderStyleRoundedRect;
        _emailTextField.font = [UIFont boldSystemFontOfSize:16];
        _emailTextField.placeholder = NSLocalizedString(@"Email address", nil);
        _emailTextField.keyboardType = UIKeyboardTypeEmailAddress;
        _emailTextField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    }
    return _emailTextField;
}

- (UIButton *)subscribeButton {
    if (!_subscribeButton) {
        _subscribeButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [_subscribeButton setTitle:NSLocalizedString(@"Subscribe", nil) forState:UIControlStateNormal];
    }
    return _subscribeButton;
}

- (UILabel *)statusLabel {
    if (!_statusLabel) {
        _statusLabel = [UILabel new];
    }
    return _statusLabel;
}

@end

