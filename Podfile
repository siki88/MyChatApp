source 'https://github.com/CocoaPods/Specs.git'
platform :ios,’10.0’
project ‘MyChat.xcodeproj'

# ignore all warnings from all pods
inhibit_all_warnings!
use_frameworks!

def shared_pods

pod 'Fabric'
pod 'Crashlytics'
pod ‘Firebase/Database’
pod 'Alamofire'

end


target ‘MyChat Live’ do
    shared_pods
end

target ‘MyChat Dev’ do
    shared_pods
end

