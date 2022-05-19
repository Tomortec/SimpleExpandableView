#
# Be sure to run `pod lib lint SimpleExpandableView.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'SimpleExpandableView'
  s.version          = '0.1.0'
  s.summary          = '`SimpleExpandableView` is a SwiftUI view which can collapse and expand the content'

  s.description      = <<-DESC
  `SimpleExpandableView` is a SwiftUI view which can collapse the detail content and expand it when you want .
  You can easily change the appearance of the view as you want.
 This view is concise and easy to modify
                       DESC

  s.homepage         = 'https://github.com/Tomortec/SimpleExpandableView'
   s.screenshots     = './screenshot.png'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Tomortec' => 'everything@tomortec.com' }
  s.source           = { :git => 'https://github.com/Tomortec/SimpleExpandableView.git', :tag => s.version.to_s }

  s.swift_version = '5.6'
  s.ios.deployment_target = '15.0'

  s.source_files = 'SimpleExpandableView/Classes/**/*'
end
