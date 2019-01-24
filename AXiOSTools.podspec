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
    s.exclude_files = 'AXiOSTools/AXiOSTools/Info.plist'
    s.public_header_files = 'AXiOSTools/AXiOSTools/AXiOSTools.h'
    # 使用 resources 来指定资源，被指定的资源只会简单的被 copy 到目标工程中（主工程）。
    #xib 文件不能再别的bundle中,不然对应的class加载不到,也可以不写,但不能写在resource_bundles中
    # html,css,js 放在一个bundle中,放这里,
    # 如果放resource_bundles,会bundle嵌套,模拟器有缓存,不好实时更新,所以这样写,这里的.bundle与AXiOSTools_ax_mainBundle同级别
#    s.resource = 'AXiOSTools/**/*.{xib,bundle}'
     s.resources = ['AXiOSTools/**/*.xib', 'AXiOSTools/**/*.bundle']
   
    # 允许定义当前 Pod 库的资源包的 名称和文件 。用 hash 的形式来声明，key 是 bundle 的名称，value 是需要包括的文件的通配 patterns。
    s.resource_bundles = {
        'AXiOSToolsResource' => ['AXiOSTools/**/*.{xcassets,gif,json,strings}'],
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
    s.dependency "Aspects"
end


#Pod::Spec.new do |spec|
#    spec.name         = 'SPTShare'
#    spec.version      = '0.0.5.0'
#    spec.summary      = 'suning'
#    spec.homepage     = "http://www.suning.com"
#    spec.license      = "MIT"
#    spec.author       = { "wangjindong" => "419591321@qq.com" }
#    spec.social_media_url   = ""
#    spec.source = {:git => 'http://git.cnsuning.com/tysq/SPTShare.git', :tag => spec.version}
#    spec.platform = :ios,'8.0'
#    spec.requires_arc = true
#    spec.ios.deployment_target = '8.0'
#    spec.pod_target_xcconfig = {
#        'CLANG_ALLOW_NON_MODULAR_INCLUDES_IN_FRAMEWORK_MODULES' => 'YES'
#    }
#
#    spec.exclude_files = 'SPTShare/SPTShare/Info.plist'
#    spec.source_files = 'SPTShare/SPTShare/SPTShare.h'
#    spec.public_header_files = 'SPTShare/SPTShare/SPTShare.h'
#
#    spec.default_subspec = 'SPTShareView'
#
#    spec.subspec "SPTShareView" do |cp|
#        cp.source_files = 'SPTShare/SPTShare/SPTShareView/**/*.{h,m}'
#        cp.public_header_files = 'SPTShare/SPTShare/SPTShareView/UIView+SPTShare.h'
#        cp.dependency 'SPTShare/SPTShareBusinessCommon'
#        cp.dependency 'SPTView'
#        cp.resource_bundles = {
#            'SPTShareView' => ['SPTShare/SPTShare/*.xcassets'],
#        }
#    end
#
#    spec.subspec "SPTShareBusinessCommon" do |cp|
#        cp.source_files = 'SPTShare/SPTShare/SPTShareOC/*.{h,m,swift}','SPTShare/SPTShare/SPTShareBusinessCommon/**/*.{h,m}'
#        cp.public_header_files = 'SPTShare/SPTShare/SPTShareBusinessCommon/SPTBusinessCommonShare.h','SPTShare/SPTShare/SPTShareBusinessCommon/SPTBusinessCommonShareDefine.h','SPTShare/SPTShare/SPTShareBusinessCommon/SPTBusinessCommonShareModel.h','SPTShare/SPTShare/SPTShareBusinessCommon/SPTBusinessCommonMiniAppModel.h','SPTShare/SPTShare/SPTShareBusinessCommon/SPTBusinessCommonOAuthResult.h'
#        #        cp.dependency 'MonkeyKing', '~> 1.8.0'
#        cp.dependency 'SportsKit'
#        cp.dependency 'OpenShare'
#        cp.dependency 'Goel'
#        # cp.dependency 'SDWebImage'
#    end
#
#end
