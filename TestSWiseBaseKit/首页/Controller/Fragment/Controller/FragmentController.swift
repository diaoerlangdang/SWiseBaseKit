//
//  FragmentController.swift
//  TestSWiseBaseKit
//
//  Created by wuruizhi on 2017/11/2.
//  Copyright © 2017年 wuruizhi. All rights reserved.
//

import UIKit

class FragmentController: SWWBaseFragmentController, SWWSegmentViewDelegate {
    
    let segmentView:SWWSegmentView = SWWSegmentView()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "FragmentController-横向";
        self.view.addSubview(segmentView)
        segmentView.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.top.equalToSuperview()
            make.height.equalTo(45)
        }
        segmentView.selectTitleFont = SWW_Font(size: 20)
        
        var dataArray:[String] = []
        for i in 0..<20 {
            dataArray.append("title\(i+1)")
        }
        dataArray.append("标题标题title21")
        dataArray.append("title22")
        
        segmentView.titleArray = dataArray
        segmentView.selectTitleColor = UIColor.red
        segmentView.iconPostion = .left
        segmentView.delegate = self
        segmentView.titleIcon = UIImage(named: "down")
        
        setFragment { (make) in
            make.top.equalTo(segmentView.snp.bottom)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        for data in dataArray {
            let fragment:Fragment = Fragment()
            fragment.tips = data
            self.addFragment(fragment: fragment)
        }
    }
    
    override func dragPage(toPage: Int) {
        segmentView.selectIndex = toPage
    }

    //MARK: SWWSegmentViewDelegate
    func change(segmentView: SWWSegmentView, oldIndex: Int, newIndex: Int) {
        var tip:String = ""
        if oldIndex == newIndex {
            tip = "选择没变\(newIndex+1)"
            print(tip)
        }
        else {
            tip = "选择\(newIndex+1)"
            print(tip)
        }
        
        self.changeFragment(to: newIndex)
    }
    
    
}
