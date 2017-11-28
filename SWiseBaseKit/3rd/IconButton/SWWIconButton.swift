//
//  SWWIconButton.swift
//  TestSWiseBaseKit
//
//  Created by wuruizhi on 2017/10/31.
//  Copyright © 2017年 wuruizhi. All rights reserved.
//

import UIKit

struct SWWEdgeOffsets {
    var left:CGFloat = 0
    var top:CGFloat = 0
    var width:CGFloat = 0
    var height:CGFloat = 0
    
    static public let zero:SWWEdgeOffsets = SWWEdgeOffsets(left: 0, top: 0, width: 0, height: 0)
    
    init(left:CGFloat, top:CGFloat, width:CGFloat, height:CGFloat) {
        self.left = left
        self.top = top
        self.width = width
        self.height = height
    }
    
}

class SWWIconButton: UIButton {

    enum IconStyle {
        case left, right, center, top, bottom
    }

    //icon 类型
    public var iconStyle:IconStyle = .left
    
    //图片外边距
    public var imageEdgeOffsets:SWWEdgeOffsets = SWWEdgeOffsets.zero
    
    //标题外边距
    public var titleEdgeOffsets:SWWEdgeOffsets = SWWEdgeOffsets.zero
    
    public var fixImageViewSize:CGSize = CGSize.zero
    
    let IBTopBottomMargin = CGFloat(2.0)
    let IBLeftRightMargin = CGFloat(2.0)
    
    var innerImageView:UIImageView?
    var innerLabel:UILabel?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initView()
        
    }
    
    init(frame: CGRect, style:IconStyle) {
        super.init(frame: frame)
        iconStyle = style
        initView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initView() {
        innerImageView = self.imageView;
        innerLabel = self.titleLabel;
        innerLabel?.textAlignment = .center;
        innerLabel?.adjustsFontSizeToFitWidth = true;
        innerImageView?.contentMode = .scaleAspectFit
        self.isExclusiveTouch = true;
    }
    
    override func sizeToFit() {
        self.layoutSubviews()
        
        let szImage:CGSize = (innerImageView?.image!.size)!
        var szFrame:CGSize = CGSize.zero
        let szText:CGSize = (innerLabel?.text?.boundingRect(with: CGSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude), options: .usesLineFragmentOrigin, attributes: [NSAttributedStringKey.font : (innerLabel?.font)!], context: nil).size)!
        
        if iconStyle == .left || iconStyle == .right || iconStyle == .center {
            
            szFrame.width = IBLeftRightMargin + szImage.width + imageEdgeOffsets.left + imageEdgeOffsets.width + szText.width + titleEdgeOffsets.left + titleEdgeOffsets.width
            
            szFrame.height = IBTopBottomMargin + CGFloat.maximum(szImage.height + imageEdgeOffsets.top + imageEdgeOffsets.height, szText.height + titleEdgeOffsets.top + titleEdgeOffsets.height)
        }
        else {
            
            szFrame.width = IBLeftRightMargin + CGFloat.maximum(szImage.width + imageEdgeOffsets.left + imageEdgeOffsets.width, szText.width + titleEdgeOffsets.left + titleEdgeOffsets.width)
            
            szFrame.height = IBTopBottomMargin + szImage.height + imageEdgeOffsets.top + imageEdgeOffsets.height + szText.height + titleEdgeOffsets.top + titleEdgeOffsets.height
        }
        
        self.frame = CGRect(x: self.frame.minX, y: self.frame.minY, width: szFrame.width, height: szFrame.height)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if self.bounds.isEmpty {
            return
        }
        
        var szImage:CGSize = innerImageView!.image!.size;
        if !(fixImageViewSize.equalTo(CGSize.zero)) {
            szImage = fixImageViewSize
        }
        
        let szFrame:CGSize = self.bounds.size
        var rcIconFrame:CGRect
        var rcTextFrame:CGRect
        
        if iconStyle == .left || iconStyle == .right || iconStyle == .center {
            
            let y:CGFloat = (szFrame.height - szImage.height - IBTopBottomMargin) / 2;
            if iconStyle == .left
            {
                rcIconFrame = CGRect(x: IBLeftRightMargin / 2, y: IBTopBottomMargin / 2  + y, width: szImage.width, height: szImage.height)
                
                rcTextFrame = CGRect(x: IBLeftRightMargin + szImage.width, y: IBTopBottomMargin / 2, width: szFrame.width - (IBLeftRightMargin * 1.5 + szImage.width), height: szFrame.height - IBTopBottomMargin)
            }
            else if iconStyle == .right
            {
                rcTextFrame = CGRect(x: IBLeftRightMargin / 2 , y: IBTopBottomMargin / 2, width: szFrame.width - (IBLeftRightMargin * 1.5 + szImage.width), height: szFrame.height - IBTopBottomMargin)
                
                rcIconFrame = CGRect(x: IBLeftRightMargin + rcTextFrame.size.width, y: IBTopBottomMargin / 2 + y, width: szImage.width, height: szImage.height)
            }
            else {
                let szText:CGSize = (innerLabel?.text?.boundingRect(with: CGSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude), options: .usesLineFragmentOrigin, attributes: [NSAttributedStringKey.font : (innerLabel?.font)!], context: nil).size)!
                let x:CGFloat = ((szFrame.width  - szText.width - IBLeftRightMargin) / 2 - szImage.width)*0.75;
                
                rcIconFrame = CGRect(x: IBLeftRightMargin/2+x, y: IBTopBottomMargin / 2  + y, width: szImage.width, height: szImage.height)
            
                rcTextFrame = CGRect(x: IBLeftRightMargin + szImage.width, y: IBTopBottomMargin / 2, width: szFrame.width - (IBLeftRightMargin * 1.5 + szImage.width), height: szFrame.height - IBTopBottomMargin)
            }
            
        }
        else {
            let x:CGFloat = (szFrame.width - szImage.width - IBLeftRightMargin) / 2;
            if iconStyle == .top
            {
                rcIconFrame = CGRect(x: IBLeftRightMargin / 2 + x, y: IBTopBottomMargin / 2, width: szImage.width, height: szImage.height)
                
                rcTextFrame = CGRect(x: IBLeftRightMargin / 2, y: IBTopBottomMargin + szImage.height, width: szFrame.width - IBLeftRightMargin, height: szFrame.height - (IBTopBottomMargin * 1.5 + szImage.height))
            }
            else
            {
                rcTextFrame = CGRect(x: IBLeftRightMargin / 2, y: IBTopBottomMargin / 2, width: szFrame.width - IBLeftRightMargin * 2, height: szFrame.height - (IBTopBottomMargin * 1.5 + szImage.height))
                
                rcIconFrame = CGRect(x: IBLeftRightMargin / 2 + x, y: IBTopBottomMargin + rcTextFrame.size.height, width: szImage.width, height: szImage.height)
            }
        }
        
        rcIconFrame = edgeOffsetsRect(rect: rcIconFrame, offsets: imageEdgeOffsets);
        rcTextFrame = edgeOffsetsRect(rect: rcTextFrame, offsets: titleEdgeOffsets);
        
        if !rcIconFrame.isEmpty {
            innerImageView?.frame = rcIconFrame
        }
        if !rcTextFrame.isEmpty {
            innerLabel?.frame = rcTextFrame
        }
    }
    
    func edgeOffsetsRect(rect:CGRect, offsets:SWWEdgeOffsets) -> CGRect {
        var temp = rect
        temp.origin.x    += offsets.left;
        temp.origin.y    += offsets.top;
        temp.size.width  += offsets.width;
        temp.size.height += offsets.height;
        return temp;
    }
}
