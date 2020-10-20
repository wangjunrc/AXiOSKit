//
//  _26RMQClientViewController.m
//  AXiOSKitExample
//
//  Created by 小星星吃KFC on 2020/10/19.
//  Copyright © 2020 liuweixing. All rights reserved.
//

#import "_26RMQClientViewController.h"
#import <RMQClient/RMQClient.h>

@interface _26RMQClientViewController ()
@property (weak, nonatomic) IBOutlet UITextField *tf;
@property(nonatomic, strong)  RMQConnection * connection;

@property(nonatomic, strong) RMQConnectionDelegateLogger *connectionDelegate;
@end

@implementation _26RMQClientViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSURL *URL = [NSURL URLWithString:@"http://test:test@localhost:15675/ws"];
    
 
//    [self receive];
    
}
- (void)receive
{

//    RMQConnection * conn = [[RMQConnection alloc] initWithUri:@"http://localhost:15672/ws" delegate:[RMQConnectionDelegateLogger new]];
//    RMQConnection * conn = [[RMQConnection alloc] initWithDelegate:[RMQConnectionDelegateLogger new]];
    /// ws://localhost:15675/ws
    RMQConnection * conn = [[RMQConnection alloc] initWithUri:@"http://guest:guest@localhost:15675/ws" delegate:[RMQConnectionDelegateLogger new]];
    [conn start];
    id<RMQChannel>channel = [conn createChannel];
    RMQQueue * queue = [channel queue:@"id1"];
    [queue subscribe:^(RMQMessage * _Nonnull message) {
        NSLog(@"接收消息 = %@",[[NSString alloc] initWithData:message.body encoding:NSUTF8StringEncoding]);
    }];
    
}


- (IBAction)send:(id)sender {
    
//    RMQConnection * conn = [[RMQConnection alloc] initWithUri:@"ws://localhost:15675/ws" delegate:[RMQConnectionDelegateLogger new]];
//    RMQConnection * conn = [[RMQConnection alloc] initWithDelegate:[RMQConnectionDelegateLogger new]];
//    RMQConnection * conn = [[RMQConnection alloc] initWithUri:@"http://test:test@localhost:15675/ws" delegate:[RMQConnectionDelegateLogger new]];
//    [self initWithUri:@"amqp://guest:guest@localhost" delegate:delegate];
    
//    RMQConnection *conn = [[RMQConnection alloc] initWithUri:@"mqtt://localhost:1883/ws"
//                                                    delegate:[RMQConnectionDelegateLogger new]];
    
//    self.conn = conn;
//    [conn start];
//    id<RMQChannel>channel = [conn createChannel];
//
//    RMQQueue * queue = [channel queue:@"id1"];
//
//    [channel.defaultExchange publish:[@"内容" dataUsingEncoding:NSUTF8StringEncoding] routingKey:queue.name];
//    [conn close];

  NSData *publishData =  [@"iOS-内容" dataUsingEncoding:NSUTF8StringEncoding];

    RMQConnection * connection = [[RMQConnection alloc] initWithUri:@"amqp://localhost:5672/ws" delegate:[RMQConnectionDelegateLogger.alloc init]];
    self.connection =connection;
    [connection start];
    id<RMQChannel>channel = [connection createChannel];
//    RMQExchange * exchange = [channel topic:@"id1" options:RMQExchangeDeclarePassive];
    
    RMQExchange * exchange =  [channel topic:@"id1"];
//    channel.defaultExchange
//    [exchange publish:publishData routingKey:nil];
    [exchange publish:publishData];
    [connection close];
    
}




/////socket 连接失败回调，超时或者地址有误
//- (void)connection:(RMQConnection *)connection failedToConnectWithError:(NSError *)error;
///// 没有连接成功回调
//- (void)connection:(RMQConnection *)connection disconnectedWithError:(NSError *)error;
///// 自动恢复连接调用
//- (void)willStartRecoveryWithConnection:(RMQConnection *)connection;
///// 正在开始恢复连接
//- (void)startingRecoveryWithConnection:(RMQConnection *)connection;
///// 已经恢复连接的时候，调用
//- (void)recoveredConnection:(RMQConnection *)connection;
///// 连接过程中，信道异常调用
//- (void)channel:(id<RMQChannel>)channel error:(NSError *)error;
//

@end
