#
# Be sure to run `pod lib lint Andea.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'Andea'
  s.version          = '0.1.1'
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
      sss.dependency 'Andea/Alias'
    end
    ss.subspec 'Marshal' do |sss|
      sss.source_files = 'Sources/Libraries/Marshal/**/*'
      sss.dependency 'Marshal'
      sss.dependency 'Andea/Foundation'
    end
  end

  s.subspec 'UIApplication' do |ss|
  	ss.frameworks = 'UIKit'
  	ss.source_files = 'Sources/Andea-UIApplication/**/*'
    ss.dependency 'Andea/Core'
  end



end
