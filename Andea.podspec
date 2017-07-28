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
  s.ios.frameworks = 'Foundation'

  s.module_name = "Andea"
  s.default_subspec = 'Core'


  s.subspec 'Alias' do |ss| ; ss.source_files = 'Sources/Andea/Alias.swift' ; end
  s.subspec 'Foundation' do |ss| ;  ss.source_files = 'Sources/Foundation/*' ; end

  s.subspec 'Core' do |ss|
    ss.osx.frameworks = 'AppKit'
    ss.ios.frameworks = 'UIKit'
    ss.source_files = 'Sources/{Andea,Protocols}/**/*'
    ss.dependency 'Andea/Alias'
    ss.dependency 'Andea/Foundation'
  end


  s.subspec 'UIApplication' do |ss|
  	ss.ios.frameworks = 'UIKit'
  	ss.ios.source_files = 'Sources/Andea-UIApplication/**/*'
    ss.dependency 'Andea/Core'
  end

  s.subspec 'NSApplication' do |ss|
    ss.osx.frameworks = 'Cocoa', 'AppKit', 'QuartzCore'
  	ss.osx.source_files = 'Sources/Andea-NSApplication/*'
    ss.dependency 'Andea/Core'
  end

  s.subspec 'NSApplicationKit' do |ss|
    ss.osx.frameworks = 'Cocoa', 'AppKit', 'QuartzCore'
    ss.osx.source_files = 'Sources/Andea-NSApplication/NSApplicationKit/*'
    ss.dependency 'Andea/NSApplication'
    ss.dependency 'Andea/Libraries/Marshal'
  end

  s.subspec 'Libraries' do |ss|
    ss.subspec 'Alamofire' do |sss|
      sss.source_files = 'Sources/Libraries/Alamofire/**/*'
      sss.dependency 'Alamofire'
      sss.dependency 'Andea/Alias'
    end
    ss.subspec 'Marshal' do |sss|
      sss.source_files = 'Sources/Libraries/Marshal/**/*'
      sss.dependency 'Marshal'
      sss.dependency 'Andea/Foundation'
    end
  end

  # s.subspec 'Alamofire' do |ss|
  #   ss.source_files = 'Sources/Libraries/Alamofire/**/*'
  #   ss.dependency 'Alamofire'
  #   ss.dependency 'Andea/Alias'
  # end

  # s.subspec 'Marshal' do |ss|
  #   ss.source_files = 'Sources/Libraries/Marshal/**/*'
  #   ss.dependency 'Marshal'
  #   ss.dependency 'Andea/Foundation'
  # end


  # s.subspec 'XCTest' do |ss|
  # 	ss.ios.frameworks = 'XCTest'
  # 	ss.osx.frameworks = 'XCTest'
  # 	ss.ios.source_files = 'Sources/XCTest/*'
  # 	ss.osx.source_files = 'Sources/XCTest/*'
  # end



  # s.subspec 'Extras' do |ss|
  #   ss.frameworks = 'Foundation'
  #   ss.source_files = 'Sources/AndeaExtras/**'
  #   ss.exclude_files = 'Sources/AndeaExtras/Alamofire?.swift'
  #   ss.dependency 'Marshal'
  # end

end
