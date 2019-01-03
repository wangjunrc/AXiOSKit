Pod::Spec.new do |s|
    
    s.name     = 'AXiOSTools'
    s.version  = '0.1.1'
    s.license  = 'MIT'
    s.summary  = 'AXinger的工具类'
    s.homepage = 'https://www.baidu.com'
    s.social_media_url = ''
    s.authors  = { 'AXinger' => 'liu_weixing@qq.com' }
    s.source   = { :git => 'https://github.com/AXinger/AXiOSTools.git', :tag => s.version, :submodules => true }
    s.requires_arc = true
    
    s.public_header_files = 'AXiOSTools/AXiOSTools.h'
    s.source_files = 'AXiOSTools/AXiOSTools.h'
    
    s.ios.deployment_target = '8.0'
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

end
