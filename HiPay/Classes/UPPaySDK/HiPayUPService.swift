//
//  HiPayUPService.swift
//  HiPay
//
//  Created by Jason on 16/6/17.
//  Copyright © 2016年 wuyingminhui@gmail.com. All rights reserved.
//
//  银联支付

import Foundation

public class HiPayUPService: BaseHiPay {
    private var payCallBack: HiPayCompletedBlock?
    private static let _sharedInstance = HiPayUPService()
    override public class var sharedInstance: HiPayUPService {
        return _sharedInstance
    }
    
    override public func sendPay(channel: HiPayChannel, callBack: HiPayCompletedBlock) {
        payCallBack = callBack
        if case .upPay(let order) = channel {
            UPPaymentControl.defaultControl().startPay(order.tn, fromScheme: order.appScheme, mode: order.mode, viewController: order.viewController)
        }
    }
    
    override public func handleOpenURL(url: NSURL) {
        guard "uppayresult" == url.host else { return }
        UPPaymentControl.defaultControl().handlePaymentResult(url) { [unowned self] stringCode, resultDic in
            switch stringCode {
            case "success":
                self.payCallBack?(HiPayStatusCode.PaySuccess(wxPayResult: nil, aliPayResult: nil, upPayResult: resultDic as! [String:AnyObject]?))
            case "cancel":
                self.payCallBack?(HiPayStatusCode.PayErrCodeUserCancel)
            case "fail":
                self.payCallBack?(HiPayStatusCode.PayErrPayFail)
            default:
                self.payCallBack?(HiPayStatusCode.PayErrUnKnown)
            }
        }
    }
    
}