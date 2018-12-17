Pod::Spec.new do |s|
s.name = "AXiOSTools"
s.version = "1.0.0"
s.ios.deployment_target = '8.0'
s.summary = "个人开发工具"
s.homepage = "https://github.com/AXinger/AXiOSTools"
s.license = { :type => "MIT", :file => "LICENSE" }
s.author = { "AXing" => "liu_weixing@qq.com" }
s.social_media_url = "https://www.jianshu.com/u/332ecb51d41b"
s.source = { :git => "https://github.com/AXinger/AXiOSTools.git", :tag => s.version }
s.source_files = "AXiOSTools","AXiOSTools/**/*.{h,m}"
#s.resources = "AXiOSTools/AXTools.bundle"
s.requires_arc = true

##**********第三方依赖库**********##
#s.dependency "AFNetworking"
#s.dependency "SDWebImage"
#s.dependency "IQKeyboardManager"
#s.dependency "MJRefresh"
#s.dependency "NullSafe"
#s.dependency "MJExtension"
#s.dependency "MBProgressHUD"
#s.dependency "DZNEmptyDataSet"
#s.dependency "SDCycleScrollView"
#s.dependency "KVOController"
#s.dependency "Masonry"
#s.dependency "GKPhotoBrowser"

end
