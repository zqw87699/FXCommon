Pod::Spec.new do |s|
  s.name         = "FXCommon"
  s.version      = "1.1.4"
  s.summary      = "FX通用组件"

  s.homepage     = "https://github.com/zqw87699/FXCommon"

  s.license      = { :type => "MIT", :file => "LICENSE" }

  s.author       = {"zhangdazong" => "929013100@qq.com"}

  s.source       = { :git => "https://github.com/zqw87699/FXCommon.git", :tag => "#{s.version}"}

  s.platform     = :ios, "7.0"

s.subspec 'Base' do |base|
    base.source_files = 'Classes/Base/*'
    base.public_header_files = 'Classes/Base/*.h'

    base.dependency 'FXJson'
    base.dependency 'FXHttpAPI'
    base.dependency 'FXRoutableAPI'
    base.dependency 'FXWebViewJavaScriptBridge'
    base.dependency 'Masonry', '1.0.2'
    base.dependency 'ReactiveObjC', '2.1.2'

end

s.subspec 'Core' do |core|
    core.source_files = 'Classes/Core/*'
    core.public_header_files = 'Classes/Core/*.h'
end

s.subspec 'Extension' do |extension|
    extension.source_files = 'Classes/Extension/*'
    extension.public_header_files = 'Classes/Extension/*.h'
end

s.subspec 'Utiles' do |utiles|
    utiles.source_files = 'Classes/Utiles/*'
    utiles.public_header_files = 'Classes/Utiles/*.h'
end

s.subspec 'SwipeBack' do |swipeback|
    swipeback.source_files = 'Classes/SwipeBack/*'
    swipeback.public_header_files = 'Classes/SwipeBack/*.h'
end

  s.frameworks = "Foundation", "UIKit" , "WebKit"

  s.module_name = 'FXCommon' 

  s.requires_arc = true

  s.dependency "FXLog"

end
