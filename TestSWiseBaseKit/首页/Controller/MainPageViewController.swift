//
//  MainPageViewController.swift
//  TestSWiseBaseKit
//
//  Created by wuruizhi on 2017/11/7.
//  Copyright © 2017年 wuruizhi. All rights reserved.
//

import UIKit
import Toast_Swift

class MainPageViewController: SWWBaseTableViewController {
    
    var dataArray:[String] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "首页"
        
        self.returnImageName = nil
        
        dataArray.append("WebViewController")
        dataArray.append("FragmentController-横向")
        dataArray.append("FragmentController-纵向")
        dataArray.append("TableViewController")
        dataArray.append("CollectionViewController")
        
        //自动算行高
        self.tableView.estimatedRowHeight = 100;
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let CellIdentifier = "MainPageCell"
        var cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier)
        if cell == nil {
            cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: CellIdentifier)
            cell?.textLabel?.numberOfLines = 0
            cell?.selectionStyle = .none
        }
        
        cell?.textLabel?.text = dataArray[indexPath.row]
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var vc:SWWBaseViewController?
        
        switch indexPath.row {
        //网页
        case 0:
            vc = WebViewController()
            (vc as! WebViewController).url = "http://www.meijuxianhua.com"
            break;
            
        //FragmentController-横向
        case 1:
            vc = FragmentController()
            break;
            
        //FragmentController-纵向
        case 2:
            self.view.makeToast("敬请期待...");
            break;
            
        //TableViewController
        case 3:
            vc = TableViewController()
            break;
            
        //CollectionViewController
        case 4:
            vc = CollectionViewController()
            break;
            
        default:
            break;
        }
        
        if vc != nil {
            self.navigationController?.pushViewController(vc!, animated: true)
        }
    }

}
