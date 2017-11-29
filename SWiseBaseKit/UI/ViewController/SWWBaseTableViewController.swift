//
//  SWWBaseTableViewController.swift
//  TestSWiseBaseKit
//
//  Created by wuruizhi on 2017/11/2.
//  Copyright © 2017年 wuruizhi. All rights reserved.
//

import UIKit
import MJRefresh

class SWWBaseTableViewController: SWWBaseViewController, UITableViewDelegate, UITableViewDataSource {
    
    /// 默认的tableview背景颜色
    public static var defaultTableViewBgColor:UIColor? = nil
    
    /** tableView */
    public var tableView:UITableView = UITableView()
    
    //是否允许下拉刷新，默认为false
    public var isShowRefreshHeader:Bool = false {
        didSet {
            if isShowRefreshHeader {
                tableView.mj_header = MJRefreshNormalHeader(refreshingBlock: {
                    self.refreshingHeader()
                })
            }
            else {
                tableView.mj_header = nil
            }
        }
    }
    
    //是否允许上拉加载，默认为false
    public var isShowRefreshFooter:Bool = false {
        didSet {
            if isShowRefreshFooter {
                tableView.mj_footer = MJRefreshBackNormalFooter(refreshingBlock: {
                    self.refreshingFooter()
                })
            }
            else {
                tableView.mj_footer = nil
            }
        }
    }
    
    //table view style
    var tableViewStyle:UITableViewStyle = UITableViewStyle.plain
    
    /**
     *  初始化controller
     *
     *  @param style    tableView类型
     *
     *  @return controller对象
     */
    convenience init(style:UITableViewStyle) {
        self.init(nibName: nil, bundle: nil)
        self.tableViewStyle = style
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView = UITableView(frame: CGRect.zero, style: tableViewStyle)
        tableView.tableFooterView = UIView(frame: CGRect.zero)
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        tableView.delegate = self
        tableView.dataSource = self
        self.view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        //设置为0，禁止自动计算cell高度，默认自动计算高度
        tableView.estimatedRowHeight = 100
        //设置为0，禁止自动计算footer高度
        tableView.estimatedSectionFooterHeight = 0
        //设置为0，禁止自动计算header高度
        tableView.estimatedSectionHeaderHeight = 0
        
        if #available(iOS 11.0, *) {
            
            //默认footer header都有内边距
            tableView.contentInsetAdjustmentBehavior = .never
        }
        
        if SWWBaseTableViewController.defaultTableViewBgColor != nil {
            self.tableView.backgroundColor = SWWBaseTableViewController.defaultTableViewBgColor
        }
    }
    
    /**
     *  开始下拉刷新
     */
    func startRefreshHeader() {
        tableView.mj_header.beginRefreshing()
    }
   
    /**
     *  开始上拉刷新
     */
    func startRefreshFooter() {
        tableView.mj_footer.beginRefreshing()
    }
    
    /**
     *  停止下拉刷新
     */
    func stopRefreshHeader() {
        tableView.mj_header.endRefreshing()
    }
    
    
    /**
     *  停止上拉刷新
     */
    func stopRefreshFooter() {
        tableView.mj_footer.endRefreshing()
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
    
    
    //MARK: Table view data source
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let CellIdentifier:String = "UITableViewCell"
        var cell:UITableViewCell? = tableView.dequeueReusableCell(withIdentifier: CellIdentifier)
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: CellIdentifier)
        }
        
        return cell!
    }
}

