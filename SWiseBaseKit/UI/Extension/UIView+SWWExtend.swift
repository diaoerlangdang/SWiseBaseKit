//
//  UIButton+SWWExtend.swift
//  TestSWiseBaseKit
//
//  Created by wuruizhi on 2017/10/31.
//  Copyright © 2017年 wuruizhi. All rights reserved.
//

import UIKit

extension UIView {
    
    public var x:CGFloat {
        get {
            return self.frame.minX
        }
        set(value) {
            var tmpFrame:CGRect = self.frame
            tmpFrame.origin.x = value
            self.frame = tmpFrame
        }
    }
    
    public var y:CGFloat {
        get {
            return self.frame.minY
        }
        set(value) {
            var tmpFrame:CGRect = self.frame
            tmpFrame.origin.y = value
            self.frame = tmpFrame
        }
    }
    
    public var width:CGFloat {
        get {
            return self.frame.width
        }
        set(value) {
            var tmpFrame:CGRect = self.frame
            tmpFrame.size.width = value
            self.frame = tmpFrame
        }
    }
    
    public var height:CGFloat {
        get {
            return self.frame.height
        }
        set(value) {
            var tmpFrame:CGRect = self.frame
            tmpFrame.size.height = value
            self.frame = tmpFrame
        }
    }
    
    public var size:CGSize {
        get {
            return self.frame.size
        }
        set(value) {
            var tmpFrame:CGRect = self.frame
            tmpFrame.size = value
            self.frame = tmpFrame
        }
    }
    
    public var origin:CGPoint {
        get {
            return self.frame.origin
        }
        set(value) {
            var tmpFrame:CGRect = self.frame
            tmpFrame.origin = value
            self.frame = tmpFrame
        }
    }
    
    public var centerX:CGFloat {
        get {
            return self.center.x
        }
        set(value) {
            var tmpCenter:CGPoint = self.center
            tmpCenter.x = value
            self.center = tmpCenter
        }
    }
    
    public var centerY:CGFloat {
        get {
            return self.center.y
        }
        set(value) {
            var tmpCenter:CGPoint = self.center
            tmpCenter.y = value
            self.center = tmpCenter
        }
    }
    
    public var left:CGFloat {
        get {
            return self.frame.minX
        }
    }
    
    public var top:CGFloat {
        get {
            return self.frame.minY
        }
    }
    
    public var right:CGFloat {
        get {
            return self.frame.maxX
        }
    }
    
    public var bottom:CGFloat {
        get {
            return self.frame.maxY
        }
    }
    
    public var viewController:UIViewController? {
        get {
            var current = self;
            while let next = current.superview {
                let nextResponder:UIResponder = next.next!
                if nextResponder.isKind(of: UIViewController.self) {
                    return nextResponder as? UIViewController
                }
                current = next
            }
            return nil
        }
    }
    
    /**
     *  添加单击事件
     *
     *  - param target      target
     *  - param selector    执行函数
     */
    public func addTapAction(target:Any?, action:Selector?) {
        
        let tapGestureRecognizer:UITapGestureRecognizer = UITapGestureRecognizer(target: target, action: action)
        tapGestureRecognizer.numberOfTapsRequired = 1;
        
        self.isUserInteractionEnabled = true;
        self.addGestureRecognizer(tapGestureRecognizer)
    }
    
    /**
     *  添加长按事件
     *
     *  - param target      target
     *  - param selector    执行函数
     */
    public func addLongPressAction(target:Any?, action:Selector?) {
        
        let recognizer:UILongPressGestureRecognizer = UILongPressGestureRecognizer(target: target, action: action)
        self.isUserInteractionEnabled = true;
        self.addGestureRecognizer(recognizer)
    }
    
    /**
     *  设置圆角
     *
     *  - param cornerRadius 圆角
     */
    public func setCornerRadius(cornerRadius:CGFloat) {
        
        self.layer.cornerRadius = cornerRadius;
        self.layer.masksToBounds = true;
    }
    
    /**
     *  截图
     *
     *  - return 基于位图返回UIImage
     */
    public func screenShotImage() -> UIImage? {
        let resultImageSize = CGSize(width: width, height: height)
        UIGraphicsBeginImageContextWithOptions(resultImageSize, true, 0)
        self.layer.render(in: UIGraphicsGetCurrentContext()!)
        let resultImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return resultImage
    }
}
