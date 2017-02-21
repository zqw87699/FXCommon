Pod::Spec.new do |s|
  s.name         = "FXCommon"
  s.version      = "1.0.0"
  s.summary      = "FX通用组件"

  s.homepage     = "https://github.com/zqw87699/FXCommon"

  s.license      = { :type => "MIT", :file => "LICENSE" }

  s.author       = {"zhangdazong" => "929013100@qq.com"}

  s.source       = { :git => "https://github.com/zqw87699/FXCommon.git", :tag => "#{s.version}"}

  s.platform     = :ios, "7.0"

  s.source_files  = "Classes/*.{h,m}"

  s.public_header_files = "Classes/*.h"

  s.frameworks = "Foundation", "UIKit"

  s.module_name = 'FXCommon' 

  s.requires_arc = true

  s.dependency "FXLog", "~> 1.0.3"
  s.dependency "FXJson", "~> 1.0.0"
  s.dependency "FXHttpAPI", "~> 1.0.0"
  s.dependency "AFNetworking", "~> 3.1.0"

end
