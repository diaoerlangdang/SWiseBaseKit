//
//  UIImage+SWWStretch.swift
//  TestSWiseBaseKit
//
//  Created by wuruizhi on 2017/11/1.
//  Copyright © 2017年 wuruizhi. All rights reserved.
//

import UIKit

extension UIImage {
    
    
    /**
     *  图片中间1*1拉伸；便捷初始化
     *
     *  - param imageName  图片名
     *
     *  - return 拉伸的图片
     */
    convenience public init?(strechImageName:String) {
        let image:UIImage? = UIImage(named: strechImageName)
        if image == nil || image?.cgImage == nil {
            return nil
        }
        self.init(cgImage: image!.cgImage!)
    }
    
    /**
     *  图片中间1*1拉伸
     *
     *  - return 拉伸后的图片
     */
    public func strechImage() -> UIImage {
        // 设置端盖的值
        let top = self.size.height * 0.5;
        let left = self.size.width * 0.5;
        let bottom = self.size.height * 0.5;
        let right = self.size.width * 0.5;
        
        // 设置端盖的值
        let edgeInsets = UIEdgeInsetsMake(top, left, bottom, right);
        
        // 拉伸图片
        return self.resizableImage(withCapInsets: edgeInsets, resizingMode: .stretch)
    }
}
