# pod 'Andea-OSX', :path => '~/pods/Andea'

Pod::Spec.new do |s|
  s.name             = 'Andea-OSX'
  s.version          = '0.1.0'
  s.summary          = 'Extensions for Swift from the Andeas.'
  s.description      = 'Convenience initializers & other extensions.'

  s.homepage         = 'https://bitbucket.com/dpostigo/Andea'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Dani Postigo' => 'dani.postigo@gmail.com' }
  s.source           = { :git => 'https://bitbucket.com/dpostigo/Andea.git', :tag => s.version.to_s }

  s.platform = :osx, '10.12'
  s.frameworks = 'Foundation'

  s.module_name = 'Andea'
  # s.default_subspec = 'Core'


  s.subspec 'Alias' do |ss| ; ss.source_files = 'Sources/Andea/Alias.swift' ; end
  s.subspec 'Protocols' do |ss| ;  ss.source_files = 'Sources/Protocols/*' ; end
  s.subspec 'Foundation' do |ss| ; ss.source_files = 'Sources/Foundation/**/*'; ss.dependency '%s/Protocols' % s.name ; end


  s.subspec 'Core' do |ss|
    ss.frameworks = 'AppKit'
    ss.source_files = 'Sources/Andea/**/*'
    ss.dependency '%s/Alias' % s.name
    ss.dependency '%s/Foundation' % s.name
    ss.dependency '%s/Protocols' % s.name
  end

  s.subspec 'Libraries' do |ss|
    ss.subspec 'Alamofire' do |sss|
      sss.source_files = 'Sources/Libraries/Alamofire/**/*'
      sss.dependency 'Alamofire'
      sss.dependency '%s/Alias' % s.name
    end
    ss.subspec 'Marshal' do |sss|
      sss.source_files = 'Sources/Libraries/Marshal/**/*'
      sss.dependency 'Marshal'
      sss.dependency '%s/Foundation' % s.name
    end
  end

  # OS X

  s.subspec 'NSApplication' do |ss|
    ss.frameworks = 'Cocoa', 'AppKit', 'QuartzCore'
    ss.source_files = 'Sources/Andea-NSApplication/*'
    ss.dependency '%s/Core' % s.name
  end

  s.subspec 'NSApplicationKit' do |ss|
    ss.frameworks = 'Cocoa', 'AppKit', 'QuartzCore'
    ss.source_files = 'Sources/Andea-NSApplication/NSApplicationKit/*'
    ss.dependency '%s/NSApplication' % s.name
    ss.dependency '%s/Libraries/Marshal' % s.name
  end

  s.subspec 'Experimental' do |ss|
    ss.source_files = 'andea-osx/Experimental/**/*'
    ss.dependency '%s/Core' % s.name
  end

  s.subspec 'Playgrounds' do |ss|
    ss.source_files = 'andea-osx/Playgrounds/**/*'
    ss.dependency '%s/Core' % s.name
    ss.frameworks = 'XCTest'
  end

  # s.subspec 'XCTest' do |ss|
  #   ss.ios.frameworks = 'XCTest'
  #   ss.osx.frameworks = 'XCTest'
  #   ss.ios.source_files = 'Sources/XCTest/*'
  #   ss.osx.source_files = 'Sources/XCTest/*'
  # end

  # s.subspec 'Extras' do |ss|
  #   ss.frameworks = 'Foundation'
  #   ss.source_files = 'Sources/AndeaExtras/**'
  #   ss.exclude_files = 'Sources/AndeaExtras/Alamofire?.swift'
  #   ss.dependency 'Marshal'
  # end

end
