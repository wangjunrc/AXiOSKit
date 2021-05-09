//
//  DLShareConfig.swift
//  AXiOSKitExample
//
//  Created by 小星星吃KFC on 2021/5/7.
//  Copyright © 2021 axinger. All rights reserved.
//
protocol AXShareProtocol {
    
    /// 判断是否安装
    func isInstalled() -> Bool
    
    /// 第三方平台注册
    func registerAccount()
}

struct AXShareConfigs {
    
    struct Weibo {
        static let appID = "3818898969"
        static let appKey = "83052d89734605612a10d67144562031"
        static let redirectURL = "https://api.weibo.com/oauth2/default.html"
        static let universalLink: String? = nil
    }
    
    struct WeChat {
        // wxb1fbfdf9fe32026b wx58b44315c8e725b5
        static let appID = "wxb1fbfdf9fe32026b"
        static let appKey: String? = nil
        static let miniAppID = "wxb1fbfdf9fe32026b"
        static let universalLink: String? = nil
    }
    
    struct QQ {
        static let appID = "1105526005"
        static let appKey: String? = nil
        static let universalLink: String? = nil
    }
    
}


