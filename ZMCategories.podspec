#
# Be sure to run `pod lib lint ZMCategories.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'ZMCategories'
  s.version          = '0.1.2'
  s.summary          = '一个类别库.'

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/lucking/ZMCategories'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'lucking' => '1531073749@qq.com' }
  s.source           = { :git => 'https://github.com/lucking/ZMCategories.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  # s.source_files = 'ZMCategories/Classes/**/*'
  # s.source_files = 'ZMCategorieLib'
  s.source_files = 'ZMCategorieLib/**/*.{h,m}'
  s.public_header_files = 'ZMCategorieLib/**/*.{h}'
  
  
  # s.resource_bundles = {
  #   'ZMCategories' => ['ZMCategories/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
  s.dependency 'YYWebImage'

end
