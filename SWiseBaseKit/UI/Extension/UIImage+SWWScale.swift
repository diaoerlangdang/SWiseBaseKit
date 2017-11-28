//
//  UIImage+SWWScale.swift
//  TestSWiseBaseKit
//
//  Created by wuruizhi on 2017/11/1.
//  Copyright © 2017年 wuruizhi. All rights reserved.
//

import UIKit

extension UIImage
{
    /**
     *  获取固定大小的image
     *
     *  @param size      得到图片的尺寸
     *
     *  @return 固定大小的image
     */
    open func change(size:CGSize) -> UIImage? {
        let width = size.width
        let height = size.height
        
        if self.size.height <= self.size.width {
            if self.size.width >= width {
                let scaleImage = self.fixOrientation().scale(size: CGSize(width: width, height: width*self.size.height/self.size.width))
                return scaleImage
            }
            else {
                return self.fixOrientation()
            }
        }
        else {
            if self.size.height >= height {
                let scaleImage = self.fixOrientation().scale(size: CGSize(width: height*self.size.width/self.size.height, height: height))
                return scaleImage
            }
            else {
                return self.fixOrientation()
            }
        }
    }
    
    /**
     *  等比缩放
     *
     *  @param scale     缩放系数
     *
     *  @return 缩放后的的image
     */
    open func change(scale:Float) -> UIImage? {
        
        let width = self.size.width
        let height = self.size.height
        let scaledWidth = width * CGFloat(scale)
        let scaledHeight = height * CGFloat(scale)
        UIGraphicsBeginImageContext(size); // this will crop
        self.draw(in: CGRect(x: 0, y: 0, width: scaledWidth, height: scaledHeight))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage;
    }
    
    //对图片等比例缩放
    func scale(size:CGSize) -> UIImage? {
        
        if self.cgImage == nil {
            return nil
        }
        
        var width = CGFloat(self.cgImage!.width)
        var height = CGFloat(self.cgImage!.height)
        
        let verticalRadio = size.height / height
        let horizontalRadio = size.width / width
        var radio:CGFloat = 1
        
        if verticalRadio>1 && horizontalRadio>1 {
            radio = verticalRadio > horizontalRadio ? horizontalRadio : verticalRadio
        }
        else {
            radio = verticalRadio < horizontalRadio ? verticalRadio : horizontalRadio
        }
        
        width = width*radio;
        height = height*radio;
        
        let xPos = (size.width - width)/2;
        let yPos = (size.height-height)/2;
        
        // 创建一个bitmap的context
        // 并把它设置成为当前正在使用的context
        UIGraphicsBeginImageContext(size);
        
        // 绘制改变大小的图片
        self.draw(in: CGRect(x: xPos, y: yPos, width: width, height: height))
        
        // 从当前context中创建一个改变大小后的图片
        let scaledImage = UIGraphicsGetImageFromCurrentImageContext();
        
        // 使当前的context出堆栈
        UIGraphicsEndImageContext();
        
        // 返回新的改变大小后的图片
        return scaledImage;
    }
    
    /**
     *  调整图像方向 避免图像有旋转
     *
     *  @return 正的imge
     */
    func fixOrientation() -> UIImage {
        // No-op if the orientation is already correct
        if self.imageOrientation == UIImageOrientation.up {
            return self
        }
        
        var transform = CGAffineTransform.identity
        
        switch self.imageOrientation {
        case .down, .downMirrored:
            transform = transform.translatedBy(x: self.size.width, y: self.size.height)
            transform = transform.rotated(by: CGFloat(Double.pi))
        
        case .left, .leftMirrored:
            transform = transform.translatedBy(x: self.size.width, y:0)
            transform = transform.rotated(by: CGFloat(Double.pi/2))
            
        case .right, .rightMirrored:
            transform = transform.translatedBy(x: 0, y: self.size.height)
            transform = transform.rotated(by: CGFloat(-Double.pi/2))
            
        default: break
        }
        
        //镜像
        switch self.imageOrientation {
        case .upMirrored, .downMirrored:
            transform = transform.translatedBy(x: self.size.width, y:0)
            transform = transform.scaledBy(x: -1, y: 1)
            
        case .leftMirrored, .rightMirrored:
            transform = transform.translatedBy(x: self.size.height, y:0)
            transform = transform.scaledBy(x: -1, y: 1)
            
        default: break
        }
        
        let ctx = CGContext(data: nil, width: Int(self.size.width), height:Int(self.size.height), bitsPerComponent: (self.cgImage?.bitsPerComponent)!, bytesPerRow: 0, space: (self.cgImage?.colorSpace)!, bitmapInfo: (self.cgImage?.bitmapInfo)!.rawValue)
        
        ctx?.concatenate(transform)
        
        switch self.imageOrientation {
        case .left, .leftMirrored, .right, .rightMirrored:
            ctx?.draw(self.cgImage!, in: CGRect(origin: CGPoint.zero, size: CGSize(width: self.size.height, height: self.size.width)))
        default:
            ctx?.draw(self.cgImage!, in: CGRect(origin: CGPoint.zero, size: CGSize(width: self.size.width, height: self.size.height)))
        }
        
        let cgImg = ctx?.makeImage()
        return UIImage(cgImage: cgImg!)
    }
    
}
