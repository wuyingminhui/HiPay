//
//  HiPayChannel.swift
//  HiPay
//
//  Created by Jason on 16/6/17.
//  Copyright © 2016年 wuyingminhui@gmail.com. All rights reserved.
//

import Foundation
/**
 支付通道
 
 - weixin: 微信支付
 - aliPay: 支付宝支付
 - upPay:  银联支付
 */
public enum HiPayChannel {
    /**
     *  微信支付
     *
     *  @param HiPayWxOrder 订单
     */
    case weixin(order: HiPayWxOrder)
    /**
     *  支付宝
     *
     *  @param HiPayAliPayOrder 订单
     */
    case aliPay(order: HiPayAliPayOrder)
    
    /**
     *  银联支付
     *
     *  @param HiPayUpOrder 订单
     */
    case upPay(order: HiPayUpOrder)
}