//
//  _TestSwift.swift
//  AXiOSKit_Example
//
//  Created by 小星星吃KFC on 2021/7/8.
//  Copyright © 2021 axinger. All rights reserved.
//

import UIKit
import DynamicColor
@objcMembers class _TestSwift: NSObject {
    
    
   class func test1() -> [UIColor] {
        
        let blue   = UIColor(hexString: "#3498db")
        let red    = UIColor(hexString: "#e74c3c")
        let yellow = UIColor(hexString: "#f1c40f")
        
        let gradient = DynamicGradient(colors: [blue, red, yellow])
        
        let gradient2 = [blue, red, yellow].gradient
    return gradient2.colorPalette()
    
        
//        return gradient.colorPalette()
    }
}
