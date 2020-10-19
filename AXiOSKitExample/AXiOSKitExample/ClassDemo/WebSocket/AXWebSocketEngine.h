//
//  AXWebSocketEngine.h
//  AXiOSKit
//
//  Created by liuweixing on 2020/1/5.
//  Copyright © 2020 liu.weixing. All rights reserved.
//

#import <Foundation/Foundation.h>



typedef NS_ENUM(NSUInteger,WebSocketConnectType){
    WebSocketDefault = 0, //初始状态,未连接
    WebSocketConnect,      //已连接
    WebSocketDisconnect    //连接后断开
};


NS_ASSUME_NONNULL_BEGIN

@interface AXWebSocketEngine : NSObject

@property (class, nonatomic, readonly, strong)AXWebSocketEngine *shared;

@property (nonatomic, assign)   BOOL isConnect;  //是否连接
@property (nonatomic, assign)   WebSocketConnectType connectType;


/// 建立长连接
/// :@"ws://localhost:8080/chat/%ld"
- (void)connectServer:(NSString *)wsURL;
- (void)reConnectServer;//重新连接
- (void)RMWebSocketClose;//关闭长连接

/**发送数据给服务器*/
@property (nonatomic, copy) NSString *sendMesssage;

/**接收到消息*/
@property (nonatomic, copy) void(^didReceiveMessage)(id message);

@end

NS_ASSUME_NONNULL_END

//#endif
