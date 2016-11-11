Pod::Spec.new do |s|
  s.name         = "MICountryPicker"
  s.version      = "0.2.2"
  s.summary      = "MICountryPicker is a country picker controller for iOS8+ with an option to search"
  s.homepage     = "https://github.com/mustafaibrahim989/MICountryPicker"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author             = { " Mustafa Ibrahim"  => "mustafa.ibrahim989@gmail.com" }
  s.social_media_url   = "https://twitter.com/mibrahim989"

  s.platform     = :ios
  s.ios.deployment_target = "8.0"
  s.source       = { :git => "https://github.com/mustafaibrahim989/MICountryPicker.git", :tag => s.version }
  s.source_files  = 'Source/*.swift'
  s.resources = ['Source/assets.bundle', 'Source/CallingCodes.plist']
  s.requires_arc = true
end
