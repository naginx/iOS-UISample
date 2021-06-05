# Uncomment the next line to define a global platform for your project
platform :ios, '13.0'

target 'iOS-UISample' do
  use_frameworks!

  # Pods for iOS-UISample
  pod 'EnhancedCircleImageView'
  pod 'FontAwesome.swift'
  pod 'MessageKit'
  pod 'SDWebImage'
  pod 'SnapKit'
end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '13.0'

      # cocoapods 1.10以前で発生する、ライブラリ内の「Double-quoted include」の警告を抑制する
      config.build_settings['CLANG_WARN_QUOTED_INCLUDE_IN_FRAMEWORK_HEADER'] = "No"
    end
  end
end
