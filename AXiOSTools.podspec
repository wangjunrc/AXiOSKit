Pod::Spec.new do |spec|
    spec.name         = 'AXiOSTools'
    spec.version      = '0.1.1'
    spec.summary      = 'AXinger'
    spec.homepage     = 'http://www.baidu.com'
    spec.license      = {:type => 'MIT', :file => 'LICENSE'}
    spec.author       = {'AXinger' => 'liu_weixing@qq.com'}
    spec.social_media_url   = ''
    spec.source = {:git => 'https://github.com/AXinger/AXiOSTools.git', :tag => spec.version}
    spec.requires_arc = true
    spec.ios.deployment_target = '8.0'
    spec.resource_bundles = {
        'AXiOSTools' => ['AXiOSTools/AXiOSTools.xcassets', 'AXiOSTools/**/*.{gif,png,json,plist,xib}']
    }
    
    
    spec.source_files = 'AXiOSTools/**/*.{h,m,mm,c,swift}'
    
    #    spec.resource = 'AXiOSTools/**/*.{plist,xib,json}'
    
    spec.exclude_files = 'AXiOSTools/info.plist'
    
    spec.requires_arc = true
    spec.ios.deployment_target = '8.0'
    spec.public_header_files = 'AXiOSTools/**/*.h'
    
    spec.libraries = 'icucore'
    spec.frameworks = 'UIKit', 'CoreFoundation', 'QuartzCore'
    
    spec.pod_target_xcconfig = {
        'ENABLE_BITCODE' => 'NO',
        'CLANG_ALLOW_NON_MODULAR_INCLUDES_IN_FRAMEWORK_MODULES' => 'YES'}
    
    spec.dependency "AFNetworking"
    spec.dependency "SDWebImage"
    spec.dependency "IQKeyboardManager"
    spec.dependency "MJRefresh"
    spec.dependency "NullSafe"
    spec.dependency "MJExtension"
    spec.dependency "MBProgressHUD"
    spec.dependency "DZNEmptyDataSet"
    spec.dependency "SDCycleScrollView"
    spec.dependency "KVOController"
    spec.dependency "Masonry"

end
