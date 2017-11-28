
//
//  SWWRegexUtils.swift
//  TestSWiseBaseKit
//
//  Created by wuruizhi on 2017/11/2.
//  Copyright © 2017年 wuruizhi. All rights reserved.
//

import UIKit

class SWWRegexUtils {

    /**
     *  正则表达式的简单封装，判断是否满足条件
     *
     *  param regex 表达式
     *  param value 要验证的数据
     *
     *  return 满足true，否则false
     */
    class func isValidateByRegex(regex:String, value:String) -> Bool {
        let pre = NSPredicate(format: "SELF MATCHES %",regex)
        return pre.evaluate(with:value)
    }
    
    /**
     *  是否为手机号
     *
     *  param mobileNum 手机号
     *
     *  return 是true，否false
     */
    class func isMobileNumber(mobileNum:String) -> Bool {
        
        if mobileNum.count != 11 {
            return false
        }
        
        /**
         * 手机号码:
         * 13[0-9], 14[5,7], 15[0, 1, 2, 3, 5, 6, 7, 8, 9], 17[0, 1, 6, 7, 8], 18[0-9]
         * 移动号段: 134,135,136,137,138,139,147,150,151,152,157,158,159,170,178,182,183,184,187,188
         * 联通号段: 130,131,132,145,155,156,170,171,175,176,185,186
         * 电信号段: 133,149,153,170,173,177,180,181,189
         */
        let MOBILE = "^1(3[0-9]|4[57]|5[0-35-9]|7[0135678]|8[0-9])\\d{8}$"
        /**
         * 中国移动：China Mobile
         * 134,135,136,137,138,139,147,150,151,152,157,158,159,170,178,182,183,184,187,188
         */
        let CM = "^1(3[4-9]|4[7]|5[0-27-9]|7[08]|8[2-478])\\d{8}$"
        /**
         * 中国联通：China Unicom
         * 130,131,132,145,155,156,170,171,175,176,185,186
         */
        let CU = "^1(3[0-2]|4[5]|5[56]|7[0156]|8[56])\\d{8}$"
        /**
         * 中国电信：China Telecom
         * 133,149,153,170,173,177,180,181,189
         */
        let CT = "^1(3[3]|4[9]|53|7[037]|8[019])\\d{8}$"
        
        
        
        let regextestmobile = NSPredicate(format: "SELF MATCHES %", MOBILE)
        let regextestcm = NSPredicate(format: "SELF MATCHES %", CM)
        let regextestcu = NSPredicate(format: "SELF MATCHES %", CU)
        let regextestct = NSPredicate(format: "SELF MATCHES %", CT)
        
        if regextestmobile.evaluate(with: mobileNum) || regextestcm.evaluate(with: mobileNum) ||
             regextestct.evaluate(with: mobileNum) || regextestcu.evaluate(with: mobileNum){
            
            return true
        }
        else {
            return false
        }
    }
    
    /**
     *  判断是否为邮箱
     *
     *  param email 邮箱
     *
     *  return 是true，否false
     */
    class func isEmailAddress(email:String) -> Bool {
        
        let emailRegex = "[A-Za-z0-9._%+-]+[A-Za-z0-9.-]+\\\\.[A-Za-z]{2,4}"
        return SWWRegexUtils.isValidateByRegex(regex: emailRegex, value: email)
    }
    
    /**
     *  简单的身份证号判断
     *
     *  param cardNum 身份证号
     *
     *  return 是true，否false
     */
    class func simpleVerifyIdentityCardNum(cardNum:String) -> Bool {
        
        let regex = "^(\\\\d{14}|\\\\d{17})(\\\\d|[xX])$"
        return SWWRegexUtils.isValidateByRegex(regex: regex, value: cardNum)
    }
    
    /**
     *  密码是否有效,数字 + 字母，只能包含“字母”，“数字”
     *
     *  @param password     密码
     *  @param minLen       最小长度
     *  @param maxLen       最大长度
     *
     *  @return 满足true，否则false
     */
    class func isValidPassword(password:String, minLen:Int, maxLen:Int) -> Bool {
        //数字 + 字母，只能包含“字母”，“数字”
        let regex = "^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{\(minLen),\(maxLen)}$"
        return SWWRegexUtils.isValidateByRegex(regex: regex, value: password)
    }
    
    /**
     *  判断是否为纯数字
     *
     *  @param str     数据
     *
     *  @return 满足true，否则false
     */
    class func isNumber(str:String) -> Bool {
        let regex = "[0-9]*"
        let pred = NSPredicate(format: "SELF MATCHES %@",regex)
        return pred.evaluate(with:str)
    }
    
    
    /**
     *  判断是否为全字母
     *
     *  @param str     数字
     *
     *  @return 满足true，否则false
     */
    func isAlphabet(str:String) -> Bool {
        let regex = "[a-zA-Z]*"
        let pred = NSPredicate(format: "SELF MATCHES %@",regex)
        return pred.evaluate(with:str)
    }
}
