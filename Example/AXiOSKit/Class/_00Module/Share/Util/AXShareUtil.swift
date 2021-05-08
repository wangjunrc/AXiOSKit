//
//  AXShareUtil.swift
//  AXiOSKit
//
//  Created by 小星星吃KFC on 2021/4/26.
//  Copyright © 2021 axinger. All rights reserved.
//


import UIKit
import MonkeyKing


public typealias AXShareCompletionHandler = (_ result: Bool,_ error: Error?) -> Void

func error(code:Int, msg: String) -> NSError {
    return NSError(domain: "com.dl.mam.service.error",
                   code: code,
                   userInfo:[NSLocalizedDescriptionKey:msg])
}
func error(msg: String) -> NSError {
    return NSError(domain: "com.dl.mam.service.error",
                   code: -1,
                   userInfo:[NSLocalizedDescriptionKey:msg])
}


func actionResult(_ result:Result<MonkeyKing.ResponseJSON?, MonkeyKing.Error>, _ block:AXShareCompletionHandler? ) -> Void {
    
    switch result {
    case .success(_):
        block!(true,nil)
    case .failure(.noApp):
        block!(false,error(msg:"未安装app"))
    case .failure(.userCancelled):
        block!(false,error(msg:"用户取消操作"))
    case .failure(.resource(_)):
        block!(false,error(msg:"资源错误"))
    case .failure(.sdk(_)):
        block!(false,error(msg:"sdk错误"))
    case .failure(.apiRequest(_)):
        block!(false,error(msg:"api错误"))
    case .failure(.noAccount):
        block!(false,error(msg:"没有账号"))
    }
    
}


/// MonkeyKing 不支持oc调用,需要封装一层
/// oc 不知道怎么调用 MonkeyKing.framework
@objcMembers class AXShareUtil: NSObject {
    
    private let _weibo = AXShareWeibo()
    private let _weChat = AXShareWeChat()
    private let _qq = AXShareQQ()
    
    /// 表示当前类是否在使用,临时区分 handleOpenUrl
    var isStart: Bool = false
    
    ///  func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey: Any] = [:]) -> Bool
    func handleOpen(url: URL) -> Bool {
        if !isStart {
            return false
        }
        
        isStart = false
        return MonkeyKing.handleOpenURL(url)
    }
    /// func application(_ application: UIApplication, handleOpen url: URL) -> Bool
    func handleOpen(userActivity: NSUserActivity) -> Bool {
        return MonkeyKing.handleOpenUserActivity(userActivity)
    }

    /// 分享
    func  share(type: AXShareType ,item:AXShareInfoItem, block:AXShareCompletionHandler? ){
      
        if type.isEqual(to: AXShareTypeWeiChatSession) {
            
            if !self.weChat.isInstalled() {
                block!(false,error(code: -2, msg:"未安装"))
            }else{
                self.weChat.share(type: .session, item: item, block: block)
            }
            
        }else if type.isEqual(to: AXShareTypeWeiChatTimeLine){
            if !self.weChat.isInstalled() {
                block!(false,error(code: -2, msg: "未安装"))
            }else{
            self.weChat.share(type: .timeLine, item: item, block: block)
            }
        }else if type.isEqual(to: AXShareTypeSinaWeibo){
            if !self.weibo.isInstalled() {
                block!(false,error(code: -2, msg: "未安装"))
            }else{
            self.weibo.share(item: item, block: block)
            }
        }else if type.isEqual(to: AXShareTypeQQFriends){
            if !self.qq.isInstalled() {
                block!(false,error(code: -2, msg: "未安装"))
            }else{
            self.qq.share(type: .friends, item: item, block: block)
            }
        }
    }
    
    
}

extension AXShareUtil {
    
    private var weibo: AXShareWeibo {
        isStart = true
        return _weibo
    }
    
    private var weChat: AXShareWeChat {
        isStart = true
        return _weChat
    }
    
    private var qq: AXShareQQ {
        isStart = true
        return _qq
    }
    
}

