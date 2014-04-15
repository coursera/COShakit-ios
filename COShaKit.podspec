Pod::Spec.new do |s|
  s.name         = 'COShaKit'
  s.version      = '0.0.1'
  s.summary      = 'Shake gesture feedback framework'
  s.homepage     = 'https://github.com/coursera/COShakit-ios'
  s.license      = { :type => 'Private', :file => 'LICENSE' }
  s.author       = { 'Jeff Kim' => 'jkim@coursera.org' }
  s.source       = { :git => 'https://github.com/coursera/COShakit-ios.git', :tag => "v#{s.version}" }

  s.ios.source_files = 'COShaKit/Classes/*.{h,m}'
  s.requires_arc = true
  s.platform = :ios, '7.0'
end

