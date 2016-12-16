//
//  ProfileSubModel.swift
//  mh824appWithSwift
//
//  Created by wangyuanfei on 16/9/7.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//

import UIKit

class ProfileSubModel: BaseModel {
    
    var img : String?//头像链接,只有一个模型有
    var name : String?//标题
    var url : String?//点击跳转链接
    var number : NSNumber?//消息数量
    var  level : String?//等级
    var localImgName : String? //当图片是加载本地图片时 , 对应的本地图片的名字
    //    var actionkey : String?//跳转标识 , 继承父类的
    
    override func setValue(_ value: Any?, forKey key: String) {
        if key == "description" {
            if let tempName = value as? String {
                self.name = tempName
                return;
            }
        }
        if key == "url" {
            self.keyparamete = value as AnyObject?
        }
        super.setValue(value, forKey: key)
    }
    
}
