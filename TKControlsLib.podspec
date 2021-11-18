#
# Be sure to run `pod lib lint TKControlsLib.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'TKControlsLib'
  s.version          = '2.0.0b'
  s.summary          = 'Move controls which using in Tiki App to Cocoapod'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
Refactor Tiki App
Move controls to Cocoapod
Tiki App avaiable on https://itunes.apple.com/us/app/tiki-vn-niềm-vui-mua-sắm/id958100553?mt=8
                       DESC

  s.homepage         = 'https://github.com/ducnnguyen/TKControlsLib'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'duc.nguyen@tiki.vn' => 'duc.nguyen@tiki.vn' }
  s.source           = { :git => 'https://github.com/ducnnguyen/TKControlsLib.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '10.0'
  s.swift_version = '5'
  s.static_framework = true
    
  s.subspec 'Common' do |ss|
      ss.source_files = 'Pod/Common/**/*.{h,m,swift}'
  end
  
  s.subspec 'CommonControl' do |ss|
      ss.source_files = 'Pod/CommonControl/**/*.{h,m,swift}'
  end
  
  s.subspec 'CommonUI' do |ss|
      ss.source_files = 'Pod/CommonUI/**/*.{h,m,swift}'
      ss.dependency 'DTCoreText'
  end

  
  s.frameworks = 'UIKit'
  s.default_subspecs = 'Common'
  

  # s.resource_bundles = {
  #   'TKControlsLib' => ['TKControlsLib/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/*/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
end
