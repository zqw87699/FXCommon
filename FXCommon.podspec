Pod::Spec.new do |s|
  s.name         = "FXCommon"
  s.version      = "1.0.7"
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
    base.dependency 'Masonry', '1.0.2'

end

s.subspec 'Core' do |core|
    core.source_files = 'Classes/Core/*'
    core.public_header_files = 'Classes/Core/*.h'
end

s.subspec 'Utiles' do |utiles|
    utiles.source_files = 'Classes/Utiles/*'
    utiles.public_header_files = 'Classes/Utiles/*.h'
end

  s.frameworks = "Foundation", "UIKit"

  s.module_name = 'FXCommon' 

  s.requires_arc = true

  s.dependency "FXLog"

end
