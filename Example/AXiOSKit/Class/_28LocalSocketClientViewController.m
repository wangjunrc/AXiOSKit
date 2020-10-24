//
//  _28LocalSocketClientViewController.m
//  AXiOSKit_Example
//
//  Created by 小星星吃KFC on 2020/10/24.
//  Copyright © 2020 axinger. All rights reserved.
//

#import "_28LocalSocketClientViewController.h"
#import <arpa/inet.h>
#import <netdb.h>
#import <sys/types.h>
#import <sys/socket.h>
#import <ifaddrs.h>
@interface _28LocalSocketClientViewController ()

@property (nonatomic, assign) int sock;

@end

@implementation _28LocalSocketClientViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    UIView *topView = self.view;
    {
        UIButton *btn1 = [[UIButton alloc]init];
        [btn1 ax_setTitleStateNormal:@"链接"];
        btn1.backgroundColor = UIColor.orangeColor;
        [self.view addSubview:btn1];
        [btn1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.mas_equalTo(30);
            
        }];
        __weak typeof(self) weakSelf = self;
        [btn1 ax_addTargetBlock:^(UIButton * _Nullable button) {
            __strong typeof(weakSelf) self = weakSelf;
            
            [self connectToService];
        }];
        topView = btn1;
    }
    {
        UIButton *btn1 = [[UIButton alloc]init];
        [btn1 ax_setTitleStateNormal:@"发送"];
        btn1.backgroundColor = UIColor.orangeColor;
        [self.view addSubview:btn1];
        [btn1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(30);
            make.top.equalTo(topView.mas_bottom).mas_equalTo(30);
        }];
        __weak typeof(self) weakSelf = self;
        [btn1 ax_addTargetBlock:^(UIButton * _Nullable button) {
            __strong typeof(weakSelf) self = weakSelf;
            
            [self senddata];
        }];
    }
}

- (void)connectToService {
    
    NSString *host = [self getIPAddress];
    NSNumber *port = @12345;
    
    // 1，创建socket
    int sock = socket(AF_INET, SOCK_STREAM, 0);
    if (sock == -1) {
        
        NSLog(@"socket error : %d",sock);
        return;
    }
    // 2,获取ip地址
    // 返回对应于给定主机名的包含主机名字和地址信息的hostent结构指针
    struct hostent *remoteHostEnt = gethostbyname([host UTF8String]);
    if (remoteHostEnt == NULL) {
        
        close(sock);
        NSLog(@"无法解析服务器主机名");
        return;
    }
    //
    struct in_addr *remoteInAddr = (struct in_addr *)remoteHostEnt->h_addr_list[0];
    struct sockaddr_in socketParam;
    socketParam.sin_family = AF_INET;
    socketParam.sin_addr = *remoteInAddr;
    socketParam.sin_port = htons([port intValue]);
    
    // 连接socket
    /*
     * 第二个参数为套接字想要连接的主机地址和端口
     */
    int con = connect(sock, (struct sockaddr *) &socketParam, sizeof(socketParam));
    if (con == -1) {
        
        close(sock);
        NSLog(@"连接失败");
        return;
    }
    NSLog(@"连接成功");
    self.sock = sock;
    
    // 开启一个子线程用于接收数据
    NSThread *recvThread = [[NSThread alloc] initWithTarget:self selector:@selector(recvData) object:nil];
    [recvThread start];
    
}
- (void)senddata {
    
    char sendData[32] = "hello service";
    ssize_t size_t = send(self.sock, sendData, strlen(sendData), 0);
    NSLog(@"%zd",size_t);
}

- (void)recvData{
    
    ssize_t bytesRecv = -1;
    char recvData[32] = "";
    while (1) {
        
        bytesRecv = recv(self.sock, recvData, 32, 0);
        NSLog(@"%zd %s",bytesRecv,recvData);
        if (bytesRecv == 0) {
            break;
        }
    }
}

// Get IP Address
- (NSString *)getIPAddress {
    NSString *address = @"error";
    struct ifaddrs *interfaces = NULL;
    struct ifaddrs *temp_addr = NULL;
    int success = 0;
    // retrieve the current interfaces - returns 0 on success
    success = getifaddrs(&interfaces);
    if (success == 0) {
        // Loop through linked list of interfaces
        temp_addr = interfaces;
        while(temp_addr != NULL) {
            if(temp_addr->ifa_addr->sa_family == AF_INET) {
                // Check if interface is en0 which is the wifi connection on the iPhone
                if([[NSString stringWithUTF8String:temp_addr->ifa_name] isEqualToString:@"en0"]) {
                    // Get NSString from C String
                    address = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_addr)->sin_addr)];
                }
            }
            temp_addr = temp_addr->ifa_next;
        }
    }
    // Free memory
    freeifaddrs(interfaces);
    NSLog(@"%@",address);
    return address;
}

@end
