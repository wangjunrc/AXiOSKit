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

@interface _27MQTTClientViewController ()<MQTTSessionManagerDelegate>

@property (strong, nonatomic) NSDictionary *mqttSettings;
@property (strong, nonatomic) NSString *base;
@property (strong, nonatomic) MQTTSessionManager *manager;
@property (strong, nonatomic)  UILabel *status;
@property(nonatomic, strong) MQTTSession *session;
@end

@implementation _27MQTTClientViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    
//    NSURL *bundleURL = [[NSBundle mainBundle] bundleURL];
//    NSURL *mqttPlistUrl = [bundleURL URLByAppendingPathComponent:@"mqtt.plist"];
//    self.mqttSettings = [NSDictionary dictionaryWithContentsOfURL:mqttPlistUrl];
//    self.base = self.mqttSettings[@"base"];
//
//
//
//
//    /*
//     * MQTTClient: create an instance of MQTTSessionManager once and connect
//     * will is set to let the broker indicate to other subscribers if the connection is lost
//     */
//    if (!self.manager) {
//        self.manager = [[MQTTSessionManager alloc] init];
//        self.manager.delegate = self;
//        self.manager.subscriptions = [NSDictionary dictionaryWithObject:[NSNumber numberWithInt:MQTTQosLevelExactlyOnce]
//                                                                 forKey:[NSString stringWithFormat:@"%@/#", self.base]];
//
//
//
//
//        [self.manager connectTo:self.mqttSettings[@"host"]
//                           port:[self.mqttSettings[@"port"] intValue]
//                            tls:[self.mqttSettings[@"tls"] boolValue]
//                      keepalive:60
//                          clean:true
//                           auth:false
//                           user:nil
//                           pass:nil
//                      willTopic:[NSString stringWithFormat:@"%@/%@-%@",
//                                 self.base,
//                                 [UIDevice currentDevice].name,
//                                 self.tabBarItem.title]
//                           will:[@"offline" dataUsingEncoding:NSUTF8StringEncoding]
//                        willQos:MQTTQosLevelExactlyOnce
//                 willRetainFlag:FALSE
//                   withClientId:nil];
//    } else {
//        [self.manager connectToLast];
//    }
//
//    /*
//     * MQTTCLient: observe the MQTTSessionManager's state to display the connection status
//     */
//
//    [self.manager addObserver:self
//                   forKeyPath:@"state"
//                      options:NSKeyValueObservingOptionInitial | NSKeyValueObservingOptionNew
//                      context:nil];
    
    
    MQTTCFSocketTransport *transport = [[MQTTCFSocketTransport alloc] init];
    transport.host = @"mqtt://localhost";
    transport.port = 1883;
        
    self.session = [[MQTTSession alloc] init];
    self.session.transport = transport;
    [self.session connectWithConnectHandler:^(NSError *error) {
        NSLog(@"error = %@",error);
    }];

}


- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    switch (self.manager.state) {
        case MQTTSessionManagerStateClosed:
            self.status.text = @"closed";
//            self.disconnect.enabled = false;
//            self.connect.enabled = false;
            break;
        case MQTTSessionManagerStateClosing:
            self.status.text = @"closing";
//            self.disconnect.enabled = false;
//            self.connect.enabled = false;
            break;
        case MQTTSessionManagerStateConnected:
            self.status.text = [NSString stringWithFormat:@"connected as %@-%@",
                                [UIDevice currentDevice].name,
                                self.tabBarItem.title];
//            self.disconnect.enabled = true;
//            self.connect.enabled = false;
            [self.manager sendData:[@"joins chat" dataUsingEncoding:NSUTF8StringEncoding]
                             topic:[NSString stringWithFormat:@"%@/%@-%@",
                                    self.base,
                                    [UIDevice currentDevice].name,
                                    self.tabBarItem.title]
                               qos:MQTTQosLevelExactlyOnce
                            retain:FALSE];

            break;
        case MQTTSessionManagerStateConnecting:
            self.status.text = @"connecting";
//            self.disconnect.enabled = false;
//            self.connect.enabled = false;
            break;
        case MQTTSessionManagerStateError:
            self.status.text = @"error";
//            self.disconnect.enabled = false;
//            self.connect.enabled = false;
            break;
        case MQTTSessionManagerStateStarting:
        default:
            self.status.text = @"not connected";
//            self.disconnect.enabled = false;
//            self.connect.enabled = true;
            break;
    }
}
@end
