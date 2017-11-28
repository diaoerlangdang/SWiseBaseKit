//
//  SWWNavigationController.swift
//  TestSWiseBaseKit
//
//  Created by wuruizhi on 2017/10/31.
//  Copyright © 2017年 wuruizhi. All rights reserved.
//

import UIKit

class SWWNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        
        if self.viewControllers.count > 0 {
            viewController.hidesBottomBarWhenPushed = true
        }
        super.pushViewController(viewController, animated: animated)
    }

}
