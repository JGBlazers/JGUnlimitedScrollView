Pod::Spec.new do |s|
s.name         = 'JGUnlimitedScrollView'
s.version      = '1.0.0'
s.summary      = '简单实用的图片无限轮播器'
s.homepage     = 'https://github.com/fcgIsPioneer/JGUnlimitedScrollView'
s.license      = 'MIT'
s.author       = { 'fcgIsPioneer' => '2044471447@qq.com' }
s.platform     = :ios,'8.0'
s.source       = {:git => 'https://github.com/fcgIsPioneer/JGUnlimitedScrollView.git', :tag => s.version}
s.source_files = 'JGUnlimitedScrollView/*.{h,m}'
s.resource = 'JGUnlimitedScrollView/Image/*.png'
s.requires_arc = true
end
