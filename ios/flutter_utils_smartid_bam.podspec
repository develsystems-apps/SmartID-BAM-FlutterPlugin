#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint flutter_utils_smartid_bam.podspec` to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'flutter_utils_smartid_bam'
  s.version          = '1.1.0'
  s.summary          = 'Flutter plugin for SmartId iOS sdk.'
  s.description      = <<-DESC
A new flutter plugin project for smartId iOS integration.
                       DESC
  s.homepage         = 'http://example.com'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Alejandro Ramirez' => 'jramirez@develsystems.com' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.dependency 'Flutter'
  s.dependency 'SmartId', '5.0.5'
  s.platform = :ios, '12.0'

  # Flutter.framework does not contain a i386 slice.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386' }
  s.swift_version = '5.0'
end
