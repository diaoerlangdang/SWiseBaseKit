//
//  TableViewController.swift
//  TestSWiseBaseKit
//
//  Created by wuruizhi on 2017/11/7.
//  Copyright © 2017年 wuruizhi. All rights reserved.
//

import UIKit

class TableViewController: SWWBaseTableViewController {
    
    //数据
    var dataArray:[String] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "TabViewController"
        
        dataArray.append("单行数据")
        dataArray.append("多行数据多行数据多行数据多行数据多行数据多行数据多行数据多行数据多行数据多行数据多行数据多行数据多行数据多行数据多行数据多行数据多行数据多行数据多行数据多行数据多行数据多行数据多行数据多行数据多行数据多行数据多行数据多行数据多行数据多行数据多行数据多行数据多行数据多行数据多行数据多行数据多行数据多行数据多行数据多行数据多行数据多行数据多行数据多行数据多行数据多行数据多行数据多行数据多行数据多行数据多行数据多行数据多行数据多行数据多行数据多行数据多行数据多行数据多行数据多行数据多行数据多行数据多行数据多行数据多行数据多行数据多行数据多行数据多行数据")
        
        self.isShowRefreshFooter = true
        self.isShowRefreshHeader = true
    }
    
    override func refreshingHeader() {
        self.stopRefreshHeader()
    }
    
    override func refreshingFooter() {
        self.stopRefreshFooter()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let CellIdentifier = "Cell"
        var cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier)
        if cell == nil {
            cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: CellIdentifier)
            cell?.textLabel?.numberOfLines = 0
            cell?.selectionStyle = .none
        }
        
        cell?.textLabel?.text = dataArray[indexPath.row]
        
        return cell!
    }


}
