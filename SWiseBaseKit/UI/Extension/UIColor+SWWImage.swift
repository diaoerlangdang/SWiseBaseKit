//
//  UIColor+SWWImage.swift
//  TestSWiseBaseKit
//
//  Created by wuruizhi on 2017/11/1.
//  Copyright © 2017年 wuruizhi. All rights reserved.
//

import UIKit

extension UIColor {
    
    /**
     *  图片转为颜色；便捷初始化
     *
     *  - param image 图片
     *
     *  - return 颜色
     */
    convenience public init(image:UIImage) {
        self.init(patternImage: image)
    }
}
