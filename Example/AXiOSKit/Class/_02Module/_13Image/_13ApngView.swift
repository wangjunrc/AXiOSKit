//
//  _13ApngView.swift
//  AXiOSKit_Example
//
//  Created by 小星星吃KFC on 2021/7/14.
//  Copyright © 2021 axinger. All rights reserved.
//

import UIKit
import APNGKit
import SnapKit

/**
 named imageName : String 内部参数名、外部参数名
 public convenience init?(named imageName: String, progressive: Bool = false, in bundle: Bundle = .main) {
 if let path = imageName.apng_filePathByCheckingNameExistingInBundle(bundle) {
 self.init(contentsOfFile:path, saveToCache: true, progressive: progressive)
 } else {
 return nil
 }
 }
 
 */
extension APNGImage {
    convenience init?(urlString: String?) {
        guard let urlString = urlString, let url = URL(string: urlString) else {
            return nil
        }
        self.init(url: url)
    }
    
    convenience init?(url: URL) {
        guard let data = try? Data(contentsOf: url) else {
            return nil
        }
        self.init(data: data)
    }
}


@objcMembers class _13ApngView2: UIView {
    
    
    private lazy var imageView2:APNGImageView = {
        let imgView = APNGImageView()
        imgView.backgroundColor = .red
        return imgView
    }()
    
    /**
     guard 条件表达式 else {
     
     跳转语句
     
     }
     */
    convenience init(url: URL ) {
        self.init(frame:CGRect.zero)
        let  image =  APNGImage(url: url)
        imageView2.image = image
        imageView2.startAnimating()
    }
    
    convenience init(name imageName: String ) {
        self.init(frame:CGRect.zero)
        /// imageName内部参数
        let image = APNGImage(named: imageName)
        imageView2.image = image
        imageView2.startAnimating()
    }
    
    convenience init(data imageData: Data ) {
        self.init(frame:CGRect.zero)
        let image =  APNGImage(data: imageData)
        imageView2.image = image
        imageView2.startAnimating()
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(imageView2)
        imageView2.snp.makeConstraints { make in
            make.edges.equalTo(UIEdgeInsets.zero)
        }
        
    }
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    //    required init?(coder: NSCoder) {
    //        fatalError("init(coder:) has not been implemented")
    //    }
    
}

class _13ApngView: UIView {
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .red
        
        /// 这个可以
        //        let path = Bundle.main.path(forResource: "Image.bundle/test_apng_elephant.png", ofType: nil)
        //        let  image = APNGImage(contentsOfFile: path ?? "")
        /// 这个可以
        //        let  image =   APNGImage(named: "Image.bundle/test_apng_elephant.png")
        //        /// 图片放入资源夹,不行
        ////        let  image =   APNGImage(named: "apng_elephant")
        //        let imageView = APNGImageView(image: image)
        //        self.addSubview(imageView)
        //        imageView.startAnimating()
        //        imageView.snp.makeConstraints { make in
        //            make.edges.equalTo(UIEdgeInsets.zero)
        //        }
        
        do {
            
            //            let  image =   APNGImage(data: Data.init(contentsOf: URL.init(string: "https://gitee.com/axinger/picture/raw/master/img/test_apng_elephant.png") ?? <#default value#>))
            
            let  image =  APNGImage(urlString: "https://gitee.com/axinger/picture/raw/master/img/test_apng_elephant.png")
            let imageView = APNGImageView(image: image)
            self.addSubview(imageView)
            imageView.image  = image
            imageView.startAnimating()
            imageView.snp.makeConstraints { make in
                make.edges.equalTo(UIEdgeInsets.zero)
            }
        }
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
