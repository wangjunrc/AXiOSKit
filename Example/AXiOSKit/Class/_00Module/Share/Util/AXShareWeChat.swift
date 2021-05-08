//
//  AXShareWeChat.swift
//  AXiOSKitExample
//
//  Created by 小星星吃KFC on 2021/5/7.
//  Copyright © 2021 axinger. All rights reserved.
//

import MonkeyKing

@objcMembers class AXShareWeChat: NSObject,AXShareProtocol {
    
    @objc public enum DLWeChatType:Int {
        case session = 0
        case timeLine
        case favorite
    }
    
    override init() {
        super.init()
        registerAccount()
    }
    
    /// 判断是否安装
    func isInstalled() -> Bool {
        return MonkeyKing.SupportedPlatform.weChat.isAppInstalled
    }
    
    /// 第三方平台注册
    func registerAccount() {
        let account = MonkeyKing.Account.weChat(appID: AXShareConfigs.WeChat.appID,
                                                appKey: AXShareConfigs.WeChat.appKey,
                                                miniAppID: AXShareConfigs.WeChat.miniAppID,
                                                universalLink: AXShareConfigs.WeChat.universalLink)
        MonkeyKing.registerAccount(account)
    }
    
    /// 分享微信
    func share(type:DLWeChatType ,item:AXSocialShareContent, block:AXShareCompletionHandler? ) {
        
        
        var subtype: MonkeyKing.Message.WeChatSubtype!
        
        let info = MonkeyKing.Info(
            title: item.title,
            description: item.subTitle,
            thumbnail: item.thumbnail,
            media: item.toMedia()
        )
        
        switch type {
        case .session:
            subtype = MonkeyKing.Message.WeChatSubtype.session(info: info)
        
        case .timeLine:
            subtype = MonkeyKing.Message.WeChatSubtype.timeline(info:info)
            
        case .favorite:
            subtype = MonkeyKing.Message.WeChatSubtype.favorite(info:info)
        }
        
        let message = MonkeyKing.Message.weChat(subtype)
        MonkeyKing.deliver(message) { result in
            print("AXShareWeChat 分享微信 type = \(type), result =  \(result)")
            actionResult(result,block)
        }
    }
    
}
