//
//  ChatViewController.m
//  AXiOSKitExample
//
//  Created by liuweixing on 2020/1/5.
//  Copyright © 2020 liu.weixing. All rights reserved.
//

#import "_02ChatViewController.h"
//#import <AXiOSKit/AXWebSocketEngine.h>
//#import "NSObject+AXKit.h"
#import "AXiOSKit/AXiOSKit.h"
#import "AXiOSKit/AXiOSFoundation.h"

#import "AXWebSocketEngine.h"
#import "ChatTextMessageModel.h"
#import <MJExtension/MJExtension.h>
@interface _02ChatViewController ()
@property (weak, nonatomic) IBOutlet UILabel *fromLabel;
@property (weak, nonatomic) IBOutlet UILabel *toLabel;

@property (weak, nonatomic) IBOutlet UITextField *sendTF;

@end

@implementation _02ChatViewController


#define USER_A 100
#define USER_B 200


//#define USER_A 200
//#define USER_B 100

- (IBAction)sendAction:(id)sender {
    /// amqp://localhost:15675/ws
    NSString *url = @"ws://localhost:1883/ws";

    [AXWebSocketEngine.shared connectServer:url];
    
    
//    ChatTextMessageModel *model = [[ChatTextMessageModel alloc]init];
//    model.userid = USER_A;
//    model.toUserId = USER_B;
//    model.content = self.sendTF.text;
//
//    NSString *msg =[model mj_JSONString];
//
//    AXWebSocketEngine.shared.sendMesssage = msg;
//    self.toLabel.text = model.content;
//    self.sendTF.text = nil;;
}
- (void)injected {
    NSLog(@"重启了 InjectionIII: %@", self);
    [self viewDidLoad];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"聊天";
//    NSString *url = @"mqtt://localhost:1883/ws/id1";
//    NSString *url = @"ws://localhost:15675/ws?topic=id1";
//
//    [AXWebSocketEngine.shared connectServer:url];
//
//    AXWebSocketEngine.shared.didReceiveMessage = ^(NSString   * _Nonnull message) {
//        NSLog(@"message>> %@",message);
//       ChatTextMessageModel *model = [ChatTextMessageModel mj_objectWithKeyValues:message];
//         NSLog(@"model>> %@",model);
//         NSLog(@"model.content>> %@",model.content);
//
//        self.fromLabel.text = model.content;
//    };
    
    UIView *aView = [UIView.alloc init];
    [self.view addSubview:aView];
    aView.backgroundColor = UIColor.orangeColor;
    
    [aView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.leading.equalTo(@0);
                make.width.mas_equalTo(self.view);
        make.height.mas_offset(200);
//                make.top.equalTo(self.yq_safe_top);
                make.bottom.equalTo(self.yq_safe_bottom);
            }];
    
}


- (MASViewAttribute *)yq_safe_top {
    if (@available(iOS 11.0, *)) {
        return self.view.mas_safeAreaLayoutGuideTop;
    } else {
        // Fallback on earlier versions
        return self.mas_topLayoutGuideBottom;
    }
}

- (MASViewAttribute *)yq_safe_bottom {
    if (@available(iOS 11.0, *)) {
        return self.view.mas_safeAreaLayoutGuideBottom;
    } else {
        // Fallback on earlier versions
        return self.mas_bottomLayoutGuideTop;
    }
}


@end
