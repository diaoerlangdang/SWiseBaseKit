//
//  SWWSegmentViewCell.swift
//  TestSWiseBaseKit
//
//  Created by wuruizhi on 2017/10/30.
//  Copyright © 2017年 wuruizhi. All rights reserved.
//

import UIKit

class SWWSegmentViewCell: UITableViewCell {
    
    //icon button
    public let iconBtn:SWWIconButton = SWWIconButton(frame: CGRect.zero, style: .left)
    
    //cell 是否被选中
    public var cellSelected:Bool = false {
        didSet {
            iconBtn.isSelected = cellSelected
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        initView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /**
     * 初始化界面
     */
    func initView() {
        self.contentView.addSubview(iconBtn)
        iconBtn.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
        }
        iconBtn.titleEdgeOffsets = SWWEdgeOffsets(left: 5, top: 0, width: -10, height: 0)
        iconBtn.isUserInteractionEnabled = false
    }
    
}
