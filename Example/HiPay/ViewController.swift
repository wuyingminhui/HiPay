//
//  ViewController.swift
//  HiPay
//
//  Created by jasonwoo on 06/21/2016.
//  Copyright (c) 2016 jasonwoo. All rights reserved.
//

import UIKit
import HiPay

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func Wxpay_press(sender: UIButton) {
        let order = HiPayWxOrder.init(appid: WxConstant.weixin_pay_appid,
                                      partnerId: WxConstant.weixin_pay_partnerId,
                                      prepayid: "wx20160701113251edd129d66c0401731883",
                                      nonceStr: WxConstant.weixin_pay_norstr,
                                      timeStamp: UInt32("1467343969")!,
                                      package: "Sign=WXPay",
                                      sign: "5E6A2F52C6D6964AFA4FFDF00A5D1D88")
        let channel = HiPayChannel.weixin(order: order)
        HiPay.createPayment(channel) { status in
            switch status {
            case .PaySuccess(_, let aliPayResult, _):
                print("支付成功: \(aliPayResult)")
            default:
                print("支付失败: \(status)")
            }
        }
    }

    @IBAction func Alipay_press(sender: UIButton) {
        
        // 尝试本地签名(不推荐使用)，一般签名来源于后端
        var alipayOrder = HiPayAliPayOrder.init(
            partner: AlipayConstant.alipay_pay_partnerId,
            seller_id: AlipayConstant.alipay_pay_sellerId,
            out_trade_no: "12312312312321",
            subject: "测试",
            body: "this is a goods",
            total_fee: NSString(format: "%.2f", 0.01) as String,
            notify_url: "http://www.hicto.tech",
            payment_type: "1",
            sign: "", appScheme: "HiPay")
        alipayOrder.it_b_pay = "30m"
        print(alipayOrder.toOrderString())
        let orderstring = "partner=\"\(alipayOrder.partner)\"&seller_id=\"\(alipayOrder.seller_id)\"&out_trade_no=\"\(alipayOrder.out_trade_no)\"&subject=\"\(alipayOrder.subject)\"&body=\"\(alipayOrder.body)\"&total_fee=\"\(alipayOrder.total_fee)\"&notify_url=\"\(alipayOrder.notify_url)\"&service=\"\(alipayOrder.service)\"&payment_type=\"\(alipayOrder.payment_type)\"&_input_charset=\"\(alipayOrder._input_charset)\""
        print(orderstring)
        let signer = CreateRSADataSigner(AlipayConstant.alipay_pay_rsa_private);
        let signedString = signer.signString(orderstring);
        
        
        // 使用sign一起正式调用
        let r_order = HiPayAliPayOrder.init(
            partner: AlipayConstant.alipay_pay_partnerId,
            seller_id: AlipayConstant.alipay_pay_sellerId,
            out_trade_no: "12312312312321",
            subject: "测试",
            body: "this is a goods",
            total_fee: NSString(format: "%.2f", 0.01) as String,
            notify_url: "http://www.hicto.tech",
            payment_type: "1",
            sign: signedString, appScheme: "HiPay")
        let channel = HiPayChannel.aliPay(order: r_order)
        HiPay.createPayment(channel) { status in
            switch status {
            case .PaySuccess(_, let aliPayResult, _):
                print("支付成功: \(aliPayResult)")
            default:
                print("支付失败: \(status)")
            }
        }
    }
    
    @IBAction func UPpay_press(sender: UIButton) {
        let order = HiPayUpOrder.init(
            tn: "201607011103092548018", // http://101.231.204.84:8091/sim/getacptn
            appScheme: "HiPay",
            mode: "01",
            viewController: self)
        let channel = HiPayChannel.upPay(order: order)
        HiPay.createPayment(channel) { status in
            switch status {
            case .PaySuccess(_, _, let upPayResult):
                print("支付成功: \(upPayResult)")
            default:
                print(status)
                print("支付失败")
            }
        }
    }
}

