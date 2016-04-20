#
# Be sure to run `pod lib lint CoreParser.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "CoreParser"
  s.version          = "1.0.0"
  s.summary          = "CoreParser"

  s.description      = "Библиотека распознавания серверной выдачи"

  s.license          = 'MIT'
  s.author           = { "Anton Poderechin" => "ap@redmadrobot.com" }
  s.source           = { :git => "git@git.redmadrobot.com:foundation-ios/Parser.git", :tag => s.version.to_s }

  s.platform     = :ios, '8.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes/**/*'
  s.resource_bundles = {
    'CoreParser' => ['Pod/Assets/*.png']
  }

end
