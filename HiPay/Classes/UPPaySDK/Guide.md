##银联支付

***如果您之前没有加入统一回调，需要在AppDelegate中加入统一回调.***
```Swift
func application(application: UIApplication, openURL url: NSURL, sourceApplication: String?, annotation: AnyObject) -> Bool {
    return HiPay.handlerOpenURL(url)
}
    
func application(app: UIApplication, openURL url: NSURL, options: [String : AnyObject]) -> Bool {
    return HiPay.handlerOpenURL(url)
}
```

调用银联支付:

```Swift
// tn:          订单号
// appScheme:   参数对应URL types里面的URL scheme
// mode:        接入模式, "00"生产模式, "01"开发测试模式
{
  ……
  let order = HiPayUpOrder.init(
    tn: "订单号",
    appScheme: "URL scheme",
    mode: "01",
    viewController: self)
  let channel = HiPayChannel.upPay(order: order)
  HiPay.createPayment(channel) { status in
    switch status {
      case .PaySuccess(_, _, let upPayResult):
        print("支付成功: \(upPayResult)")
      default:
        print("支付失败")
    }
  }
  ……
}
// 支付成功后, 返回一个字典对象 --- upPayResult
// 格式 { "sign":"" , "data":"" }
// sign = 签名后做Base64的数据
// data = "pay_result=支付结果(success，fail，cancel)&tn=订单号&cert_id=证书id"
```

银联支付失败的状态有以下几种以供回调处理
```Swift
case "cancel":
  self.payCallBack?(HiPayStatusCode.PayErrCodeUserCancel)
case "fail":
  self.payCallBack?(HiPayStatusCode.PayErrPayFail)
default:
  self.payCallBack?(HiPayStatusCode.PayErrUnKnown)
}
```


***微信支付等支付渠道都存在的问题:***

***商户订单是否成功支付应该以商户后台收到全渠道返回的支付结果为准，此处支付控件返回的结果仅作为参考。***
