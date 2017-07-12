#
#  Be sure to run `pod spec lint XYWAppVersionHelper.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|


  s.name         = "XYWhttpManager"
  s.version      = "1.0.1"
  s.summary      = "XYWhttpManager is a helper class  -bad english"

  s.description  = <<-DESC
                          a HTTPSession manager,based on afnetworking 3.x , you can set header or others ,and reveak afn leak issues.
                   DESC

  s.homepage     = "https://github.com/xueyongwei/XYWhttpManager"


  s.license      = "MIT"
  

  s.author             = { "xueyognwei" => "xueyongwei@foxmail.com" }


  s.platform     = :ios
  s.platform     = :ios, "8.0"


  s.source       = { :git => "https://github.com/xueyongwei/XYWhttpManager.git", :tag => "#{s.version}" }


  s.source_files  = "XYWhttpManager/*.{h,m}"
  s.dependency 'AFNetworking'
  

end
