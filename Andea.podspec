# pod 'Andea', :path => '~/pods/Andea'

Pod::Spec.new do |s|
  s.name             = 'Andea'
  s.version          = '0.1.4'
  s.summary          = 'Extensions for Swift from the Andeas.'
  s.description      = 'Convenience initializers & other extensions.'

  s.homepage         = 'https://bitbucket.com/dpostigo/Andea'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Dani Postigo' => 'dani.postigo@gmail.com' }
  s.source           = { :git => 'https://bitbucket.com/dpostigo/Andea.git', :tag => s.version.to_s }

  s.platform = :ios, '11.0'
  s.frameworks = 'Foundation'
  s.module_name = 'Andea'
  s.default_subspec = 'Core'

  # iOS

  s.subspec 'UIApplication' do |ss|
  	ss.frameworks = 'UIKit'
  	ss.source_files = 'Sources/Andea-UIApplication/**/*', 'Sources/AndeaKit/**/*'
    ss.dependency 'Andea/Core'
    ss.dependency 'Andea/Alamofire'
    ss.dependency 'Andea/AndeaSwiftGeometry'
  end

  # Dependencies

  s.subspec 'Alias' do |ss|
    ss.source_files = 'Sources/Andea/Alias.swift'
   end

  s.subspec 'Protocols' do |ss|
    ss.source_files = 'Sources/Protocols/*'
  end

  s.subspec 'AndeaSwift' do |ss|
    ss.source_files = 'Sources/AndeaSwift/**/*'
    ss.dependency '%s/libc' % s.name
  end

  s.subspec 'AndeaFoundation' do |ss|
    ss.source_files = 'Sources/AndeaFoundation/**/*'
    ss.dependency '%s/Protocols' % s.name
  end


  s.subspec 'Core' do |ss|
    ss.frameworks = 'UIKit'
    ss.source_files = 'Sources/{Andea,Protocols}/**/*'
    ss.dependency '%s/Alias' % s.name
    ss.dependency '%s/AndeaFoundation' % s.name
    ss.dependency '%s/AndeaSwift' % s.name
    ss.dependency '%s/Protocols' % s.name
  end

  s.subspec 'Alamofire' do |ss|
    ss.source_files = 'Sources/AndeaAlamofire/**/*'
    ss.dependency 'Alamofire'
    ss.dependency 'Andea/Bits'
    ss.dependency '%s/Alias' % s.name
    # ss.dependency '%s/AndeaFoundation' % s.name
  end


  # 3rd party

  s.subspec 'Bits' do |ss|
    ss.source_files = 'Sources/AndeaBits/**/*'
  end


  s.subspec 'AndeaSwiftGeometry' do |ss|
    ss.source_files = 'Sources/AndeaSwiftGeometry/**/*'
  end




end
