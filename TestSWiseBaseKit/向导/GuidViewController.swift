//
//  GuidViewController.swift
//  TestSWiseBaseKit
//
//  Created by wuruizhi on 2017/11/7.
//  Copyright © 2017年 wuruizhi. All rights reserved.
//

import UIKit

class GuidViewController: SWWBaseGuidViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        for i in 0..<2 {
            let imageName = "\(i+1)"
            let imageView = UIImageView(image: UIImage(named: imageName))
            let label = UILabel()
            label.text = "第\(i+1)页"
            label.textColor = UIColor.white
            imageView.addSubview(label)
            label.snp.makeConstraints({ (make) in
                make.center.equalToSuperview()
            })
            self.addPageView(view: imageView)
            
            if i==1 {
                imageView.isUserInteractionEnabled = true
                let button = UIButton(type: .custom)
                button.layer.borderWidth = 1
                button.layer.borderColor = UIColor.white.cgColor
                button.layer.cornerRadius = 5
                button.layer.masksToBounds = true
                button.setTitle("立即体验", for: .normal)
                button.setTitleColor(UIColor.white, for: .normal)
                button.addTarget(self, action: #selector(goToMain), for: .touchUpInside)
                imageView.addSubview(button)
                button.snp.makeConstraints({ (make) in
                    make.bottom.equalToSuperview().offset(-20)
                    make.centerX.equalToSuperview()
                    make.width.equalTo(100)
                })
            }
        }
    }

    //跳转到主页
    @objc func goToMain() {
        
        SWWLog("登录状态：\(ConfigInfo.shareInstance.isLogIn)")
        ConfigInfo.shareInstance.synchronizeCurrentVersion()
        
        let nav1:SWWNavigationController = SWWNavigationController(rootViewController: MainPageViewController())
        nav1.title = "首页"
        
        let nav2:SWWNavigationController = SWWNavigationController(rootViewController: NoDataViewController())
        nav2.title = "页面"
        
        let tabC = SWWTabBarController()
        tabC.viewControllers = [nav1, nav2]
        
        self.present(tabC, animated: true, completion: nil)
    }

}
