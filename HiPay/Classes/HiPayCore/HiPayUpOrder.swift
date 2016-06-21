//
//  HiPayUpOrder.swift
//  HiPay
//
//  Created by Jason on 16/6/17.
//  Copyright © 2016年 wuyingminhui@gmail.com. All rights reserved.
//
//  银联支付订单

import Foundation

/**
 *  银联订单
 */
public struct HiPayUpOrder {
     /// 订单id
    public var tn: String
     /// URL types 下的 URL Scheme
    public var appScheme: String
     /// 接入模式（00生产环境，01开发测试环境）
    public var mode: String
     /// 视图控制器
    public var viewController: UIViewController
    
    public init(tn: String, appScheme: String, mode: String, viewController: UIViewController) {
        self.tn = tn
        self.appScheme = appScheme
        self.mode = mode
        self.viewController = viewController
    }
}