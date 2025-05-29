platform :ios, '14.0'
 
target 'Sportycus' do
  use_frameworks!
 
  pod 'Kingfisher', '~> 7.0'
  pod 'ReachabilitySwift'
  pod 'Alamofire'
 
  post_install do |installer|
    installer.pods_project.targets.each do |target|
      target.build_configurations.each do |config|
        if config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'].to_f < 14.0
          config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '14.0'
        end
      end
    end
  end
end
