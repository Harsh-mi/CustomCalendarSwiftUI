#
# Be sure to run `pod lib lint CustomCalendarSwiftUI.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'CustomCalendarSwiftUI'
  s.version          = '1.0.0'
  s.summary          = 'This SwiftUICalendar allows you to use calendar without any dependency of UIKit'
  
  # This description is used to generate tags and improve search results.
  #   * Think: What does it do? Why did you write it? What is the focus?
  #   * Try to keep it short, snappy and to the point.
  #   * Write the description between the DESC delimiters below.
  #   * Finally, don't worry about the indent, CocoaPods strips it!
  
  s.description      = <<-DESC
  'This SwiftUICalendar allows you to use calendar without any dependency of UIKit. You have to pass Date and Height for the calendar and Height should be between 200 - 600 range.'
  DESC
  
  s.homepage         = 'https://github.com/Harsh-mi/CustomCalendarSwiftUI'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Harsh-mi' => 'harsh.parikh@mindinventory.com' }
  s.source           = { :git => 'https://github.com/Harsh-mi/CustomCalendarSwiftUI.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'
  
  s.ios.deployment_target = '15.0'
  
  s.source_files = 'Classes/**/*.swift'
    
  s.swift_version = '5.0'
  
  s.platforms = {
      'ios': '15.0'
  }
  
  # s.resource_bundles = {
  #   'CustomCalendarSwiftUI' => ['CustomCalendarSwiftUI/Assets/*.png']
  # }
  
  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
