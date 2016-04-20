#
# Be sure to run `pod lib lint CoreParser.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "CoreParser"
  s.version          = "0.1.0"
  s.summary          = "CoreParser"

  s.description      = <<-DESC
                       DESC

  s.license          = 'MIT'
  s.author           = { "Anton Poderechin" => "ap@redmadrobot.com" }
  s.source           = { :git => "https://github.com/<GITHUB_USERNAME>/CoreParser.git", :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.platform     = :ios, '8.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes/**/*'
  s.resource_bundles = {
    'CoreParser' => ['Pod/Assets/*.png']
  }

end
