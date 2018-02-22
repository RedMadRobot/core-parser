#
# Be sure to run `pod lib lint CoreParser.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "CoreParser"
  s.version          = "2.2.4"
  s.summary          = "CoreParser"

  s.description      = "JSON Parser"

  s.license          = 'MIT'
  s.author           = { "Ivan Vavilov" => "iv@redmadrobot.com" }
  s.source           = { :git => "https://github.com/RedMadRobot/core-parser.git", :tag => s.version.to_s }
  s.homepage         = 'https://github.com/RedMadRobot/core-parser'

  s.platform     = :ios, '8.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes/**/*'

end
