//
//  _28LocalSocketServiceViewController.m
//  AXiOSKit_Example
//
//  Created by 小星星吃KFC on 2020/10/24.
//  Copyright © 2020 axinger. All rights reserved.
//

#import "_28LocalSocketServiceViewController.h"
#import <sys/types.h>
#import <sys/socket.h>
#import <ifaddrs.h>
#import <arpa/inet.h>
@interface _28LocalSocketServiceViewController ()

@property (nonatomic, assign) int newSocket;
@property (nonatomic, assign) int sock;

@property (nonatomic, strong) NSMutableArray *infoArray;

@end

@implementation _28LocalSocketServiceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(100, 200, 100, 50);
    [button setTitle:@"Start" forState:UIControlStateNormal];
    button.backgroundColor = [UIColor purpleColor];
    [button addTarget:self action:@selector(buttonDidClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    
    UIButton *button2 = [UIButton buttonWithType:UIButtonTypeCustom];
    button2.frame = CGRectMake(100, 400, 100, 50);
    [button2 setTitle:@"send" forState:UIControlStateNormal];
    button2.backgroundColor = [UIColor purpleColor];
    [button2 addTarget:self action:@selector(sendMessage) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button2];
    
    self.infoArray = [[NSMutableArray alloc] init];
}

- (void)buttonDidClick{
    
    // 1，创建socket
    int sock = socket(AF_INET, SOCK_STREAM, 0);
    [self.infoArray addObject:@"正在创建socket..."];
    [self.tableView reloadData];
    self.sock = sock;
    if (self.sock == -1) {
        
        close(self.sock);
        NSLog(@"socket error : %d",self.sock);
        [self.infoArray addObject:@"创建socket失败..."];
        [self.tableView reloadData];
        return;
    }
    // 2，绑定端口号
    struct sockaddr_in client;
    client.sin_family = AF_INET;
    NSString *ipStr = [self getIPAddress];
    const char *ip = [ipStr cStringUsingEncoding:NSASCIIStringEncoding];
    
    client.sin_addr.s_addr = inet_addr(ip);
    client.sin_port = htons(12345);

    int bd = bind(self.sock, (struct sockaddr *) &client, sizeof(client));
    [self.infoArray addObject:@"绑定固定端口..."];
    [self.tableView reloadData];
    if (bd == -1) {
        
        close(self.sock);
        NSLog(@"bind error : %d",bd);
        [self.infoArray addObject:@"绑定固定端口失败..."];
        [self.tableView reloadData];
        return;
    }

    // 3，监听
    int ls = listen(self.sock, 128);
    [self.infoArray addObject:@"监听端口号..."];
    [self.tableView reloadData];
    if (ls == -1) {
        
        close(self.sock);
        NSLog(@"listen error : %d",ls);
        [self.infoArray addObject:@"监听端口号失败..."];
        [self.tableView reloadData];
        return;
    }
    
    // 4,开启一个子线程用于数据的接收
    NSThread *recvThread = [[NSThread alloc] initWithTarget:self selector:@selector(recvData) object:nil];
    [recvThread start];

}

- (void)recvData{
    
    struct sockaddr_in rest;
    socklen_t rest_size = sizeof(struct sockaddr_in);
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [self.infoArray addObject:@"等待连接..."];
        [self.tableView reloadData];
    });
    self.newSocket = accept(self.sock, (struct sockaddr *) &rest, &rest_size);
    ssize_t bytesRecv = -1;
    char recvData[32] = "";
    // 如果一端断开连接，recv就不再阻塞，会马上返回，bytesrecv等于0，然后while循环就会一直执行
    while (1) {
        
        bytesRecv = recv(self.newSocket, recvData, 32, 0);
        NSLog(@"%zd %s",bytesRecv,recvData);
        __block NSString *dataStr = [NSString stringWithFormat:@"收到数据：%s",recvData];
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [self.infoArray addObject:dataStr];
            [self.tableView reloadData];
        });
        if (bytesRecv == 0) {
            
            break;
        }
        
    }
    
}

- (void)sendMessage{
    
    char sendData[32] = "hello client";
    ssize_t size_t = send(self.newSocket, sendData, strlen(sendData), 0);
    if (size_t > 0) {
        
        [self.infoArray addObject:[NSString stringWithFormat:@"发送数据:%s",sendData]];
        [self.tableView reloadData];
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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.infoArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *ID = @"identifiercell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    
    cell.textLabel.text = self.infoArray[indexPath.row];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 44;
}


@end
