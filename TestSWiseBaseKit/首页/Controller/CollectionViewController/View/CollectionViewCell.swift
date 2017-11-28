//
//  CollectionViewCell.swift
//  TestSWiseBaseKit
//
//  Created by wuruizhi on 2017/11/24.
//  Copyright © 2017年 wuruizhi. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    public var title:String = "" {
        didSet {
            titleLabel.text = title
        }
    }
    
    //高亮 默认fasle
    public var highLight:Bool = false {
        didSet {
            if highLight {
                self.backgroundColor = SWW_COLOR_HexRGB(hexRGB: 0x0573b7)
                titleLabel.textColor = UIColor.white
            }
            else {
                self.backgroundColor = SWW_COLOR_HexRGB(hexRGB: 0xf0f0f0)
                titleLabel.textColor = SWW_COLOR_HexRGB(hexRGB: 0x333333)
            }
        }
    }
    
    private let titleLabel:UILabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = SWW_COLOR_HexRGB(hexRGB: 0xf0f0f0)
        titleLabel.font = SWW_Font(size: 15)
        titleLabel.textColor = SWW_COLOR_HexRGB(hexRGB: 0x333333)
        titleLabel.textAlignment = .center
        self.contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /**
     *  获取cell尺寸
     *
     *  @param data 数据
     *
     *  @return 尺寸
     */
    class func getCellSize(data:String) -> CGSize {
        let label:UILabel = UILabel()
        label.font = SWW_Font(size: 15)
        label.text = data
        label.sizeToFit()
        
        return CGSize(width: label.width+20, height: label.height+10)
    }
}
