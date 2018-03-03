Pod::Spec.new do |s|

  # ―――  Spec Metadata  ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  s.name             = 'Andea'
  s.version          = '0.1.9'
  s.summary          = 'Extensions for Swift from the Andeas.'
  s.description      = 'Convenience initializers & other extensions.'
  s.author           = { 'Dani Postigo' => 'dani.postigo@gmail.com' }
  s.homepage         = 'https://bitbucket.com/dpostigo/Andea'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }


  # ――― Source Location ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  s.source           = { :git => 'https://bitbucket.com/dpostigo/Andea.git', :tag => s.version.to_s }


  # ――― Platform Specifics ――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  s.ios.deployment_target = '11.0'
  s.osx.deployment_target = '10.12'


  # ――― Project Linking ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  s.module_name = 'Andea'
  s.frameworks = 'Foundation'
  s.default_subspecs = 'AndeaKit', 'PlaygroundKit'


  # ――― AndeaKit –––––––―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #

  s.subspec 'AndeaKit' do |ss|
    ss.dependency 'Andea/Alamofire'
    ss.dependency 'Andea/CoreGraphics'
    ss.dependency 'Andea/Foundation'
    ss.dependency 'Andea/Lorem'

  	ss.ios.frameworks = 'UIKit'
    ss.ios.dependency 'Andea/ActionKit'
  	ss.ios.source_files = 'Sources/AndeaKit/{shared,ios}/*'

    ss.osx.frameworks = 'AppKit'
  	ss.osx.source_files = 'Sources/AndeaKit/{shared,macos}/*'
  end

  # ――― PlaygroundKit –––――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #

  s.subspec 'PlaygroundKit' do |ss|
    ss.ios.deployment_target = '11.0'
  	ss.frameworks = 'UIKit'
  	ss.dependency 'Andea/AndeaKit'
    ss.source_files = 'Sources/PlaygroundKit/ios/**/*'
  end


  # ――― Subspecs –––––––―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #

  s.subspec 'Alias' do |ss|
    ss.source_files = 'Sources/Swift/Alias.swift'
  end

  s.subspec 'Swift' do |ss|
    ss.dependency 'Qolla'
    ss.source_files = 'Sources/Swift/**/*'
  end

  s.subspec 'CoreGraphics' do |ss|
    ss.frameworks = 'CoreGraphics'
    ss.source_files = 'Sources/CoreGraphics'
  end

  s.subspec 'Foundation' do |ss|
    ss.source_files = 'Sources/Foundation/*'
    ss.dependency 'Andea/Swift'
  end

  # ――― Dependencies –––––––――――――――――――――――――――――――――――――――――――――――――――――――――――― #

  s.subspec 'ActionKit' do |ss|
    ss.ios.deployment_target = '11.0'
    ss.frameworks = 'UIKit'
    ss.dependency 'ActionKit'
    ss.dependency 'Andea/Foundation'
    ss.source_files = 'Sources/ActionKit/*'
  end

  s.subspec 'Alamofire' do |ss|
    ss.dependency 'Alamofire'
    ss.dependency 'Andea/Foundation'
    ss.dependency 'Andea/Swift'
    ss.source_files = 'Sources/Alamofire/**/*'
    ss.exclude_files = 'Sources/Alamofire/Bits/*'
  end

  s.subspec 'Lorem' do |ss|
    ss.source_files = 'Sources/Lorem/*'
    ss.dependency 'Andea/Swift'
  end


end
