Pod::Spec.new do |s|
    
    s.name         = "AXiOSTools"
    s.version      = "0.1.1"
    s.summary      = "个人开发工具类"
    s.description  = <<-DESC
    封装UIKit等个人开发工具类
    DESC
    
    s.homepage     = "https://github.com/AXinger/AXiOSTools"
    s.license      = { :type => "MIT", :file => "LICENSE" }
    s.author             = { "AXinger" => "liu_weixing@qq.com" }
    s.ios.deployment_target = "8.0"
    s.requires_arc = true
    s.source       = { :git => "https://github.com/AXinger/AXiOSTools.git", :tag => "#{s.version}" }
    s.source_files  = "AXiOSTools/**/*.{h,m}"
    # 使用 resources 来指定资源，被指定的资源只会简单的被 copy 到目标工程中（主工程）。
    #xib 文件不能再别的bundle中,不然对应的class加载不到,也可以不写,但不能写在resource_bundles中
    # html,css,js 放在一个bundle中,放这里,
    # 如果放resource_bundles,会bundle嵌套,模拟器有缓存,不好实时更新,所以这样写,这里的.bundle与AXiOSTools_ax_mainBundle同级别
#    s.resource = 'AXiOSTools/**/*.{xib,bundle}'
     s.resources = ['AXiOSTools/**/*.xib', 'AXiOSTools/**/*.bundle']
   
    # 允许定义当前 Pod 库的资源包的 名称和文件 。用 hash 的形式来声明，key 是 bundle 的名称，value 是需要包括的文件的通配 patterns。
    s.resource_bundles = {
        'AXiOSTools_ax_mainBundle' => ['AXiOSTools/**/*.{xcassets,gif,json,strings}'],
    }
    
    s.frameworks = "Foundation", "UIKit"
    s.dependency "AFNetworking"
    s.dependency "SDWebImage"
    s.dependency "IQKeyboardManager"
    s.dependency "MJRefresh"
    s.dependency "NullSafe"
    s.dependency "MJExtension"
    s.dependency "MBProgressHUD"
    s.dependency "DZNEmptyDataSet"
    s.dependency "SDCycleScrollView"
    s.dependency "KVOController"
    s.dependency "Masonry"
    s.dependency "GKPhotoBrowser"
    s.dependency "WebViewJavascriptBridge"
    s.dependency "Aspects"
end
