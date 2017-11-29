//
//  SWWBaseCollectionViewController.swift
//  TestSWiseBaseKit
//
//  Created by wuruizhi on 2017/11/2.
//  Copyright © 2017年 wuruizhi. All rights reserved.
//

import UIKit
import MJRefresh

class SWWBaseCollectionViewController: SWWBaseViewController,
                        UICollectionViewDelegateFlowLayout,UICollectionViewDataSource {
    
    /// 默认的collectionview背景颜色
    public static var defaultCollectionViewBgColor:UIColor? = nil

    //collection view 布局
    public var collectionViewFlowLayout:UICollectionViewFlowLayout = UICollectionViewFlowLayout() {
        didSet {
            collectionView .setCollectionViewLayout(collectionViewFlowLayout, animated: false)
        }
    }
    
    /** collectionView */
    public var collectionView:UICollectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    //是否允许下拉刷新，默认为false
    public var isShowRefreshHeader:Bool = false {
        didSet {
            if isShowRefreshHeader {
                collectionView.mj_header = MJRefreshNormalHeader(refreshingBlock: {
                    self.refreshingHeader()
                })
            }
            else {
                collectionView.mj_header = nil
            }
        }
    }
    
    //是否允许上拉加载，默认为false
    public var isShowRefreshFooter:Bool = false {
        didSet {
            if isShowRefreshFooter {
                collectionView.mj_footer = MJRefreshBackNormalFooter(refreshingBlock: {
                    self.refreshingFooter()
                })
            }
            else {
                collectionView.mj_footer = nil
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: collectionViewFlowLayout)

        self.view.addSubview(collectionView)
        collectionView.backgroundColor = UIColor.white
        
        collectionView.delegate = self;
        collectionView.dataSource = self;
        
        collectionView.showsVerticalScrollIndicator = false;
        collectionView.showsHorizontalScrollIndicator = false;
        
        collectionView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "CollectionCell")
        
        if SWWBaseCollectionViewController.defaultCollectionViewBgColor != nil {
            self.collectionView.backgroundColor = SWWBaseCollectionViewController.defaultCollectionViewBgColor
        }
    }
    
    /**
     *  开始下拉刷新
     */
    func startRefreshHeader() {
        collectionView.mj_header.beginRefreshing()
    }
    
    /**
     *  开始上拉刷新
     */
    func startRefreshFooter() {
        collectionView.mj_footer.beginRefreshing()
    }
    
    /**
     *  停止下拉刷新
     */
    func stopRefreshHeader() {
        collectionView.mj_header.endRefreshing()
    }
    
    
    /**
     *  停止上拉刷新
     */
    func stopRefreshFooter() {
        collectionView.mj_footer.endRefreshing()
    }
    
    
    /**
     *  正在下拉刷新，子类可重写实现
     */
    func refreshingHeader() {
        self.stopRefreshHeader()
    }
    
    /**
     *  正在上拉刷新，子类可重写实现
     */
    func refreshingFooter() {
        self.stopRefreshFooter()
    }
    
    
    //MARK: Collection View data source
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionCell", for: indexPath)
        
        return cell
    }

}
