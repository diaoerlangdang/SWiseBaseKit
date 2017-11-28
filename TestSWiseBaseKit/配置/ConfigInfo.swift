//
//  ConfigInfo.swift
//  TestSWiseBaseKit
//
//  Created by wuruizhi on 2017/11/7.
//  Copyright © 2017年 wuruizhi. All rights reserved.
//

import UIKit

class ConfigInfo: SWWConfigInfo {
    
    //单例
    public static let shareInstance = ConfigInfo()
    
    //是否登录
    public var isLogIn:Bool = false
    
    //用户名
    public var userName:String = ""
}
