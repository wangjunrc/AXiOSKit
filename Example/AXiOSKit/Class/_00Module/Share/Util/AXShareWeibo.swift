//
//  AXShareWeibo.swift
//  AXiOSKitExample
//
//  Created by 小星星吃KFC on 2021/5/7.
//  Copyright © 2021 axinger. All rights reserved.
//

import MonkeyKing

@objcMembers class AXShareWeibo:NSObject,AXShareProtocol {
    
    var accessToken: String?
    
    override init() {
        super.init()
        registerAccount()
    }
    
    /// 判断是否安装
    func isInstalled() -> Bool {
        return MonkeyKing.SupportedPlatform.weibo.isAppInstalled
    }
    
    /// 第三方平台注册
    func registerAccount(){
        let account = MonkeyKing.Account.weibo(appID: AXShareConfigs.Weibo.appID,
                                               appKey: AXShareConfigs.Weibo.appKey,
                                               redirectURL: AXShareConfigs.Weibo.redirectURL,
                                               universalLink: AXShareConfigs.Weibo.universalLink)
        MonkeyKing.registerAccount(account)
    }
    
    
    /// 微信授权
    func oauth()  {
        
        if !MonkeyKing.SupportedPlatform.weibo.isAppInstalled {
            MonkeyKing.oauth(for: .weibo) { [weak self] result in
                switch result {
                case .success(let info):
                    if let accessToken = info?["access_token"] as? String {
                        self?.accessToken = accessToken
                    }
                case .failure(let error):
                    print("error: \(String(describing: error))")
                }
            }
        }
        
    }
    
    /// 分享微博
    func  share(item:AXSocialShareContent, block:AXShareCompletionHandler? ){
        
        let info = MonkeyKing.Info(
            title: item.title,
            description: item.subTitle,
            thumbnail: item.thumbnail,
            media: item.toMedia()
        )
        let message = MonkeyKing.Message.weibo(.default(info: info, accessToken: accessToken))
        MonkeyKing.deliver(message) { result in
            print("AXShareWeibo 分享微博 = result: \(result)")
            actionResult(result,block)
        }
    }
    
}
