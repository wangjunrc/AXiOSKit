//
//  WebSocketManager.h
//  AXiOSToolsExample
//
//  Created by AXing on 2019/3/13.
//  Copyright © 2019 liu.weixing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SocketRocket.h"

typedef NS_ENUM(NSUInteger,WebSocketConnectType){
    WebSocketDefault = 0, //初始状态,未连接
    WebSocketConnect,      //已连接
    WebSocketDisconnect    //连接后断开
};


NS_ASSUME_NONNULL_BEGIN

@interface WebSocketManager : NSObject

@property (nonatomic, strong) SRWebSocket *webSocket;

@property (nonatomic, assign)   BOOL isConnect;  //是否连接
@property (nonatomic, assign)   WebSocketConnectType connectType;

+(instancetype)shared;
- (void)connectServer;//建立长连接
- (void)reConnectServer;//重新连接
- (void)RMWebSocketClose;//关闭长连接
- (void)sendDataToServer:(NSString *)data;//发送数据给服务器
/**接收到消息*/
@property (nonatomic, copy) void(^didReceiveMessage)(id message);
@end

NS_ASSUME_NONNULL_END
