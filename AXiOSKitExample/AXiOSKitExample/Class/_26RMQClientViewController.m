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
@property(nonatomic, strong)  RMQConnection * conn;
@end

@implementation _26RMQClientViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSURL *URL = [NSURL URLWithString:@"http://test:test@localhost:15675/ws"];
    
    URL.host;
    
//    [self receive];
    
}
- (void)receive
{

//    RMQConnection * conn = [[RMQConnection alloc] initWithUri:@"http://localhost:15672/ws" delegate:[RMQConnectionDelegateLogger new]];
//    RMQConnection * conn = [[RMQConnection alloc] initWithDelegate:[RMQConnectionDelegateLogger new]];
//    ws://localhost:15675/ws
    RMQConnection * conn = [[RMQConnection alloc] initWithUri:@"http://test:test@localhost:15675/ws" delegate:[RMQConnectionDelegateLogger new]];
    [conn start:^{
        
    }];
    id<RMQChannel>channel = [conn createChannel];
    RMQQueue * queue = [channel queue:@"id1"];
    [queue subscribe:^(RMQMessage * _Nonnull message) {
        NSLog(@"message:%@",[[NSString alloc] initWithData:message.body encoding:NSUTF8StringEncoding]);
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

    
    RMQConnection * conn = [[RMQConnection alloc] initWithUri:@"http://test:test@localhost:15675/ws" delegate:[RMQConnectionDelegateLogger new]];
    self.conn = conn;
    
    [self.conn start:^{
        id<RMQChannel>channel = [self.conn createChannel];
        RMQExchange * exchange = [channel topic:@"id1" options:RMQExchangeDeclarePassive];
        [exchange publish:[@"内容" dataUsingEncoding:NSUTF8StringEncoding] routingKey:@"id1"];
//        [self.conn close];
    }];
      
    
}


@end
