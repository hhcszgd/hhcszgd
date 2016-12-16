//
//  ShopModel.swift
//  zjlao
//
//  Created by WY on 16/10/19.
//  Copyright © 2016年 WY. All rights reserved.
//

import UIKit

class ShopModel: BaseModel {
//    var <#name#> = <#value#>
    
    override func setValue(_ value: Any?, forKey key: String) {
        if key == "items" {//子数组 (期望服务器返回地段是items , 不过也可能是 goodses 或者 xxxs)
            if let valueAny  = value {
                if let subArr  = valueAny as? [AnyObject] {//取出子数组
                    self.items = dictArrToModelArr(value: subArr, modelType: "Goods")
                    return
                }
            }
        }
        super.setValue(value, forKey: key)
    }
    
}
