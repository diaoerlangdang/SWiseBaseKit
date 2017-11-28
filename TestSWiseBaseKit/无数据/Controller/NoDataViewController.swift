//
//  NoDataViewController.swift
//  TestSWiseBaseKit
//
//  Created by wuruizhi on 2017/11/7.
//  Copyright © 2017年 wuruizhi. All rights reserved.
//

import UIKit

class NoDataViewController: SWWBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "页面"
        self.returnImageName = nil
        
        self.isHiddenNothing = false
        self.nothingTipLabel.text = "没东西,点击加载"
        self.nothingTipLabel.textColor = UIColor.white
        self.nothingImageName = "no_data"
        
        self.view.backgroundColor = UIColor.orange
    }
    
    override func clickNothingView() {
        let imageView = UIImageView()
        imageView.image = UIImage(named:"1")
        self.view.addSubview(imageView)
        imageView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }

}
