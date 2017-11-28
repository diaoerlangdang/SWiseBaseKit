Pod::Spec.new do |s|
s.name = 'WiseBaseKit'
s.version = '1.0.0'
s.license = 'GPL-3.0'
s.summary = 'iOS 封装的基础库，可使得开发项目更容易 swift版本'
s.homepage = 'https://github.com/diaoerlangdang/SWiseBaseKit'
s.authors = { 'wise' => '99487616@qq.com' }
s.source = { :git => 'https://github.com/diaoerlangdang/SWiseBaseKit.git', :tag => s.version.to_s }
s.requires_arc = true
s.ios.deployment_target = '8.0'
s.source_files = 'SWiseBaseKit/**/*'
s.resource = 'SWiseBaseKit/resource/SWiseKitResource.bundle'
s.framework = 'Foundation', 'UIKit'
s.dependency 'MJRefresh','~> 3.1'
s.dependency 'SnapKit','~> 4.0.0'
end