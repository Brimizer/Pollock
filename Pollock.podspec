#
# Be sure to run `pod lib lint Pollock.podspec' to ensure this is a
# valid spec and remove all comments before submitting the spec.
#
# Any lines starting with a # are optional, but encouraged
#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "Pollock"
  s.version          = "0.0.1"
  s.summary          = "An iOS finger-drawing library."
  s.description      = <<-DESC
                       Pollock is an iOS library that allows you to create
                       apps with fingerpaint without having to worry about
                       touch events, view management, or brush creation.

                       Use one of the provided brushes or create your own
                       for exceptional art.
                       DESC
  s.homepage         = "https://github.com/brimizer/Pollock"
  # s.screenshots     = "www.example.com/screenshots_1", "www.example.com/screenshots_2"
  s.license          = 'MIT'
  s.author           = { "Daniel Brim" => "brimizer@gmail.com" }
  s.source           = { :git => "https://github.com/brimizer/Pollock.git", :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/brimizer'

  s.platform     = :ios, '8.3'
  s.requires_arc = true

  s.source_files = 'Source/*'

  # s.resource_bundles = {
  #   'Pollock' => ['Pod/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
