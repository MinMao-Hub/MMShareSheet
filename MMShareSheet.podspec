Pod::Spec.new do |s|

  s.name         = "MMShareSheet"
  s.version      = "0.0.3"
  s.summary      = "MMShareSheet is an simple pop-up selection box(ShareSheet) written in pure Swift"
  s.homepage     = "https://github.com/MinMao-Hub"
  s.license      = "MIT"
  s.author       = { "gyh" => "m12860gyh@gmail.com" }
  s.platform     = :ios, "8.0"
  s.source       = { :git => "https://github.com/MinMao-Hub/MMShareSheet.git", :tag => "#{s.version}" }
  s.source_files = "Components"
end
