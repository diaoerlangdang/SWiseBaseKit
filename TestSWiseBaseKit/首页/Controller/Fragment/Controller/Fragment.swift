//
//  Fragment.swift
//  TestSWiseBaseKit
//
//  Created by wuruizhi on 2017/11/2.
//  Copyright © 2017年 wuruizhi. All rights reserved.
//

import UIKit

class Fragment: SWWBaseViewController {
    
    //提示语
    public var tips:String = ""
    
    let tipsLabel:UILabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()

        tipsLabel.textColor = UIColor.white
        tipsLabel.text = tips
        self.view.addSubview(tipsLabel)
        tipsLabel.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
        }
        
        self.view.backgroundColor = SWW_COLOR_RANDOM()
    }
}
