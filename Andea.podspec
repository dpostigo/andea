# pod 'Andea', :path => '~/pods/Andea'

Pod::Spec.new do |s|
  s.name             = 'Andea'
  s.version          = '0.1.2'
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


  s.subspec 'Alias' do |ss| ; ss.source_files = 'Sources/Andea/Alias.swift' ; end
  s.subspec 'Protocols' do |ss| ;  ss.source_files = 'Sources/Protocols/*' ; end
  s.subspec 'Foundation' do |ss| ; ss.source_files = 'Sources/Foundation/*'; ss.dependency '%s/Protocols' % s.name ; end


  s.subspec 'Core' do |ss|
    ss.frameworks = 'UIKit'
    ss.source_files = 'Sources/{Andea,Protocols}/**/*'
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

  # iOS

  s.subspec 'UIApplication' do |ss|
  	ss.frameworks = 'UIKit'
  	ss.source_files = 'Sources/Andea-UIApplication/**/*', 'Sources/AndeaKit/**/*'
    ss.dependency 'Andea/Core'
  end



end
