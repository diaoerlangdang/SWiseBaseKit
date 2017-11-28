//
//  SWWWebView.swift
//  TestSWiseBaseKit
//
//  Created by wuruizhi on 2017/10/27.
//  Copyright © 2017年 wuruizhi. All rights reserved.
//

import UIKit
import WebKit
import SnapKit

class SWWWebView: UIView {
    
    /*web view*/
    public let webView:WKWebView = WKWebView()
    
    /*进度条*/
    public let progressBar:UIProgressView = UIProgressView()
    
    //进度条高度
    private let kProgressViewHeight = 2.0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        initView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /**
     * 初始化界面
     */
    func initView() {
        addSubview(webView)
        webView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        webView.addObserver(self, forKeyPath: "estimatedProgress", options: NSKeyValueObservingOptions.new, context: nil)
        
        addSubview(progressBar)
        progressBar.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.top.equalToSuperview()
            make.height.equalTo(kProgressViewHeight)
        }
    }
    
    /**
     * 加载url
     *
     * - param url 请求的url
     */
    func loadRequest(url:String) {
        let urlReuqest:URLRequest = URLRequest(url: URL(string :url)!, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 30)
        webView.load(urlReuqest)
    }

    /**
     *  是否能返回
     *
     *  - return 能true，否则false
     */
    func canGoBack() -> Bool {
        return webView.canGoBack
    }
    
    /**
     *  层数
     *
     *  - return 层数
     */
    func countOfHistory() -> Int {
        return webView.backForwardList.backList.count
    }
    
    /**
     *  返回
     */
    func goBack() {
        webView.goBack()
    }
    
    /** 监听进度条 */
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
        if keyPath == "estimatedProgress" {
            progressBar.isHidden = (webView.estimatedProgress == 1)
            progressBar.setProgress(Float(webView.estimatedProgress), animated: true)
            
            if progressBar.isHidden {
                progressBar.progress = 0;
            }
            
        }
    }
    
    deinit {
        webView .removeObserver(self, forKeyPath: "estimatedProgress")
    }
}
