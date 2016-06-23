//
//  HiPayNSObjectExtension.swift
//  HiPay
//
//  Created by Jason on 16/6/17.
//  Copyright © 2016年 wuyingminhui@gmail.com. All rights reserved.
//

import Foundation

extension NSObject {
    /**
     swift中把字符串转换成Class对象
     
     - parameter className: 需要转换的字符串
     
     - returns: 如果转换成功，返回AnyClass，否则返回nil
     */
    class func hipay_classFromString(className: String) -> AnyClass? {
        let appName = "HiPay"
        let classStringName = "_TtC\(appName.characters.count)\(appName)\(className.characters.count)\(className)"
        let  cls: AnyClass? = NSClassFromString(classStringName)
        return cls
    }
}