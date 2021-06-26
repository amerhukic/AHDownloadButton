Pod::Spec.new do |s|
  s.name             = 'AHDownloadButton'
  s.version          = '1.2.0'
  s.summary          = 'Customisable download button with progress animation'

  s.description      = <<-DESC
  AHDownloadButton is a customisable download button similar to the download button in the latest version of Apple's App Store app (since iOS 11).
  It features download progress animation as well as animated transitions between download states: start download, pending, downloading and downloaded. 
                       DESC

  s.homepage         = 'https://github.com/amerhukic/AHDownloadButton'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Amer Hukić' => 'hukicamer@gmail.com' }
  s.source           = { :git => 'https://github.com/amerhukic/AHDownloadButton.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/hukicamer'

  s.ios.deployment_target = '8.0'
  s.source_files = 'Sources/AHDownloadButton/Classes/**/*'
  s.frameworks = 'UIKit'
  s.swift_version = '5.0'
end
