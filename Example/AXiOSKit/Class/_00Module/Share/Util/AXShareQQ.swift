//
//  AXShareQQ.swift
//  AXiOSKitExample
//
//  Created by 小星星吃KFC on 2021/5/7.
//  Copyright © 2021 axinger. All rights reserved.
//
import MonkeyKing

@objcMembers class AXShareQQ: NSObject,AXShareProtocol {
    
    public enum DLQQType  {
        case friends
        case zone
        case favorites
        case dataline
    }
    
    override init() {
        super.init()
        registerAccount()
    }
    
    /// 判断是否安装
    func isInstalled() -> Bool {
        return MonkeyKing.SupportedPlatform.qq.isAppInstalled
    }
    
    /// 第三方平台注册
    func registerAccount() {
        let account = MonkeyKing.Account.qq(appID: AXShareConfigs.QQ.appID,
                                            universalLink: AXShareConfigs.QQ.universalLink)
        MonkeyKing.registerAccount(account)
    }
    
    
    
    /// 分享QQ
    func share(type:DLQQType ,item:AXSocialShareContent, block:AXShareCompletionHandler? ) {
        
        registerAccount()
        
        var subtype: MonkeyKing.Message.QQSubtype!
        let info = MonkeyKing.Info(
            title: item.title,
            description: item.subTitle,
            thumbnail: item.thumbnail,
            media: item.toMedia()
        )
        
        switch type {
        case .friends:
            subtype = MonkeyKing.Message.QQSubtype.friends(info: info)
            
        case .zone:
            subtype = MonkeyKing.Message.QQSubtype.zone(info: info)
            
        case .favorites:
            subtype = MonkeyKing.Message.QQSubtype.favorites(info: info)
        case .dataline:
            subtype = MonkeyKing.Message.QQSubtype.dataline(info:info)
        }
        
        let message = MonkeyKing.Message.qq(subtype)
        MonkeyKing.deliver(message) { result in
            print("AXShareQQ 分享qq type = \(type), result =  \(result)")
            actionResult(result,block)
        }
    }
    
    
}
