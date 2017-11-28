//
//  SWWSegmentView.swift
//  TestSWiseBaseKit
//
//  Created by wuruizhi on 2017/10/30.
//  Copyright © 2017年 wuruizhi. All rights reserved.
//

import UIKit

protocol SWWSegmentViewDelegate  {
    
    /**
     *  选择改变
     *
     *  - param segmentView  segmentView
     *  - param oldIndex     之前的index
     *  - param newIndex     要选择的index
     */
    func change(segmentView:SWWSegmentView, oldIndex:Int, newIndex:Int)
}

class SWWSegmentView: UIView, UITableViewDelegate, UITableViewDataSource {

    public enum IconPostion {
        case left, right
    }
    
    //MARK: 公有变量
    
    /** 标题宽 默认为-1 负数表示自适应宽度 */
    public var titleWidth:Float = -1
    
    /** 标题字体 */
    public var titleFont:UIFont = SWW_Font(size: 16)
    
    /** 选中标题字体 */
    public var selectTitleFont:UIFont = SWW_Font(size: 16)
    
    /** 标题颜色 默认0x333333*/
    public var titleColor:UIColor = SWW_COLOR_HexRGB(hexRGB: 0x333333)
    
    /** 选中标题颜色 默认0x77A9FD*/
    public var selectTitleColor:UIColor = SWW_COLOR_HexRGB(hexRGB: 0x77A9FD) {
        didSet {
            bottomLineView.backgroundColor = selectTitleColor
        }
    }
    
    /** 标题图标，默认为nil */
    public var titleIcon:UIImage? = nil
    
    /** 选中标题图标，默认为nil */
    public var selectTitleIcon:UIImage? = nil
    
    /** 标题数组 */
    public var titleArray:[String] = []
    
    /** icon位置 默认SWWSegmentView.IconPostion.Left*/
    public var iconPostion:IconPostion = .left
    
    /** 选中的位置 默认0，不得大于titleArray.cout */
    public var selectIndex:Int = 0 {
        didSet {
            let path = IndexPath(row: selectIndex, section: 0)
            tableView.reloadData()
            tableView.selectRow(at: path, animated: true, scrollPosition: .middle)
        }
    }
    
    /** 是否显示底部线 默认为true 底部线的颜色与selectTitleColor相同 */
    public var showBottomLineView:Bool = true
    
    /** 代理 */
    public var delegate:SWWSegmentViewDelegate? = nil
    
    let CellIdentify:String = "SegmentCell"
    
    //MARK: 私有变量
    
    /** tableview */
    private let tableView:UITableView = UITableView(frame: CGRect.zero, style: .plain)
    
    /** 底部横线 */
    private let bottomLineView:UIView = UIView()
    
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
        
        self.addSubview(tableView)
        tableView.transform = CGAffineTransform(rotationAngle: CGFloat(-Double.pi/2.0))
        tableView.snp.makeConstraints { (make) in
            make.height.equalTo(self.snp.width)
            make.width.equalTo(self.snp.height)
            make.center.equalToSuperview()
        }
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.tableFooterView = UIView(frame: CGRect.zero)
        tableView.separatorStyle = .none
        tableView.showsHorizontalScrollIndicator = false
        tableView.showsVerticalScrollIndicator = false
        
        if #available(iOS 11.0, *) {
            //设置为0，禁止自动计算cell高度
            tableView.estimatedRowHeight = 0
            //设置为0，禁止自动计算footer高度
            tableView.estimatedSectionFooterHeight = 0
            //设置为0，禁止自动计算header高度
            tableView.estimatedSectionHeaderHeight = 0
            //默认footer header都有内边距
            tableView.contentInsetAdjustmentBehavior = .never
        }
        
        tableView.addSubview(bottomLineView)
        bottomLineView.backgroundColor = selectTitleColor
        bottomLineView.snp.makeConstraints { (make) in
            make.width.equalTo(2)
            make.top.equalToSuperview()
            make.left.equalToSuperview()
            make.height.equalTo(0)
        }
    }
    
    //MARK: UITableViewDelegate  UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titleArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCell(withIdentifier: CellIdentify) as? SWWSegmentViewCell
        if cell == nil {
            cell = SWWSegmentViewCell(style: .default, reuseIdentifier: CellIdentify)
            cell?.backgroundColor = UIColor.clear
            cell?.selectionStyle = .none
            // cell顺时针旋转90度
            cell?.contentView.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi/2.0))
        }
        
        //标题
        cell?.iconBtn.setTitle(titleArray[indexPath.row], for: .normal)
        cell?.iconBtn.setTitle(titleArray[indexPath.row], for: .selected)
        
        //标题字体
        cell?.iconBtn.titleLabel?.font = titleFont
        
        //icon
        cell?.iconBtn.setImage(titleIcon, for: .normal)
        cell?.iconBtn.setImage(selectTitleIcon, for: .selected)
        
        //标题颜色
        cell?.iconBtn.setTitleColor(titleColor, for: .normal)
        cell?.iconBtn.setTitleColor(selectTitleColor, for: .selected)
        
        //icon 位置
        switch iconPostion {
        case .right:
            cell?.iconBtn.iconStyle = .right
        default:
            cell?.iconBtn.iconStyle = .left
        }
        
        //选中cell
        if indexPath.row == selectIndex {
            cell?.cellSelected = true
            cell?.iconBtn.titleLabel?.font = selectTitleFont
            
            let rectInTableView:CGRect = tableView.rectForRow(at: indexPath)
            //如果其约束还没有生成的时候需要动画的话，就请先强制刷新后才写动画，否则所有没生成的约束会直接跑动画
            tableView.layoutIfNeeded()
            UIView.animate(withDuration: 0.3, animations: {
                self.bottomLineView.snp.updateConstraints({ (make) in
                    make.top.equalTo(tableView.snp.top).offset(rectInTableView.origin.y)
                    make.height.equalTo(rectInTableView.size.height)
                })
                tableView.layoutIfNeeded()
            })
            
        }
        else {
            cell?.cellSelected = false
        }
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return getCellHeight(index: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if delegate != nil {
            delegate?.change(segmentView: self, oldIndex: selectIndex, newIndex: indexPath.row)
        }
        
        if indexPath.row != selectIndex {
            selectIndex = indexPath.row
            tableView.reloadData()
            tableView.scrollToRow(at: indexPath, at: .middle, animated: true)
        }
    }
    
    
    /**
     *  获取cell高度
     *
     *  - param index index
     *
     *  - return 高度
     */
    func getCellHeight(index:Int) -> CGFloat {
        if titleWidth < 0 {
            let bt = SWWIconButton(frame: CGRect.zero, style: .left)
            bt.titleEdgeOffsets = SWWEdgeOffsets(left: 5, top: 0, width: -10, height: 0)
            bt.setTitle(titleArray[index], for: .normal)
            
            //icon
            if titleIcon != nil {
                bt.setImage(titleIcon, for: .normal)
            }
            if selectTitleIcon != nil {
                bt.setImage(selectTitleIcon, for: .selected)
            }
            bt.sizeToFit()
            return (bt.frame.width) + 30
        }
        else {
            return CGFloat(titleWidth)
        }
    }
}
