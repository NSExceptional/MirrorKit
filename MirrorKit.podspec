
Pod::Spec.new do |s|
  s.name             = "MirrorKit"
  s.version          = "1.3.0"
  s.summary          = "A library for reflection in Objectice-C."
  s.homepage         = "https://github.com/NSExceptional/MirrorKit"
  s.license          = 'MIT'
  s.author           = { "NSExceptional" => "tannerbennett@me.com" }
  s.source           = { :git => "https://github.com/NSExceptional/MirrorKit.git", :tag => s.version.to_s }

  s.requires_arc = true
  s.ios.deployment_target = '7.0'
  s.osx.deployment_target = '10.8'

  s.source_files = 'Pod/**/*', 'Pod/*'
end
