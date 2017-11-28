//
//  SWWColorFontDefines.swift
//  TestSWiseBaseKit
//
//  Created by wuruizhi on 2017/10/30.
//  Copyright © 2017年 wuruizhi. All rights reserved.
//

import UIKit


// MARK: 颜色

/**
 * 颜色
 *
 * - param hexRGB     颜色的十六进制值
 *
 * - return 颜色 UIColor
 */
func SWW_COLOR_HexRGB(hexRGB:Int) -> UIColor {
    
    return UIColor(red: CGFloat((hexRGB & 0xFF0000)>>16)/255.0, green: CGFloat((hexRGB & 0xFF00)>>8)/255.0, blue: CGFloat(hexRGB & 0xFF)/255.0, alpha: 1.0)
}


/**
 * 颜色
 *
 * - param red      红色
 * - param green    绿色
 * - param blue     蓝色
 * - param alpha    透明度
 *
 * - return 颜色 UIColor
 */
func SWW_COLOR_RGBA(red:Int, green:Int, blue:Int, alpha:Float) -> UIColor {
    
    return UIColor(red: CGFloat(red)/255.0, green: CGFloat(green)/255.0, blue: CGFloat(blue)/255.0, alpha: CGFloat(alpha))
}


/**
 * 颜色
 *
 * - param red      红色
 * - param green    绿色
 * - param blue     蓝色
 *
 * - return 颜色 UIColor
 */
func SWW_COLOR_RGB(red:Int, green:Int, blue:Int, alpha:Float) -> UIColor {
    
    return UIColor(red: CGFloat(red)/255.0, green: CGFloat(green)/255.0, blue: CGFloat(blue)/255.0, alpha: 1.0)
}

/**
 * 随机颜色
 *
 * - return 颜色 UIColor
 */
func SWW_COLOR_RANDOM() -> UIColor {
    let hue = CGFloat( Double(arc4random() % 256) / 256.0 );  //  0.0 to 1.0
    let saturation = CGFloat( Double(arc4random() % 128) / 256.0 ) + 0.5;  //  0.5 to 1.0, away from white
    let brightness = CGFloat( Double(arc4random() % 128) / 256.0 ) + 0.5;  //  0.5 to 1.0, away from black
    return UIColor(hue: hue, saturation: saturation, brightness: brightness, alpha: 1)
}

// MARK: 字体

/**
 * 字体
 *
 * - param size     字体大小
 *
 * - return 字体 UIFont
 */
func SWW_Font(size:Float) -> UIFont {
    return UIFont.systemFont(ofSize: CGFloat(size))
}

/**
 * 加粗字体
 *
 * - param size     字体大小
 *
 * - return 字体 UIFont
 */
func SWW_Font_Bold(size:Float) -> UIFont {
    return UIFont.boldSystemFont(ofSize: CGFloat(size))
}

