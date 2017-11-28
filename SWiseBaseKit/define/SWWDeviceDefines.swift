//
//  SWWDeviceDefines.swift
//  TestSWiseBaseKit
//
//  Created by wuruizhi on 2017/10/30.
//  Copyright © 2017年 wuruizhi. All rights reserved.
//

import UIKit

/**
 *  顶部导航栏和底部导航栏的高度
 *
 */
let SWW_NAVIGATION_BAR_HEIGHT = CGFloat(64.0)
let SWW_TARBAR_HEIGHT = CGFloat(49.0)
let SWW_STATUS_BAR_HEIGHT = CGFloat(20.0)

/** 屏幕宽度 */
let SWW_SCREEN_WIDTH = UIScreen.main.bounds.size.width

/** 屏幕高度 */
let SWW_SCREEN_HEIGHT = UIScreen.main.bounds.size.height

/** 去除导航栏高度 */
let SWW_SCREEN_VIEW_HEIGHT = CGFloat(SWW_SCREEN_HEIGHT - SWW_NAVIGATION_BAR_HEIGHT)



//是否为iOS 7.0
let SWW_iOS7 = Double(UIDevice.current.systemVersion)! >= 7.0 ? true : false

//是否为iOS 8.0
let SWW_iOS8 = Double(UIDevice.current.systemVersion)! >= 8.0 ? true : false

//是否为iOS 9.0
let SWW_iOS9 = Double(UIDevice.current.systemVersion)! >= 9.0 ? true : false

//是否为iOS 10.0
let SWW_iOS10 = Double(UIDevice.current.systemVersion)! >= 10.0 ? true : false

//是否为iOS 11.0
let SWW_iOS11 = Double(UIDevice.current.systemVersion)! >= 11.0 ? true : false

//是否横屏
let SWW_IS_LANDSCAPE = ((UIDevice.current.orientation == .landscapeLeft) || (UIDevice.current.orientation == .landscapeRight))


//判断设备
let SWW_IS_IPAD = (UIDevice.current.userInterfaceIdiom == .pad)

let SWW_IS_IPHONE = (UIDevice.current.userInterfaceIdiom == .phone)

//判断设备型号
let SWW_IS_IPHONE4 = (SWW_IS_IPHONE && (UIScreen.main.bounds.size.height < 568.0))

let SWW_IS_IPHONE5 = (SWW_IS_IPHONE && (UIScreen.main.bounds.size.height == 568.0))

let SWW_IS_IPHONE6 = (SWW_IS_IPHONE && (UIScreen.main.bounds.size.height == 667.0))

let SWW_IS_IPHONE6PLUS = (SWW_IS_IPHONE && ((UIScreen.main.bounds.size.height == 736.0) || UIScreen.main.bounds.size.width == 736.0))

let SWW_IS_IPHONEX = (SWW_IS_IPHONE && (UIApplication.shared.statusBarFrame.size.height == 44))

