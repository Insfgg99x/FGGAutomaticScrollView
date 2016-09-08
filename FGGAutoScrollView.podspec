Pod::Spec.new do |s|
s.name         = "FGGAutoScrollView"
s.version      = "1.0.1"
s.summary      = "A class with ad. pics auotmatic scrolling."
s.homepage     = "https://github.com/Insfgg99x/FGGAutomaticScrollView"
s.license      = "MIT"
s.authors      = { "CGPointZero" => "newbox0512@yahoo.com" }
s.source       = { :git => "https://github.com/Insfgg99x/FGGAutomaticScrollView.git", :tag => "1.0.1"}
s.frameworks  = 'Foundation','UIKit'
s.ios.deployment_target = '6.0'
s.source_files = 'FGGAutomaticScrollView/*.{h,m}'
s.requires_arc = true
s.dependency 'SDWebImage'
#s.dependency 'pop'
end

