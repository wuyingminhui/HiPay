//
//  BaseHiPay.swift
//  HiPay
//
//  Created by Jason on 16/6/17.
//  Copyright © 2016年 wuyingminhui@gmail.com. All rights reserved.
//

import Foundation

public class BaseHiPay: NSObject {
    private static let _sharedInstance = BaseHiPay()
    public class var sharedInstance: BaseHiPay {
        return _sharedInstance
    }
    
    public func handleOpenURL(url: NSURL) { }
    
    public func sendPay(channel: HiPayChannel, callBack: HiPayCompletedBlock) { }
    
    public func registerWxAPP(appid: String) { }
}