# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'INUnion(2)' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

  # Pods for INUnion(2)

pod 'FSCalendar'
pod 'Alamofire', '~> 4.6'
pod "Device", '~> 3.0.3'
pod 'CodableAlamofire'
pod 'Kingfisher'
pod "BSImagePicker"
pod 'Toast-Swift', '~> 3.0.1'

post_install do |installer|
    installer.pods_project.build_configurations.each do |config|
        config.build_settings.delete('CODE_SIGNING_ALLOWED')
        config.build_settings.delete('CODE_SIGNING_REQUIRED')
    end
end
end
