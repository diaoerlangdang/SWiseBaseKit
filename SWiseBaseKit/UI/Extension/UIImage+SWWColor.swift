//
//  UIImage+SWWColor.swift
//  TestSWiseBaseKit
//
//  Created by wuruizhi on 2017/11/1.
//  Copyright © 2017年 wuruizhi. All rights reserved.
//

import UIKit

extension UIImage {
    
    /**
     *  颜色转为图片
     *
     *  - param color 图片颜色
     *  - param size  图片尺寸
     *
     *  - return 图片
     */
    convenience public init?(color:UIColor, size:CGSize) {
        let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(color.cgColor)
        context?.fill(rect)
        let theImage:UIImage? = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext();
        
        if theImage == nil || theImage?.cgImage == nil {
            return nil
        }
        else {
            self.init(cgImage: theImage!.cgImage!)
        }
    }
    
    /**
     *  颜色转为图片，大小为1*1
     *
     *  - param color 图片颜色
     *
     *  - return 图片
     */
    convenience public init?(color:UIColor) {
        let size = CGSize(width: 1, height: 1)
        self.init(color: color, size: size)
    }
}
