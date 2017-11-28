//
//  SWWBaseViewController.swift
//  TestSWiseBaseKit
//
//  Created by wuruizhi on 2017/10/31.
//  Copyright © 2017年 wuruizhi. All rights reserved.
//

import UIKit

protocol SWWViewControllerDelegate {
    /**
     *  界面返回代理 模态弹出时使用；方便操作父controller的数据
     *
     *  - param controller          返回的视图
     *  - param success             是否成功
     */
    func back(controller:UIViewController, success:Bool)
}

class SWWBaseViewController: UIViewController, SWWViewControllerDelegate {
    
    /**
     * 当没有数据时显示提示图，默认隐藏
     */
    public let nothingImageView:UIImageView = UIImageView()
    
    /**
     * 当没有数据时显示的友好提示语，默认隐藏
     */
    public let nothingTipLabel:UILabel = UILabel()
    
    /** 什么都没有显示的图片 */
    public var nothingImageName:String? = nil {
        didSet {
            if nothingImageName != nil {
                nothingImageView.image = UIImage(named:nothingImageName!)
            }
        }
    }
    
    /** 什么都没有提示的文字*/
    public var nothingTip:String? = nil {
        didSet {
            if nothingTip != nil {
                nothingTipLabel.text = nothingTip!
            }
        }
    }
    
    /** 是否显示什么都没有时的图片和文字 默认不显示 为true */
    public var isHiddenNothing = true {
        didSet {
            nothingTipLabel.isHidden = isHiddenNothing
            nothingImageView.isHidden = isHiddenNothing
        }
    }
    
    /**  返回图片名称 */
    public var returnImageName:String? {
        didSet {
            if returnImageName == nil {
                self.navigationItem.leftBarButtonItem = nil
            }
            else {
                self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named:returnImageName!), style: .plain, target: self, action: #selector(leftButtonMethod))
            }
        }
    }
    
    public var vcDelegate:SWWViewControllerDelegate?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationController?.navigationBar.isTranslucent = false
        self.tabBarController?.tabBar.isTranslucent = false
        self.view.addSubview(nothingImageView)
        nothingImageView.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
        }
        nothingImageView.addTapAction(target: self, action: #selector(clickNothingView))
        if nothingImageName != nil {
            nothingImageView.image = UIImage(named: nothingImageName!)
        }
        nothingImageView.isHidden = isHiddenNothing
        
        self.view.addSubview(nothingTipLabel)
        nothingTipLabel.textColor = UIColor.lightGray
        nothingTipLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(nothingImageView.snp.centerX)
            make.top.equalTo(nothingImageView.snp.bottom).offset(10)
        }
        nothingTipLabel.addTapAction(target: self, action: #selector(clickNothingView))
        
        if nothingTip != nil {
            nothingTipLabel.text = nothingTip!
        }
        nothingTipLabel.isHidden = isHiddenNothing
        
        if self.navigationController != nil && self.navigationController!.viewControllers.count > 1 {
            var backImageName = "SWiseKitResource.bundle/wise_base_kit_return"
            if SWWBaseKitConfig.viewControllerBackItemImageName != nil {
                backImageName = SWWBaseKitConfig.viewControllerBackItemImageName!
            }
            
            self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named:backImageName), style: .plain, target: self, action: #selector(leftButtonMethod))
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }

    /**
     * 导航栏左按钮
     */
    @objc func leftButtonMethod() {
        
        //预防快速连击
        self.navigationItem.leftBarButtonItem?.isEnabled = false
        self.perform(#selector(recoverButton), with: nil, afterDelay: 1.0)
        self.navigationController?.popViewController(animated: true)
    }
    
    /**
     * 恢复按钮可点
     */
    @objc func recoverButton() {
        self.navigationItem.leftBarButtonItem?.isEnabled = true
    }
    
    /**
     * 点击没数据的提示图
     */
    @objc func clickNothingView() {
        
    }
    
    
    //界面返回代理
    func back(controller: UIViewController, success: Bool) {
        controller.dismiss(animated: true, completion: nil)
    }
}
