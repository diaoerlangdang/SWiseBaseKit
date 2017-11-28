//
//  SWWBaseGuidViewController.swift
//  TestSWiseBaseKit
//
//  Created by wuruizhi on 2017/11/2.
//  Copyright © 2017年 wuruizhi. All rights reserved.
//

import UIKit

class SWWBaseGuidViewController: SWWBaseViewController {
    
    public var scrollView:UIScrollView = UIScrollView()
    let contentView:UIView = UIView()
    
    var pageViews:[UIView] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(scrollView)
        scrollView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        scrollView.addSubview(contentView)
        
        contentView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalToSuperview()
        }
        
        //不显示垂直滑动线
        scrollView.showsVerticalScrollIndicator = false
        //不显示水平滑动线
        scrollView.showsHorizontalScrollIndicator = false
        //scrollView不会停在页面之间，即只会显示第一页或者第二页，不会各一半显示
        scrollView.isPagingEnabled = true
        //防止回弹
        scrollView.bounces = false
    }
    
    /**
     *  添加一页view，view的大小与scrollView一样，一般为imageview
     *
     *  @param view     要添加的view
     */
    func addPageView(view:UIView) {
        
        var lastView:UIView?
        
        if pageViews.count > 0 {
            lastView = pageViews.last
        }
        
        contentView.addSubview(view)
        
        view.snp.makeConstraints { (make) in
            if lastView == nil {
                make.left.equalTo(0)
            }
            else {
                make.left.equalTo(lastView!.snp.right)
            }
            make.top.equalTo(0)
            make.width.equalTo(scrollView.snp.width)
            make.height.equalTo(scrollView.snp.height)
        }
        
        lastView = view
        
        pageViews.append(view)
        
        contentView.snp.remakeConstraints { (make) in
            make.right.equalTo((lastView?.snp.right)!)
            make.edges.equalTo(scrollView)
            make.height.equalTo(scrollView)
        }
    }
}
