//
//  HiPayWxService.swift
//  HiPay
//
//  Created by Jason on 16/6/17.
//  Copyright © 2016年 wuyingminhui@gmail.com. All rights reserved.
//
//  微信支付

import Foundation

public class HiPayWxService: BaseHiPay, WXApiDelegate {
    var payCallBack: HiPayCompletedBlock?
    private static let _sharedInstance = HiPayWxService()
    override public class var sharedInstance: HiPayWxService {
        return _sharedInstance
    }
    
    public func onReq(req: BaseReq!) {
        
    }
    
    public func onResp(resp: BaseResp!) {
        // 微信支付
        print(resp)
        if resp is PayResp {
            payResponseParse(resp as! PayResp)
        }
        // 其他微信的响应, 可以在这里添加...
    }
    
    // 发送微信支付
    override public func sendPay(channel: HiPayChannel, callBack: HiPayCompletedBlock) {
        if case .weixin(let order)  = channel {
            guard WXApi.isWXAppInstalled() else {
                callBack(.PayErrWxUnInstall)
                return
            }
            let req = PayReq()
            req.openID = order.appid
            req.partnerId = order.partnerId
            req.prepayId = order.prepayid
            req.nonceStr = order.nonceStr
            req.timeStamp = order.timeStamp
            req.package = order.package
            req.sign = order.sign
            WXApi.sendReq(req)
            payCallBack = callBack
        }
    }
    
    /**
     从微信客户端返回
     
     - parameter url: url
     */
    override public func handleOpenURL(url: NSURL) {
        guard "pay" == url.host else { return }
        WXApi.handleOpenURL(url, delegate: self)
    }
    
    /**
     注册微信
     
     - parameter appid: appid
     */
    override public func registerWxAPP(appid: String) {
        WXApi.registerApp(appid)
    }
    
    // 处理支付结果
    private func payResponseParse(payResp: PayResp) {
        var payStatus: HiPayStatusCode
        switch WXErrCode(payResp.errCode) {
        case WXSuccess:
            payStatus = HiPayStatusCode.PaySuccess(wxPayResult: payResp.returnKey, aliPayResult: nil, upPayResult: nil)
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
        }
        payCallBack?(payStatus)
    }
}
