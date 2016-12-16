//
//  ProfileChannelModel.swift
//  mh824appWithSwift
//
//  Created by wangyuanfei on 16/9/7.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
/**个人中心页面的每一个频道的模型*/

import UIKit

class ProfileChannelModel: BaseModel {

    var channel : String?
    var url : String?
    var key : String?
    override func setValue(_ value: Any?, forKey key: String) {
        if key == "key" {
            if let valueReal  = value {
                if let keyStr  = valueReal as? String {
                   self.actionkey = keyStr
                }
            }
            
        }
        if key == "url" {
            self.keyparamete = value as AnyObject?
        }
        super.setValue(value, forKey: key)
    }
    

}
