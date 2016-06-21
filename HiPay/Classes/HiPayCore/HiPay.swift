//
//  HiPay.swift
//  HiPay
//
//  Created by Jason on 16/6/17.
//  Copyright © 2016年 wuyingminhui@gmail.com. All rights reserved.
//

import Foundation

public class HiPay: NSObject {
    /**
     调起支付
     
     - parameter channel:  支付渠道
     - parameter callBack: 支付回调
     */
    public class func createPayment(channel: HiPayChannel, callBack: HiPayCompletedBlock) {
        switch channel {
        case .weixin:
            if let wxPay = hipay_wxPay {
                wxPay.sendPay(channel, callBack: callBack)
            } else {
                callBack(.PayErrSDKNotFound)
            }
        case .aliPay:
            if let aliPay = hipay_aliPay {
                aliPay.sendPay(channel, callBack: callBack)
            } else {
                callBack(.PayErrSDKNotFound)
            }
        case .upPay:
            if let upPay = hipay_upPay {
                upPay.sendPay(channel, callBack: callBack)
            } else {
                callBack(.PayErrSDKNotFound)
            }
        }
    }
    
    /**
     从APP返回时执行的回调
     
     - parameter url: url
     
     - returns: 
     */
    public class func handlerOpenURL(url: NSURL) -> Bool {
        if let wxPay = hipay_wxPay {
            wxPay.handleOpenURL(url)
        }
        if let aliPay = hipay_aliPay {
            aliPay.handleOpenURL(url)
        }
        if let upPay = hipay_upPay {
            upPay.handleOpenURL(url)
        }
        return true
    }
    
    /**
     注册微信
     
     - parameter appid: appid
     */
    public class func registerWxAPP(appid: String) {
        if let wxPay = hipay_wxPay {
            wxPay.registerWxAPP(appid)
        }
    }
    
    // 银联支付
    private static var hipay_upPay: BaseHiPay? = {
        let upPayType = NSObject.hipay_classFromString("HiPayUPService") as? BaseHiPay.Type
        return upPayType?.sharedInstance
    }()
    // 微信支付
    private static var hipay_wxPay: BaseHiPay? = {
        let wxPayType = NSObject.hipay_classFromString("HiPayWxService") as? BaseHiPay.Type
        return wxPayType?.sharedInstance
    }()
    // 支付宝支付
    private static var hipay_aliPay: BaseHiPay? = {
        let aliPayType = NSObject.hipay_classFromString("HiPayAliService") as? BaseHiPay.Type
        return aliPayType?.sharedInstance
    }()
}