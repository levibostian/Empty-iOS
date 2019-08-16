#
# Be sure to run `pod lib lint Empty.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'Empty'
  s.version          = '0.1.0'
  s.summary          = 'Quick and easy UIView to use when you have no data to show. Also great for displaying errors!'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
During those times where there is no data to show to your user, Empty to the rescue! Empty is a quick and easy way to display a message to your user and help with the next step by adding a button with 1 line of code. 

Configured with default settings that will work for most use cases, but customizable enough to cover more. 
                       DESC

  s.homepage         = 'https://github.com/levibostian/Empty-iOS'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Levi Bostian' => 'levi.bostian@gmail.com' }
  s.source           = { :git => 'https://github.com/levibostian/Empty-iOS.git', :tag => s.version.to_s }  

  s.ios.deployment_target = '10.0'

  s.source_files = 'Empty/Classes/**/*'
  
  # s.resource_bundles = {
  #   'Empty' => ['Empty/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  s.frameworks = 'UIKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
