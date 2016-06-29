#
# Be sure to run `pod lib lint HiPay.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'HiPay'
  s.version          = '0.8.0'
  s.summary          = 'Payment util with swift'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
                        移动应用支付接口。
                        使移动支付更简单。
                        支持微信支付，银联支付，支付宝支付
                       DESC

  s.homepage         = 'https://github.com/wuyingminhui/HiPay'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'jasonwoo' => 'wuyingminhui@gmail.com' }
  s.source           = { :git => 'https://github.com/wuyingminhui/HiPay.git', :tag => s.version.to_s }
  s.requires_arc     = true
  s.default_subspec = 'Core','AliPay','WxPay','UnionPay'
  # s.default_subspec = 'AlipayUtil'
  s.ios.deployment_target = '8.0'

  s.subspec 'Core' do |core|
    core.source_files = 'HiPay/Classes/HiPayCore'
    core.ios.library = 'c++', 'z'
    core.frameworks = 'CoreTelephony', 'SystemConfiguration', 'CFNetwork'
    core.xcconfig = { 'OTHER_LDFLAGS' => '-ObjC' }
  end

  s.subspec 'AliPay' do |alipay|
    alipay.source_files = 'HiPay/Classes/AlipaySDk/*.swift', 'HiPay/Classes/AlipaySDk/AlipaySDK.framework/Headers/*'
    alipay.vendored_frameworks = 'HiPay/Classes/AlipaySDk/AlipaySDK.framework'
    alipay.vendored_libraries = 'HiPay/Classes/AlipaySDk/*.a'
    alipay.resource = 'HiPay/Classes/AlipaySDk/AlipaySDK.bundle'
    alipay.public_header_files = 'HiPay/Classes/AlipaySDk/AlipaySDK.framework/Headers/**/*.h'
    alipay.frameworks = 'CoreMotion', 'CoreGraphics', 'CoreText', 'QuartzCore'
    alipay.dependency 'HiPay/Core'
  end

  s.subspec 'WxPay' do |wx|
    wx.source_files = 'HiPay/Classes/WxSDK'
    wx.vendored_libraries = 'HiPay/Classes/WxSDK/*.a'
    wx.ios.library = 'sqlite3.0'
    wx.dependency 'HiPay/Core'
  end

  s.subspec 'UnionPay' do |unionpay|
    unionpay.source_files = 'HiPay/Classes/UPPaySDK'
    unionpay.vendored_libraries = 'HiPay/Classes/UPPaySDK/*.a'
    unionpay.public_header_files = 'HiPay/Classes/UPPaySDK/*.h'
    unionpay.dependency 'HiPay/Core'
  end
end