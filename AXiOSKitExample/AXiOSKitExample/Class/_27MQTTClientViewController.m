//
//  _27MQTTClientViewController.m
//  AXiOSKitExample
//
//  Created by 小星星吃KFC on 2020/10/19.
//  Copyright © 2020 liuweixing. All rights reserved.
//

#import "_27MQTTClientViewController.h"
#import <MQTTClient/MQTTClient.h>
#import <MQTTClient/MQTTClient.h>
#import <MQTTClient/MQTTSessionManager.h>
#import <MQTTClient/MQTTWebsocketTransport.h>
#import <Masonry/Masonry.h>
#import <AXiOSKit/AXiOSKit.h>
#import <MJExtension/MJExtension.h>

@interface _27MQTTClientViewController ()<MQTTSessionManagerDelegate,MQTTSessionDelegate>

@property (strong, nonatomic) NSDictionary *mqttSettings;
@property (strong, nonatomic) NSString *base;
@property (strong, nonatomic) MQTTSessionManager *manager;
@property (strong, nonatomic)  UILabel *statusLabel;
@property(nonatomic, strong) MQTTSession *session;
@end

@implementation _27MQTTClientViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    
    UIView *topView = self.view;
    {
        UILabel *label = [UILabel.alloc init];
        label.backgroundColor = UIColor.orangeColor;
        [self.view addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(30);
            make.top.equalTo(topView).mas_equalTo(30);
        }];
        topView =label;
        self.statusLabel = label;
        
    }
    {
        UIButton *btn1 = [[UIButton alloc]init];
        [btn1 setTitle:@"发送" forState:UIControlStateNormal];
        btn1.backgroundColor = UIColor.orangeColor;
        [self.view addSubview:btn1];
        [btn1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(30);
            make.top.equalTo(topView.mas_bottom).mas_equalTo(30);
        }];
        
        [btn1 ax_addTargetBlock:^(UIButton * _Nullable button) {
            
            NSData *publishData =  [@"iOS-内容" dataUsingEncoding:NSUTF8StringEncoding];
            [self.session publishData:publishData onTopic:@"id1" retain:NO qos:MQTTQosLevelExactlyOnce publishHandler:^(NSError *error) {
            }];
            
        }];
        topView =btn1;
    }
    
    
    MQTTWebsocketTransport *transport = [[MQTTWebsocketTransport alloc] init];
    transport.url = [NSURL URLWithString:@"ws://localhost:15675/ws"];
    
    self.session = [[MQTTSession alloc] init];
    self.session.transport = transport;
    self.session.delegate = self;
    [self.session connectWithConnectHandler:^(NSError *error) {
        NSLog(@"mqtt链接 = %@",!error ? @"成功":@"失败");
        [self.session subscribeToTopic:@"id1" atLevel:MQTTQosLevelExactlyOnce];
    }];
    
    [self.session addObserver:self
                   forKeyPath:@"status"
                      options:NSKeyValueObservingOptionInitial | NSKeyValueObservingOptionNew
                      context:nil];
    
}
- (void)newMessage:(MQTTSession *)session data:(NSData *)data onTopic:(NSString *)topic qos:(MQTTQosLevel)qos retained:(BOOL)retained mid:(unsigned int)mid {

    
    NSLog(@"A: topic = %@,retained = %d, 内容 = %@,mid = %u",topic,retained,[data ax_toJson],mid);
    
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    
    switch (self.session.status) {
        case MQTTSessionStatusCreated:
            self.statusLabel.text = @"Created";
            //            self.disconnect.enabled = false;
            //            self.connect.enabled = false;
            break;
        case MQTTSessionStatusConnecting:
            self.statusLabel.text = @"Connecting";
            //            self.disconnect.enabled = false;
            //            self.connect.enabled = false;
            break;
        case MQTTSessionStatusConnected:
            self.statusLabel.text = @"Connected";
            //            self.disconnect.enabled = true;
            //            self.connect.enabled = false;
            //            [self.manager sendData:[@"joins chat" dataUsingEncoding:NSUTF8StringEncoding]
            //                             topic:[NSString stringWithFormat:@"%@/%@-%@",
            //                                    self.base,
            //                                    [UIDevice currentDevice].name,
            //                                    self.tabBarItem.title]
            //                               qos:MQTTQosLevelExactlyOnce
            //                            retain:FALSE];
            
            break;
        case MQTTSessionStatusDisconnecting:
            self.statusLabel.text = @"Disconnecting";
            //            self.disconnect.enabled = false;
            //            self.connect.enabled = false;
            break;
        case MQTTSessionStatusClosed:
            self.statusLabel.text = @"Closed";
            //            self.disconnect.enabled = false;
            //            self.connect.enabled = false;
            break;
        case MQTTSessionStatusError:
            self.statusLabel.text = @"Erro";
            //            self.disconnect.enabled = false;
            //            self.connect.enabled = false;
            break;
        default:
            self.statusLabel.text = @"无";
            //            self.disconnect.enabled = false;
            //            self.connect.enabled = true;
            break;
    }
}
@end
