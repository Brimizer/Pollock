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
  s.license          = 'MIT'
  s.author           = { "Daniel Brim" => "brimizer@gmail.com" }
  s.source           = { :git => "https://github.com/brimizer/Pollock.git", :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/brimizer'
  # s.screenshots     = "www.example.com/screenshots_1", "www.example.com/screenshots_2"

  s.ios.deployment_target = '8.0'

  s.source_files = 'Source/*'

  s.requires_arc = true
end
