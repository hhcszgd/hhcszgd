//
//  OriginalNetDataModel.swift
//  mh824appWithSwift
//
//  Created by wangyuanfei on 16/9/1.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//

import UIKit

class OriginalNetDataModel: NSObject {
    var data  : AnyObject? // 返回的数据
    var msg : String?//状态信息
    var status : NSNumber?//状态码
    var additional : AnyObject? // 额外的信息 (备用)
    init(dict : [String : AnyObject]) {
        super.init()
        self.setValuesForKeys(dict)
    }

    override func setValue(_ value: Any?, forKey key: String) {
        if key == "msg" {
            self.msg  = (value as! String).unicodeStr
            mylog((value as! String).unicodeStr)
            return
        }
        super.setValue(value, forKey: key)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
    
//    override var description: String{
//        return String.init("\(status)\(msg)\(data)")
//    
//    }
    
}
