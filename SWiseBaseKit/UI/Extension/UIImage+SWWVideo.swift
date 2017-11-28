//
//  UIImage+SWWVideo.swift
//  TestSWiseBaseKit
//
//  Created by wuruizhi on 2017/11/1.
//  Copyright © 2017年 wuruizhi. All rights reserved.
//

import UIKit
import AVFoundation

extension UIImage {
    
    /**
     *  获取视频的第一帧
     *
     *  - param videoUrl     视频位置
     *  - param size         图片大小
     *
     *  - return 视频第一帧图片image
     */
    convenience init?(videoUrl:URL, size:CGSize) {
        // 获取视频第一帧
        let opts = [AVURLAssetPreferPreciseDurationAndTimingKey:false]
        let urlAsset = AVURLAsset(url: videoUrl, options: opts)
        let generator = AVAssetImageGenerator(asset: urlAsset)
        generator.appliesPreferredTrackTransform = true
        generator.maximumSize = size
        
        var img:CGImage? = nil
        
        do {
            try img = generator.copyCGImage(at: CMTimeMake(0, 10), actualTime: nil)
        }
        catch {
            return nil
        }
        
        if img == nil {
            return nil
        }
        else {
            self.init(cgImage: img!)
        }
    
        
    }
}
