##支付宝支付
关于`HiPayAliPayOrder`参数, 请参考[官方说明](https://doc.open.alipay.com/doc2/detail?treeId=59&articleId=103663&docType=1), `appScheme`参数对应URL types里面的URL scheme, 建议使用appid.

***如果您之前没有加入统一回调，需要在AppDelegate中加入统一回调.***
```Swift
func application(application: UIApplication, openURL url: NSURL, sourceApplication: String?, annotation: AnyObject) -> Bool {
    return HiPay.handlerOpenURL(url)
}
    
func application(app: UIApplication, openURL url: NSURL, options: [String : AnyObject]) -> Bool {
    return HiPay.handlerOpenURL(url)
}
```

调用支付宝支付
```Swift
{
  ……
  var alipayOrder = HiPayAliPayOrder.init(
      partner: "商家id",
      seller_id: "支付宝账号",
      out_trade_no: "订单号",
      subject: "商品名称（该参数最长为128个汉字）",
      body: "商品详情",
      total_fee: 总金额（精确到小数点后两位）,
      notify_url: "服务器异步通知页面路径",
      payment_type: "支付类型（默认值为：1（商品购买））",
      sign: "签名",
      appScheme: "URL types 下的 URL Scheme")
  
  // 添加额外的参数
  alipayOrder.it_b_pay = "未付款交易的超时时间"
  // 更多参数app_id, appenv, goods_type, extern_token , rn_check, out_context
  
  let channel = HiPayChannel.aliPay(order: r_order)

  HiPay.createPayment(channel) { status in
    switch status {
    case .PaySuccess(_, let aliPayResult, _):
        print("支付成功: \(aliPayResult)")
    default:
        print("支付失败")
    }
  }
  ……
}
```

支付宝支付失败的状态有以下几种以供回调处理
```Swift
case 8000:
  payStatus = HiPayStatusCode.PayProcessing
case 4000:
  payStatus = HiPayStatusCode.PayErrPayFail
case 6001:
  payStatus = HiPayStatusCode.PayErrCodeUserCancel
case 6002:
  payStatus = HiPayStatusCode.PayErrNetWorkFail
default:
  payStatus = HiPayStatusCode.PayErrUnKnown
```
