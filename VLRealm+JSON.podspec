Pod::Spec.new do |s|
  s.name     = 'VLRealm+JSON'
  s.version  = '0.4.0'
  s.ios.deployment_target     = '8.0'
  s.osx.deployment_target     = '10.9'
  s.watchos.deployment_target = '2.0'
  s.tvos.deployment_target    = '9.0'
  s.license  = { :type => 'MIT', :file => 'LICENSE' }
  s.summary  = 'A concise Mantle-like way of working with Realm and JSON.'
  s.homepage = 'https://github.com/viktorasl/Realm-JSON'
  s.author   = { 'Viktoras Laukevičius' => 'viktoras.laukevicius@yahoo.com' }
  s.requires_arc = true
  s.source   = {
    :git => 'https://github.com/viktorasl/Realm-JSON.git',
    :branch => 'master',
    :tag => s.version.to_s
  }
  s.source_files = 'Realm+JSON/*.{h,m}'
  s.public_header_files = 'Realm+JSON/*.h'

  s.dependency 'Realm', '~> 3.0'
end
