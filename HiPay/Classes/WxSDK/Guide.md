
##微信支付
关于微信支付的参数, 请参考[官方说明](https://pay.weixin.qq.com/wiki/doc/api/app/app.php?chapter=9_12&index=2).

在AppDelegate中的application: didFinishLaunchingWithOptions: 方法中注册微信.
```Swift
func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
  ……
  HiPay.registerWxAPP(WX_APPID)
  ……
}
```
***如果您之前没有加入统一回调，需要在AppDelegate中加入统一回调.***
```Swift
func application(application: UIApplication, openURL url: NSURL, sourceApplication: String?, annotation: AnyObject) -> Bool {
    return HiPay.handlerOpenURL(url)
}
    
func application(app: UIApplication, openURL url: NSURL, options: [String : AnyObject]) -> Bool {
    return HiPay.handlerOpenURL(url)
}
```
调起微信支付.
```Swift
{
  ……
  let order = HiPayWxOrder.init(
    appid: "appid",
    partnerId: "商家id",
    prepayid: "订单id",
    nonceStr: "随机字符串,防止重发",
    timeStamp: 时间戳,防止重发(例: 1459014554),
    package: "扩展字段(暂填写固定值Sign=WXpay)",
    sign: "签名")
  let channel = HiPayChannel.weixin(order: order)
  HiPay.createPayment(channel) { status in
    switch status {
      case .PaySuccess(let wxPayResult, _, _):
        print("支付成功: \(wxPayResult)")
      default:
        print("支付失败")
    }
  }
  ……
}
```
支付失败的状态有以下几种以供回调处理
```Swift
case WXErrCodeUserCancel:
    payStatus = HiPayStatusCode.PayErrCodeUserCancel
case WXErrCodeSentFail:
    payStatus = HiPayStatusCode.PayErrSentFail
case WXErrCodeAuthDeny:
    payStatus = HiPayStatusCode.PayErrAuthDeny
case WXErrCodeUnsupport:
    payStatus = HiPayStatusCode.PayErrWxUnsupport
default:
    payStatus = HiPayStatusCode.PayErrUnKnown
```


***微信支付等支付渠道都存在的问题:***

***商户订单是否成功支付应该以商户后台收到全渠道返回的支付结果为准，此处支付控件返回的结果仅作为参考。***
