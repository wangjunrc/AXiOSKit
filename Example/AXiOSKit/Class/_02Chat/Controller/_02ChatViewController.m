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

- (void)viewDidLoad {
    [super viewDidLoad];
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
}



@end
