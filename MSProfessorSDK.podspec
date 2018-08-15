#
# Be sure to run `pod lib lint MSProfessorSDK.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'MSProfessorSDK'
  s.version          = '0.0.1'
  s.summary          = 'MSProfessorSDK 插件'

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/7General'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'wanghuizhou21@163.com' => 'wanghuizhou@guazi.com' }
  s.source           = { :git => 'https://github.com/7General/MSProfessorSDK.git', :tag => s.version.to_s }

  s.ios.deployment_target = '8.0'

  s.source_files = 'MSProfessorSDK/Classes/**/*'
  
   s.resource_bundles = {
     'MSProfessorSDK' => ['MSProfessorSDK/Assets/**']
   }
   ## 统计fps
   s.subspec 'fps' do |fps|
       fps.source_files = 'MSProfessorSDK/Classes/fps/*.{h,m}'
       #fps.public_header_files = 'MSProfessorSDK/Classes/fps/**/**'
   end
   ## 导航栏底线
   s.subspec 'uiview' do |uiview|
       uiview.source_files = 'MSProfessorSDK/Classes/uiview/*.{h,m}'
       #uiview.public_header_files = 'MSProfessorSDK/Classes/uiview/**/**'
   end
   


end
