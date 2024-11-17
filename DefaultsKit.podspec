Pod::Spec.new do |s|
  s.name = 'DefaultsKit'
  s.version = '0.3.2'
  s.license = 'MIT'
  s.summary = 'Simple, Strongly Typed UserDefaults for iOS, macOS and tvOS.'
  s.homepage = 'https://github.com/nmdias/DefaultsKit'
  s.authors = { 'Nuno Manuel Dias' => 'nmdias.pt@gmail.com' }
  s.source = { :git => 'https://github.com/nmdias/DefaultsKit.git', :tag => s.version }
  s.ios.deployment_target = '12.0'
  s.osx.deployment_target = '11.0'
  s.tvos.deployment_target = '12.0'
  s.watchos.deployment_target = '4.0'
  s.source_files = 'Sources/**/*.swift'
end
