//
//  Test.swift
//  AXiOSKit
//
//  Created by 小星星吃KFC on 2020/12/8.
//  Copyright © 2020 axinger. All rights reserved.
//

import Foundation

@objcMembers class DogSwift: NSObject {
    func show() {
        print("DogSwift");
    }
    func showOC() {
        let dog :DogOC  = DogOC.init();
        dog.show();
        
    }
    
    
//    func reg() -> Void {
//        MonkeyKing .registerAccount(.weChat(appID: <#T##String#>, appKey: <#T##String?#>, miniAppID: <#T##String?#>, universalLink: <#T##String?#>));
//    }
}
