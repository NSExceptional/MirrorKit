
Pod::Spec.new do |s|
    s.name             = "MirrorKit"
    s.version          = "2.0.0"
    s.summary          = "A library for reflection in Objectice-C."
    s.homepage         = "https://github.com/ThePantsThief/MirrorKit"
    s.license          = 'MIT'
    s.author           = { "ThePantsThief" => "tannerbennett@me.com" }
    s.source           = { :git => "https://github.com/NSExceptional/MirrorKit.git", :tag => s.version.to_s }
    s.social_media_url = 'https://twitter.com/NSExceptional'

    s.requires_arc = true
    s.ios.deployment_target = '7.0'
    s.osx.deployment_target = '10.8'

    s.private_header_files = 'MirrorKit/Private/*.h'
    s.public_header_files = 'MirrorKit/*.h', 'MirrorKit/Classes/*.h', 'MirrorKit/Categories/*.h'
    s.source_files = 'MirrorKit/*.{h,m}', 'MirrorKit/**/*.{h,m}'
end
