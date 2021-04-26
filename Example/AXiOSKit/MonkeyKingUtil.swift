//
//  MonkeyKingUtil.swift
//  AXiOSKit
//
//  Created by 小星星吃KFC on 2021/4/26.
//  Copyright © 2021 axinger. All rights reserved.
//


import UIKit
#if canImport(MonkeyKing)
import MonkeyKing
#endif
@objcMembers class MonkeyKingUtil: NSObject {
    
    class func  weChatMessageSession() -> Void {
        #if canImport(MonkeyKing)
        
        MonkeyKing.registerAccount(.weChat(appID: "wxb1fbfdf9fe32026b", appKey: nil, miniAppID: nil, universalLink: nil)) // you can do it here (just before deliver)
        
        let message = MonkeyKing.Message.weChat(.session(info: (
            title: "Session",
            description: "Hello Session",
            thumbnail: UIImage(named: "西瓜"),
            media: .url(URL(string: "http://www.apple.com/cn")!)
        )))
        
        MonkeyKing.deliver(message) { success in
            print("shareURLToWeChatSession success: \(success)")
        }
        
        #endif
    }
    
    
}
