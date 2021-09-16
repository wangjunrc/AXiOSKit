//
//  Test.swift
//  AXiOSKit
//
//  Created by 小星星吃KFC on 2020/12/8.
//  Copyright © 2020 axinger. All rights reserved.
//

import Foundation
import UIKit
@objcMembers class DogSwift: NSObject {
    func show() {
        print("DogSwift");
    }
    func showOC() {
        let dog :DogOC  = DogOC.init();
        dog.show();
        /// Literal 提示
        /// Image Literal  提示图片
    
        
        /// https://www.hangge.com/blog/cache/detail_1903.html
        let imgView : UIImageView = UIImageView()
        imgView.frame = CGRect.init(x: 0, y: 0, width: 300, height: 300 )
        imgView.image = #imageLiteral(resourceName: "西瓜")
    }
    
    
    //    func reg() -> Void {
    //        MonkeyKing .registerAccount(.weChat(appID: <#T##String#>, appKey: <#T##String?#>, miniAppID: <#T##String?#>, universalLink: <#T##String?#>));
    //    }
}
