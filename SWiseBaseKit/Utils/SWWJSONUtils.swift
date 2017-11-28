//
//  SWWJSONUtils.swift
//  TestSWiseBaseKit
//
//  Created by wuruizhi on 2017/11/6.
//  Copyright © 2017年 wuruizhi. All rights reserved.
//

import UIKit

class SWWJSONUtils {
    
    /**
     *  将字典转化为字符串
     *
     *  @param dict     字典
     *
     *  @return 字符串
     */
    class func toJSONString(dict:Dictionary<String, Any>) -> String {
        
        if !JSONSerialization.isValidJSONObject(dict) {
            return ""
        }
        
        do {
            let data = try JSONSerialization.data(withJSONObject: dict, options: JSONSerialization.WritingOptions.prettyPrinted)
            
            let jsonStr = String(data: data, encoding: .utf8)
            if jsonStr != nil {
                return jsonStr!
            }
            else {
                return ""
            }
        }
        catch {
            return ""
        }
    }
    
    /**
     *  将JSON串转化为字典
     *
     *  @param jsonData     json数据
     *
     *  @return 数组或字典
     */
    func toDictionary(jsonData:Data) -> Dictionary<String, Any> {
        
        do {
            let data = try JSONSerialization.jsonObject(with: jsonData, options: .mutableContainers)
            
            return data as! Dictionary
        }
        catch {
            return Dictionary()
        }
    }
    
    
    
    

}
