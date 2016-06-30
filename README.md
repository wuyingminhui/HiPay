# HiPay

[![CI Status](http://img.shields.io/travis/jasonwoo/HiPay.svg?style=flat)](https://travis-ci.org/jasonwoo/HiPay)
[![Version](https://img.shields.io/cocoapods/v/HiPay.svg?style=flat)](http://cocoapods.org/pods/HiPay)
[![License](https://img.shields.io/cocoapods/l/HiPay.svg?style=flat)](http://cocoapods.org/pods/HiPay)
[![Platform](https://img.shields.io/cocoapods/p/HiPay.svg?style=flat)](http://cocoapods.org/pods/HiPay)

#####统一 : HiPay 为统一的支付接口, 基于swift开发。 
#####实用 : HiPay 现支持微信支付, 支付宝支付, 银联支付主流支付渠道。
#####快捷 : HiPay 引入只需要几行代码, 正常配置, 就能解决几乎所有支付的问题.

## Installation

HiPay is available through [CocoaPods](http://cocoapods.org).
To install it, simply add the following line to your Podfile:

```ruby
pod "HiPay"
```
HiPay 可以通过 [CocoaPods](http://cocoapods.org) 安装(推荐). 
```ruby
pod "HiPay"
```
也可以将classes中的文件引入并设置相关Library Search Paths 及 Header Search Paths使用

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.


## Requirements
###HiPay 统一配置说明
***[注意] HiPay已自带SDK, 可以免去1.1, 1.2步骤, 有兴趣的同学深入研究的童鞋可以自行下载.***

####2.1 下载SDK
* [微信SDK下载](https://pay.weixin.qq.com/wiki/doc/api/app/app.php?chapter=11_1)
* [支付宝SDK下载](https://doc.open.alipay.com/doc2/detail?treeId=59&articleId=103563&docType=1)
* [银联SDK下载](https://open.unionpay.com/ajweb/help/file/toDetailPage?id=346&flag=2)

####2.2 导入SDK
SDK主要包含的文件

|微信            |支付宝              |银联支付            |
|:------:       |:------:           |:------:           |
|libWeChatSDK.a |AlipaySDK.framework|libPaymentControl.a|
|WechatAuthSDK.h|AlipaySDK.bundle   |UPPaymentControl.h |
|WXApi.h        |                   |                   |
|WXApiObject.h  |                   |                   |


####2.3 创建桥接文件`ProjectName-Bridging-Header.h`
正常情况下不需要桥接文件，如果您使用Example中的支付宝本地签名需要添加相应的桥接文件。
桥接文件内容如下:
```Swift
// Alipay
#import "DataSigner.h"
```
***注: 正常支付流程签名都必须在服务端完成。***

####2.4 Xcode相关设置
#####2.4.1 URL Types设置:
`URL Schemes`建议使用appid, 或者使用Bundle identifier
HiPay使用过程中需要添加两个URL Types回调协议， 如下图:
![图片](https://github.com/wuyingminhui/HiPay/blob/master/HiPay/Assets/url_scheme.png)

#####2.4.2 Http设置:
在Xcode7.0之后的版本中进行http请求时，需要在工程对应的plist文件中添加NSAppTransportSecurity  Dictionary 并同时设置里面NSAllowsArbitraryLoads 属性值为 YES，具体设置可参照以下截图：
![图片](https://github.com/wuyingminhui/HiPay/blob/master/HiPay/Assets/security.png)

#####2.4.3 添加协议白名单:

在Xcode7.0之后的版本中进行开发，需要在工程对应的plist文件中，添加LSApplicationQueriesSchemes  Array并加入weixin、uppaysdk、uppaywallet、uppayx1、uppayx2、uppayx3 这六个item
```Swift
<key>LSApplicationQueriesSchemes</key>
<array>
	<string>weixin</string>
  <string>uppaysdk</string>
  <string>uppaywallet</string>
  <string>uppayx1</string>
  <string>uppayx2</string>
  <string>uppayx3</string>
</array>
```
这里的白名单并不完整, 只是其中一部分, 因此在使用过程中, 可能会发出警告.

## Description
##HiPay的接口说明:
* [HiPay微信支付接口说明](https://github.com/wuyingminhui/HiPay/blob/master/HiPay/Classes/WxSDK/Guide.md)
* [HiPay支付宝接口说明](https://github.com/wuyingminhui/HiPay/tree/master/HiPay/Classes/AlipaySDk/Guide.md)
* [HiPay银联接口说明](https://github.com/wuyingminhui/HiPay/tree/master/HiPay/Classes/UPPaySDK/Guide.md)

## Author

jasonwoo, wuyingminhui@gmail.com

## License

HiPay is available under the MIT license. See the LICENSE file for more info.
