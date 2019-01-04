Pod::Spec.new do |s|

  s.name         = "AXiOSTools"
  s.version      = "0.1.1"
  s.summary      = "个人开发工具类"
  s.description  = <<-DESC
                  封装UIKit等个人开发工具类
                   DESC

  s.homepage     = "https://github.com/AXinger/AXiOSTools"
  s.license      = { :type => "MIT", :file => "FILE_LICENSE" }
  s.author             = { "AXinger" => "liu_weixing@qq.com" }
  s.ios.deployment_target = "8.0"
  s.source       = { :git => "https://github.com/AXinger/AXiOSTools.git", :tag => "#{s.version}" }
  s.source_files  = "AXiOSTools", "AXiOSTools/**/*.{h,m}"
  s.frameworks = "Foundation", "UIKit"
  s.requires_arc = true

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

end
