//
//  SWWUtils.swift
//  TestSWiseBaseKit
//
//  Created by wuruizhi on 2017/11/2.
//  Copyright © 2017年 wuruizhi. All rights reserved.
//

import UIKit

class SWWUtils {

    /**
     *  去AppStore评分
     *
     *  @param appid     appid
     */
    class func toAppStoreGrade(appid:String) {
        let str:String = "http://itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?id=\(appid)&pageNumber=0&sortOrdering=2&type=Purple+Software&mt=8"
        
        if #available(iOS 10.0, *) {
            
            UIApplication.shared.open(URL(string: str)! , options: [:], completionHandler: { (finished:Bool) in
                
            })
        }
        else {
            UIApplication.shared.openURL(URL(string: str)!)
        }
    }
    
    /**
     *  去AppStore更新
     *
     *  @param appid     appid
     */
    class func toAppStoreUpdate(appid:String) {
        let str:String = "itms-apps://itunes.apple.com/app/id\(appid)"
        
        if #available(iOS 10.0, *) {
            
            UIApplication.shared.open(URL(string: str)! , options: [:], completionHandler: { (finished:Bool) in
                
            })
        }
        else {
            UIApplication.shared.openURL(URL(string: str)!)
        }
    }
    
    /**
     *  获取本机IP地址
     *
     *  @return IP地址
     */
    class func getIPAddress() -> String? {
        var address: String?
        
        // get list of all interfaces on the local machine
        var ifaddr: UnsafeMutablePointer<ifaddrs>? = nil
        guard getifaddrs(&ifaddr) == 0 else {
            return nil
        }
        guard let firstAddr = ifaddr else {
            return nil
        }
        for ifptr in sequence(first: firstAddr, next: { $0.pointee.ifa_next }) {
            
            let interface = ifptr.pointee
            
            // Check for IPV4 or IPV6 interface
            let addrFamily = interface.ifa_addr.pointee.sa_family
            if addrFamily == UInt8(AF_INET) || addrFamily == UInt8(AF_INET6) {
                // Check interface name
                let name = String(cString: interface.ifa_name)
                if name == "en0" {
                    
                    // Convert interface address to a human readable string
                    var addr = interface.ifa_addr.pointee
                    var hostName = [CChar](repeating: 0, count: Int(NI_MAXHOST))
                    getnameinfo(&addr, socklen_t(interface.ifa_addr.pointee.sa_len), &hostName, socklen_t(hostName.count), nil, socklen_t(0), NI_NUMERICHOST)
                    address = String(cString: hostName)
                }
            }
        }
        
        freeifaddrs(ifaddr)
        return address
    }
    
    /**
     *  比较两个版本号的大小
     *
     *  @param v1 第一个版本号
     *  @param v2 第二个版本号
     *
     *  @return 版本号相等,返回0; v1小于v2,返回-1; 否则返回1.
     */
    class func compareVersion(version1:String, version2:String) -> Int {
        // 获取版本号字段
        let v1Array = version1.components(separatedBy: ".")
        let v2Array = version2.components(separatedBy: ".")
        // 取字段最少的，进行循环比较
        let smallCount:Int = (v1Array.count > v2Array.count) ? v2Array.count : v1Array.count
        
        for i in 0..<smallCount {
            let value1 = Int(v1Array[i])
            let value2 = Int(v2Array[i])
            
            if value1 == nil || value2 == nil {
                return 0
            }
            
            // v1版本字段大于v2版本字段，返回1
            if value1! > value2! {
                return 1
            }
            // v2版本字段大于v1版本字段，返回-1
            else if value1! < value2! {
                return -1
            }
            // 版本相等，继续循环。
        }
        
        // 版本可比较字段相等，则字段多的版本高于字段少的版本。
        if v1Array.count > v2Array.count {
            return 1
        }
        else if v1Array.count < v2Array.count {
            return -1
        }
        else {
            return 0
        }
    }
    
}
