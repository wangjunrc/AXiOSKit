#
# Be sure to run `pod lib lint AXFoundation.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#


Pod::Spec.new do |s|
    
    s.name         = 'AXiOSKit'
    s.version      = '2.0.1'
    s.summary      = '个人开发工具类'
    s.description  = <<-DESC
    iOS个人开发工具类
    DESC
    
    #    s.homepage     = 'https://github.com/axinger/axinger'
    s.homepage     = 'https://github.com/axinger'
    s.license      = { :type => 'MIT', :file => 'LICENSE' }
    s.author             = { 'axinger' => 'axingrun@qq.com' }
    s.ios.deployment_target = '10.0'
    s.requires_arc = true
    s.source       = { :git => 'https://github.com/axinger/AXiOSKit.git', :tag => s.version.to_s }
    
    #    s.public_header_files = 'AXiOSKit/AXiOSKit.h'
    s.source_files = 'AXiOSKit/AXiOSKit.h'
    # oc swift 混编时,需要指定一个
    #    s.private_header_files = ''
    #    s.source_files  = 'AXiOSKit/**/*.{h,m}'
    #  s.exclude_files = 'AXiOSKit/AXiOSKit/Info.plist'
    
    # 使用 resources 来指定资源，被指定的资源只会简单的被 copy 到目标工程中（主工程）。
    #xib 文件不能再别的bundle中,不然对应的class加载不到,也可以不写,但不能写在resource_bundles中
    # html,css,js 放在一个bundle中,放这里,
    # 如果放resource_bundles,会bundle嵌套,模拟器有缓存,不好实时更新,所以这样写,这里的.bundle与AXiOSKit_ax_mainBundle同级别
    #    s.resource = 'AXiOSKit/**/*.{xib,bundle}'
    #    s.resources = ['AXiOSKit/Classes/**/*.xib','AXiOSKit/Classes/**/*.nib', 'AXiOSKit/Assets/**/*.bundle',]
    
    s.resources = ['AXiOSKit/Assets/**/*.bundle']
    
    
    #    s.resources = ['AXiOSKit/**/*.bundle']
    #    spec.resources = 'Resources/*.png'
    
    # 允许定义当前 Pod 库的资源包的 名称和文件 。用 hash 的形式来声明，key 是 bundle 的名称，value 是需要包括的文件的通配 patterns。
    s.resource_bundles = {
        'AXiOSKitMain' => ['AXiOSKit/Assets/*.{xcassets,gif,json,wav}',
        'AXiOSKit/**/*.{strings}',
        'AXiOSKit/README/*.{md}'],
    }
    
    # 多个模块之间,不能import隔壁模块的,要用子库的spec依赖其他subspec·
    s.subspec 'Foundation' do |ss|
        #        ss.public_header_files = 'AXiOSKit/Classes/Foundation/AXiOSFoundation.h'
        ss.source_files = 'AXiOSKit/Classes/Foundation/**/*.{h,m}'
        ss.frameworks = 'Foundation'
    end
    
    s.subspec 'Kit' do |ss|
        ss.source_files = 'AXiOSKit/Classes/Kit/**/*.{h,m}'
        ss.resources = ['AXiOSKit/Classes/Kit/View/**/*.xib','AXiOSKit/Classes/Kit/View/**/*.nib']
        ss.frameworks = 'Foundation', 'UIKit'
        ss.dependency 'AXiOSKit/Foundation'
        ss.dependency 'Masonry'
    end
    
    s.subspec 'Helper' do |ss|
        ss.source_files = 'AXiOSKit/Classes/Helper/**/*.{h,m}'
    end
    
    s.subspec 'AXViewControllerTransitioning' do |ss|
        ss.source_files = 'AXiOSKit/Classes/AXViewControllerTransitioning/**/*.{h,m}'
        ss.frameworks = 'Foundation', 'UIKit'
        ss.dependency 'AXiOSKit/Foundation'
        ss.dependency 'AXiOSKit/Kit'
        s.dependency 'ReactiveObjC'
    end
    
    s.subspec 'Parts' do |ss|
        ss.source_files = 'AXiOSKit/Classes/Parts/**/*.{h,m}'
        ss.resources = ['AXiOSKit/Classes/Parts/**/*.xib','AXiOSKit/Classes/Parts/**/*.nib']
        ss.frameworks = 'Foundation', 'UIKit'
        ss.dependency 'AXiOSKit/Foundation'
        ss.dependency 'AXiOSKit/Kit'
        ss.dependency 'AXiOSKit/AXViewControllerTransitioning'
        ss.dependency 'Masonry'
        ss.dependency 'SDWebImage'
        ss.dependency 'ReactiveObjC'
    end
    
    s.subspec 'Manager' do |ss|
        ss.source_files = 'AXiOSKit/Classes/Manager/**/*.{h,m}'
        ss.frameworks = 'Foundation', 'UIKit'
        ss.dependency 'AXiOSKit/Foundation'
        ss.dependency 'AXiOSKit/Kit'
    end
    
    s.subspec 'AXToAFNetworking' do |ss|
        ss.source_files = 'AXiOSKit/Classes/Third/AFNetworking.AX/*.{h,m}'
        ss.frameworks = 'Foundation', 'UIKit'
        ss.dependency 'AXiOSKit/Foundation'
        ss.dependency 'AXiOSKit/Kit'
        ss.dependency 'AFNetworking'
    end
    
    s.subspec 'AXToDZNEmptyDataSet' do |ss|
        ss.source_files = 'AXiOSKit/Classes/Third/DZNEmptyDataSet.AX/*.{h,m}'
        ss.frameworks = 'Foundation', 'UIKit'
        ss.dependency 'AXiOSKit/Foundation'
        ss.dependency 'AXiOSKit/Kit'
        ss.dependency 'DZNEmptyDataSet'
    end
    
    s.subspec 'AXToFMDB' do |ss|
        ss.source_files = 'AXiOSKit/Classes/Third/FMDB.AX/*.{h,m}'
        ss.frameworks = 'Foundation', 'UIKit'
        ss.dependency 'AXiOSKit/Foundation'
        ss.dependency 'AXiOSKit/Kit'
        ss.dependency 'FMDB'
    end
    
    s.subspec 'AXToMBProgressHUD' do |ss|
        ss.source_files = 'AXiOSKit/Classes/Third/MBProgressHUD.AX/*.{h,m}'
        ss.frameworks = 'Foundation', 'UIKit'
        ss.dependency 'AXiOSKit/Foundation'
        ss.dependency 'AXiOSKit/Kit'
        ss.dependency 'AXiOSKit/Helper'
        ss.dependency 'MBProgressHUD'
        ss.dependency 'lottie-ios', '~>2.5.3'
    end
    
    s.subspec 'AXToMJRefresh' do |ss|
        ss.source_files = 'AXiOSKit/Classes/Third/MJRefresh.AX/*.{h,m}'
        ss.frameworks = 'Foundation', 'UIKit'
        ss.dependency 'AXiOSKit/Foundation'
        ss.dependency 'AXiOSKit/Kit'
        ss.dependency 'MJRefresh'
    end
    
    s.subspec 'AXToSDWebImage' do |ss|
        ss.source_files = 'AXiOSKit/Classes/Third/SDWebImage.AX/*.{h,m}'
        ss.frameworks = 'Foundation', 'UIKit'
        ss.dependency 'AXiOSKit/Foundation'
        ss.dependency 'AXiOSKit/Kit'
        ss.dependency 'SDWebImage'
    end
    
    #    假如把一个framework 制作成cocopod
    #s.resources    = "MAMapKit.framework/*.bundle"
    #    s.vendored_frameworks   = "MAMapKit.framework"
    valid_archs = ['armv7s','arm64','x86_64','armv7','arm64e']
end


