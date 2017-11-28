//
//  WebViewController.swift
//  TestSWiseBaseKit
//
//  Created by wuruizhi on 2017/11/7.
//  Copyright © 2017年 wuruizhi. All rights reserved.
//

import UIKit

class WebViewController: SWWBaseViewController {
    
    //url
    public var url:String?
    
    private let webView:SWWWebView = SWWWebView()
    

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.addSubview(webView)
        webView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        if url != nil {
            webView.loadRequest(url: url!)
        }
    }

}
