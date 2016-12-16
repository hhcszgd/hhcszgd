//
//  GDDevice.swift
//  zjlao
//
//  Created by WY on 16/11/18.
//  Copyright © 2016年 com.16lao.zjlao. All rights reserved.
//

import UIKit

class GDDevice: UIDevice {

    
  class  var width  :CGFloat{get{return UIScreen.main.bounds.size.width}}
  class  var height  :CGFloat{get{return UIScreen.main.bounds.size.height}}
    /// 获取当前系统版本
    ///
    /// - returns: Float类型的系统版本
    class func currentSystemVersion() -> Float {
        mylog( UIDevice.current.systemVersion)
        mylog( Float(UIDevice.current.systemVersion))
        
        if let  systemVersion =  Float(UIDevice.current.systemVersion) {
            mylog("当前iOS版本为\(systemVersion)")
            return systemVersion
//            if systemVersion <= 11.0 {
//                mylog("10+")
//            }else if (systemVersion <= 10.0){
//                mylog("9+")
//            }else if (systemVersion <= 9.0){
//                mylog("8+")
//            }else{
//                mylog("8-")
//            }
        }else{
            return 0
        }
    }
    
}
