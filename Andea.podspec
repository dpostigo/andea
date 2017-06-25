#
# Be sure to run `pod lib lint Andea.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'Andea'
  s.version          = '0.1.0'
  s.summary          = 'Extensions for Swift from the Andeas.'


  s.description      = 'Convenience initializers & other extensions.'

  s.homepage         = 'https://bitbucket.com/dpostigo/Andea'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Dani Postigo' => 'dani.postigo@gmail.com' }
  s.source           = { :git => 'https://bitbucket.com/dpostigo/Andea.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/alsoyay'

  s.ios.deployment_target = '10.0'
  s.osx.deployment_target = '10.12'
  s.osx.frameworks = 'Foundation'
  # s.ios.frameworks = 'UIKit', 'Foundation'


  s.default_subspec = 'Andea'

  s.subspec 'Andea' do |ss|
  	ss.frameworks = 'Foundation'
    ss.source_files = 'Sources/Andea/*'
  end

  s.subspec 'Extras' do |ss|
  	ss.frameworks = 'Foundation'
  	ss.source_files = 'Sources/AndeaExtras/**'
    ss.dependency 'Marshal'
  end


  s.subspec 'UIKit' do |ss|
    ss.osx.frameworks = 'Foundation', 'AppKit'
  	ss.ios.frameworks = 'Foundation', 'UIKit'
  	ss.osx.source_files = 'Sources/AndeaUIKit/**'
  	ss.ios.source_files = 'Sources/AndeaUIKit/**', 'Sources/AndeaUIKit/UIControl/**'
  end


  s.subspec 'AppKit' do |ss|
    ss.osx.deployment_target = '10.12'
    ss.osx.frameworks = 'Foundation', 'AppKit'
  	ss.osx.source_files = 'Sources/AppKit/**'
  end




  s.subspec 'Alamofire' do |ss|
  	ss.source_files = 'Sources/AndeaExtras/Alamofire/**'
  	ss.dependency 'Alamofire'
  end


  s.subspec 'XCTest' do |ss|
  	ss.ios.frameworks = 'Foundation', 'XCTest'
  	ss.osx.frameworks = 'Foundation', 'XCTest'
  	ss.ios.source_files = 'Sources/XCTest/*'
  	ss.osx.source_files = 'Sources/XCTest/*'
  end




#   # s.dependency 'AFNetworking', '~> 2.3'

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.resource_bundles = { 'Handy' => ['Handy/Assets/*.png'] }

  # s.subspec 'Handy' do |ss|
  #   ss.source_files = 'Handy/**/*'
  #   # ss.exclude_files = 'Handy/UIKit-Extensions.swift'
  # end

  # s.subspec 'Components' do |ss|
  #   ss.source_files = 'Components/**/*'
  # end

  # s.subspec 'Quartz' do |ss|
  #   ss.source_files = 'Quartz/**/*'
  #   ss.frameworks = 'QuartzCore'
  # end

  # s.default_subspec = 'Handy'


#   s.description      = <<-DESC
# TODO: Add long description of the pod here.
#                        DESC

#   s.homepage         = 'https://github.com/Dani Postigo/Andea'
#   # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
#   s.license          = { :type => 'MIT', :file => 'LICENSE' }
#   s.author           = { 'Dani Postigo' => 'dani.postigo@gmail.com' }
#   s.source           = { :git => 'https://github.com/Dani Postigo/Andea.git', :tag => s.version.to_s }
#   # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

#   s.ios.deployment_target = '8.0'

#   s.source_files = 'Andea/Classes/**/*'
  
#   # s.resource_bundles = {
#   #   'Andea' => ['Andea/Assets/*.png']
#   # }

#   # s.public_header_files = 'Pod/Classes/**/*.h'
#   # s.frameworks = 'UIKit', 'MapKit'
#   # s.dependency 'AFNetworking', '~> 2.3'
end
