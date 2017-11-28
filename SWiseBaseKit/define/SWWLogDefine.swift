//
//  SWWLogDefine.swift
//  TestSWiseBaseKit
//
//  Created by wuruizhi on 2017/11/2.
//  Copyright © 2017年 wuruizhi. All rights reserved.
//

import Foundation

/**
 * 打印日志
 *
 * - param item 信息
 */
func SWWLog(_ item:Any) {
    
    if SWWBaseKitConfig.debug {
        print(item)
    }
}


/**
 * 打印详细日志，包括：时间、文件、行数、函数名
 *
 * - param item 信息
 */
func SWWLogDetails(_ item:Any, _ file:String = #file, _ line: Int = #line, _ function: String = #function) {
    
    if SWWBaseKitConfig.debug {
        print("<时间:\(Date())> <文件名:\(file)> <函数名:\(function)> <行号:\(line)> ",item)
    }
    
}
