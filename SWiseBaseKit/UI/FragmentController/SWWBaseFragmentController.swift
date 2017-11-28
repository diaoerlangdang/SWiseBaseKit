//
//  SWWBaseFragmentController.swift
//  TestSWiseBaseKit
//
//  Created by wuruizhi on 2017/11/1.
//  Copyright © 2017年 wuruizhi. All rights reserved.
//

import UIKit
import SnapKit

class SWWBaseFragmentController: SWWBaseViewController, UIScrollViewDelegate {
    
    /**
     *  scrollview
     */
    public let scrollView:UIScrollView = UIScrollView()
    
    /**
     *  fragment数组
     */
    public var fragmentArray:[UIViewController] = []
    
    /**
     *  是否支持水平滑动，默认支持
     */
    public var isHorizontalEnable:Bool = true {
        didSet {
            scrollView.isScrollEnabled = isHorizontalEnable
        }
    }
    
    /**
     *  当前选中的页
     */
    public private(set) var currentIndex:Int = -1
    
    //MARK: 私有
    
    //是否可滑动
    private var scrollEnable = true
    
    private let contentView:UIView = UIView()
    

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.addSubview(scrollView)
        scrollView.delegate = self
        scrollView.backgroundColor = UIColor.gray
        //隐藏滚动条
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        //按页滑动
        scrollView.isPagingEnabled = true
        //禁止回弹
        scrollView.bounces = false
        
        scrollView.addSubview(contentView)
        contentView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalToSuperview()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if currentIndex > 0 && currentIndex < fragmentArray.count {
            fragmentArray[currentIndex].willShowCurrentFragment()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if currentIndex > 0 && currentIndex < fragmentArray.count {
            fragmentArray[currentIndex].willHideCurrentFragment()
        }
    }
    
    /**
     *  设置fragment的frame 绝对布局
     *
     *  @param frame    fragment的frame
     */
    public func setFragment(frame:CGRect) {
        scrollView.frame = frame
    }
    
    /**
     *  设置fragment的frame 相对布局
     *
     *  @param block    Masonry自动布局
     */
    public func setFragment(constraints: (_ make: ConstraintMaker) -> Void) {
        scrollView.snp.makeConstraints(constraints)
    }
    
    /**
     *  添加fragment,对应的index为fragmentArray的角标
     *
     *  @param fragment  添加的fragment
     */
    public func addFragment(fragment:UIViewController) {
        var lastView:UIView?
        
        //初始显示第一个fragment
        if fragmentArray.count == 0 {
            currentIndex = 0
        }
        else {
            lastView = fragmentArray[fragmentArray.count-1].view
        }
        
        self.addChildViewController(fragment)
        contentView.addSubview(fragment.view)
        fragment.didMove(toParentViewController: self)
        fragment.view.snp.makeConstraints { (make) in
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
        lastView = fragment.view
        
        contentView.snp.remakeConstraints { (make) in
            make.right.equalTo((lastView?.snp.right)!)
            make.edges.equalTo(scrollView)
            make.height.equalTo(scrollView)
        }
        
        fragmentArray.append(fragment)
    }
    
    /**
     *  移除fragment
     *
     *  @param fragment  要移除的fragment
     */
    public func removeFragment(fragment:UIViewController) {
        let index = fragmentArray.index(of: fragment)
        if index != nil {
            removeFragment(fragmentIndex: index!)
        }
        
    }
    
    /**
     *  移除fragment
     *
     *  @param fragmentIndex  要移除的fragment的index
     */
    public func removeFragment(fragmentIndex:Int) {
        
        if fragmentIndex<0 || fragmentIndex>=fragmentArray.count {
            return
        }
        
        var frame = fragmentArray[fragmentIndex].view.frame
        var tempFrame = CGRect.zero
        
        for i in 0..<fragmentArray.count {
            
            //将后面的view 往前移
            if i>fragmentIndex {
                tempFrame = fragmentArray[i].view.frame
                fragmentArray[i].view.frame = frame
                frame = tempFrame
            }
        }
        
        fragmentArray[fragmentIndex].willMove(toParentViewController: nil)
        fragmentArray[fragmentIndex].removeFromParentViewController()
        
        //从页面删除
        fragmentArray[fragmentIndex].view.removeFromSuperview()
        
        fragmentArray.remove(at: fragmentIndex)
        
        if fragmentArray.count > 0 {
            let fragment = fragmentArray[fragmentArray.count - 1]
            scrollView.contentSize = CGSize(width: fragment.view.frame.origin.x+fragment.view.frame.size.width, height: frame.size.height)
        }
        else {
            scrollView.contentSize = scrollView.frame.size
        }
    }
    
    /**
     *  跳转到新的fragment
     *
     *  @param to  要跳转的fragment的index
     */
    public func changeFragment(to:Int) {
        changeFragment(to: to, animated: false, completion: nil)
    }
    
    /**
     *  跳转到新的fragment
     *
     *  @param newFragmentIndex  要跳转的fragment的index
     *  @param animated          是否有动画
     *  @param completion        完成block
     */
    public func changeFragment(to:Int, animated:Bool, completion:(()->Void)?) {
        
        //不执行跳转
        if to<0 || to>=fragmentArray.count || to==currentIndex {
            
            if (to == currentIndex) {
                fragmentArray[to].currentFragmentClicked()
            }
            
            return
        }
        
        //防止执行重复代码，也可区分出是主动跳转还是滑动
        scrollEnable = false
        
        //将要隐藏的fragment
        fragmentArray[currentIndex].willHideCurrentFragment()
        
        //将要显示的fragment
        fragmentArray[to].willShowCurrentFragment()
        
        //执行动画
        if animated {
            
            UIView.animate(withDuration: 0.5, animations: {
                self.scrollView.setContentOffset(CGPoint(x:
                    self.fragmentArray[to].view.frame.origin.x, y:0) , animated: false)
                
            }, completion: { (finished:Bool) in
                
                //改变index
                self.currentIndex = to
                self.scrollEnable = true
                
                if completion != nil {
                    completion!()
                }
            })
        }
        else {
            self.scrollView.setContentOffset(CGPoint(x:
                self.fragmentArray[to].view.frame.origin.x, y:0) , animated: false)
            //改变index
            self.currentIndex = to
            self.scrollEnable = true
            
            if completion != nil {
                completion!()
            }
        }
    }
    
    /**
     *  要滑动到toPage页面
     *
     *  @param toPage    滑动到页面的toPage
     *
     */
    public func dragPage(toPage:Int) {
        
    }
    
    //MARK: UIScrollViewDelegate
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let page = Int(scrollView.contentOffset.x / scrollView.bounds.size.width + 0.5)
        
        if page != currentIndex && scrollEnable {
            
            //将要隐藏的fragment
            fragmentArray[currentIndex].willHideCurrentFragment()
            
            //将要显示的fragment
            fragmentArray[page].willShowCurrentFragment()
            
            //滑动到
            self.dragPage(toPage: page)
            
            //改变index
            currentIndex = page
        }
    }
}
