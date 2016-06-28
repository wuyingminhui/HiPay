//
//  HiPayAliPay.swift
//  HiPay
//
//  Created by Jason on 16/6/17.
//  Copyright © 2016年 wuyingminhui@gmail.com. All rights reserved.
//
//  支付宝

import Foundation

public class HiPayAliService: BaseHiPay {
    var payCallBack: HiPayCompletedBlock?
    private static let _sharedInstance = HiPayAliService()
    override public class var sharedInstance: HiPayAliService {
        return _sharedInstance
    }
    
    // 发送支付宝支付
    override public func sendPay(channel: HiPayChannel, callBack: HiPayCompletedBlock) {
        payCallBack = callBack
        if case .aliPay(let order) = channel {
            AlipaySDK.defaultService().payOrder(order.toOrderString(), fromScheme: order.appScheme, callback: { [unowned self] resultDic in
                if let dic = resultDic as? [String:AnyObject] {
                    let payStatus = self.aliPayResultHandler(dic)
                    self.payCallBack?(payStatus)
                }
            })
        }
    }
    
    /**
     从支付宝返回到app
     
     - parameter url: url
     */
    override public func handleOpenURL(url: NSURL) {
        guard url.host == "safepay" || url.host == "platformapi" else { return }
        AlipaySDK.defaultService().processOrderWithPaymentResult(url, standbyCallback: { [unowned self] resultDic in
            if let dic = resultDic as? [String:AnyObject] {
                let payStatus = self.aliPayResultHandler(dic)
                self.payCallBack?(payStatus)
            }
        })
    }
    
    /**
     支付宝支付返回的结果处理
     
     - parameter resultDic: 支付宝返回的结果
     
     - returns: 返回处理结果
     */
    private func aliPayResultHandler(resultDic: [String:AnyObject]) -> HiPayStatusCode {
        var payStatus: HiPayStatusCode
        switch resultDic["resultStatus"]!.intValue {
        case 9000:
            payStatus = HiPayStatusCode.PaySuccess(wxPayResult: nil, aliPayResult: resultDic["result"]?.stringValue, upPayResult: nil)
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
        }
        return payStatus
    }

    /**
     支付宝支付返回的结果处理

     - parameter orderString: 订单字符串

     - parameter private_key: 商户私钥
     
     - returns: 返回处理结果
     */
    
    private func alipaySign (orderString: String, private_key: String) -> String {
        return CreateRSADataSigner(private_key).signString(orderString);
    }
    
}