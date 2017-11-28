//
//  CollectionViewController.swift
//  TestSWiseBaseKit
//
//  Created by wuruizhi on 2017/11/24.
//  Copyright © 2017年 wuruizhi. All rights reserved.
//

import UIKit

class CollectionViewController: SWWBaseCollectionViewController {
    
    var dataArray:[String] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "CollecionViewController";
        
        for i in 0..<20 {
            dataArray.append("数据\(i+1)")
        }
        dataArray.append("长数据数据数据22")
        
        //显示上拉加载
        self.isShowRefreshFooter = true;
        //显示下拉刷新
        self.isShowRefreshHeader = true;
        
        self.collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: "CollectionViewCell")
        
        self.collectionViewFlowLayout = UICollectionViewLeftAlignedLayout()
    }
    
    // MARK: Collection View data source
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let collectionVideoIdentify:String = "CollectionViewCell"
        let cell:CollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: collectionVideoIdentify, for: indexPath) as! CollectionViewCell
        
        cell.title = dataArray[indexPath.row];
        
        return cell;
    }
    
    //定义每个UICollectionViewCell 的大小
    
    func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
        let cell:CollectionViewCell = collectionView .cellForItem(at: indexPath) as! CollectionViewCell
        
        cell.highLight = true
    }
    
    func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
        let cell:CollectionViewCell = collectionView .cellForItem(at: indexPath) as! CollectionViewCell
        
        cell.highLight = false
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let kindInfo = dataArray[indexPath.row];
        
        SWWLog("点击\(kindInfo)")
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CollectionViewCell.getCellSize(data: dataArray[indexPath.row])
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section:Int) -> UIEdgeInsets {
        
        return UIEdgeInsets(top: 10, left: 33, bottom: 0, right: 33)
    }
    
    /**
     *  正在下拉刷新，子类可重写实现
     */
    override func refreshingHeader() {
        self.stopRefreshHeader()
    }
    
    /**
     *  正在上拉刷新，子类可重写实现
     */
    override func refreshingFooter() {
        self.stopRefreshFooter()
    }

}
