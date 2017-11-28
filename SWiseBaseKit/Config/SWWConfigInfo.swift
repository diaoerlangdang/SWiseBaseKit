//
//  SWWConfigInfo.swift
//  TestSWiseBaseKit
//
//  Created by wuruizhi on 2017/11/2.
//  Copyright © 2017年 wuruizhi. All rights reserved.
//

import UIKit

class SWWConfigInfo {
    
    /** 沙盒中之前版本key */
    private let kWWOldVersion:String = "ww_old_version"

    /** 存储之前的版本 */
    public var oldVersion:String? {
        get {
            return UserDefaults.standard.object(forKey: kWWOldVersion) as? String
        }
        set(value) {
            UserDefaults.standard.set(value, forKey: kWWOldVersion)
            UserDefaults.standard.synchronize()
        }
    }
    
    //版本是否有更新
    public var isUpdateVersion:Bool {
        get {
            let version:String = Bundle.main.infoDictionary!["CFBundleShortVersionString"] as! String
            
            if oldVersion == nil {
                return true
            }
           
            let result = SWWUtils.compareVersion(version1: version, version2: oldVersion!)

            //版本有更新
            if (result > 0) {
                return true;
            }
            return false;
        }
    }
    
    /**
     * 同步当前版本
     */
    func synchronizeCurrentVersion() {
        self.oldVersion = Bundle.main.infoDictionary!["CFBundleShortVersionString"] as? String
    }
    
}
