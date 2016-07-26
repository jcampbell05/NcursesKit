#
# Be sure to run `pod lib lint NcursesKit.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'NcursesKit'
  s.version          = '0.1.0'
  s.summary          = 'A short description of NcursesKit.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/<GITHUB_USERNAME>/NcursesKit'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'James Campbell' => 'james@supmenow.com' }
  s.source           = { :git => 'https://github.com/<GITHUB_USERNAME>/NcursesKit.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.osx.deployment_target = '10.11'

  s.source_files = 'NcursesKit/Classes/**/*'
  s.vendored_library = 'Vendors/ncurses.5.4.dylib'
  s.preserve_paths = 'Vendors/ncurses.5.4.dylib'
  s.libraries = 'ncurses.5.4'
end
