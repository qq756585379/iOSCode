platform :ios, '8.0'

# 对于我们使用cocoapod引入的第三方,我们可以在podfile文件中 增加一句  inhibit_all_warnings! 来要pod的工程不显示任何警告
inhibit_all_warnings!

# 必须申明workspace，否则会创建其他的workspace
workspace 'iOSCode'

# If you want multiple targets to share the same pods, use an abstract_target
# There are no targets called "Shows" in any Xcode project
abstract_target 'Shows' do
    
    pod 'Masonry'
    pod 'PureLayout'
    pod 'AFNetworking', '~> 3.1.0'
    pod 'SDWebImage', '~> 4.0.0'
    pod 'ReactiveObjC', '~> 3.0.0'
    pod 'pop', '~> 1.0.10'
    pod 'MJExtension', '~> 3.0.13'
    pod 'MJRefresh', '~> 3.1.12'
    pod 'SVProgressHUD', '~> 2.1.2'
    pod 'MBProgressHUD', '~> 1.0.0'
    pod 'DateTools', '~> 2.0.0'
    pod 'BlocksKit', '~> 2.2.5'
    pod 'Toast', '~> 3.1.0'
    pod 'FLAnimatedImage', '~> 1.0.12'
    pod 'RegexKitLite', '~> 4.0'
    pod 'YYText', '~> 1.0.7'
    pod 'KILabel', '~> 1.0.1'
    
    target 'Demos' do
        project './Projects/Demos/Demos.xcodeproj'
    end
    target 'TZTV' do
        project './Projects/TZTV/TZTV.xcodeproj'
    end
    target 'OpenGL' do
        project './Projects/OpenGL/OpenGL.xcodeproj'
    end
    target 'WeiChat' do
        project './Projects/WeiChat/WeiChat.xcodeproj'
    end
end
