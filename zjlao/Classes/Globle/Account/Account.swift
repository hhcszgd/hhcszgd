//
//  Account.swift
//  mh824appWithSwift
//
//  Created by wangyuanfei on 16/8/30.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//

import UIKit

class Account: NSObject , NSCoding {
    
    static let shareAccount : Account = {
        let acc = Account.loadAccount()
        if acc == nil {
            return Account.init(dict: [String : AnyObject]())
        }
        return acc!
    }()
    
    class func loadAccount() -> Account? {
        let path = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).last! as NSString).appendingPathComponent("account.plist")
        //解归档
        if let account = NSKeyedUnarchiver.unarchiveObject(withFile: path) as? Account {
            
           return account
        }
        return nil
    }
    //保存自定义对象
    func saveAccount() {
        //保存到沙盒路径   stringbyappendingpathcomment  很遗憾 在Swift中被搞丢了
        //在Xcode 7.0  消失了
        
        let path = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).last! as NSString).appendingPathComponent("account.plist")
        NSKeyedArchiver.archiveRootObject(self, toFile: path)
        
        if let acc = Account.loadAccount() {//归档完毕取一下 , 保证内存的shareAccount的属性是最新的
            Account.shareAccount.name = acc.name
            Account.shareAccount.member_id = acc.member_id
            Account.shareAccount.head_images = acc.head_images
//            Account.shareAccount.token = acc.token
        }else {
            Account.shareAccount.name = nil
            Account.shareAccount.member_id = nil
        }
        
    }
    
    //删除归档信息

    func deleteAccountFromDisk() -> () {
        
        
        let path = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).last! as NSString).appendingPathComponent("account.plist")
        do {
          try  FileManager.default.removeItem(atPath: path)
            mylog("清除磁盘账户信息 成功")
            Account.shareAccount.name = nil
            Account.shareAccount.member_id = nil
            Account.shareAccount.head_images = nil
            self.saveAccount() //先删除内存里shareAccount的属性值, 再进行归档
        }catch  let error as NSError {
            mylog("清除磁盘账户信息 失败")
            mylog(error)
            //cuo
        }
        
        
    }
    
    //实现NSCoding 协议方法
    //解归档 将二进制数据 -> 对象 反序列化相似
    required init?(coder aDecoder: NSCoder) {
//        token = aDecoder.decodeObjectForKey("token") as? String
        name = aDecoder.decodeObject(forKey: "name") as? String
        member_id = aDecoder.decodeObject(forKey: "member_id") as? String
        head_images = aDecoder.decodeObject(forKey: "head_images") as? String
    }
    //归档  将对象 -> 二级制数据 存储砸沙盒路径  存在磁盘上 序列化相似
    func encode(with aCoder: NSCoder) {
//        aCoder.encodeObject(token, forKey: "token")
        aCoder.encode(name, forKey: "name")
        aCoder.encode(member_id, forKey: "member_id")
        aCoder.encode(head_images, forKey: "head_images")
    }

    
    /** token */
//    var token : String?
    var name : String?
    var member_id : String?
    var level : Int  = 1
    /** 性别 1.男,2.女,3.保密(默认)*/
    var sex = 3
    var password : String?
    var head_images : String?
    var mobile : String?
    var telephone : String?
    /** 国家 */
    var country : String?
    /** 省份 */
    var province : String?
    /** 城市 */
    var city : String?

    /** 区/县 */
    var area : String?
    
    /** 具体地址 */
    var address : String?
    
    /** 生日 */
    var  birthday : String?
    /** 余额 */
    var  balance : Int = 0
    /** 余额支付密码 */
    var  balancepwd : String?
    /** 短信验证码 */
    var  mobileCode : String?
    /** newpassword(修改密码时用)*/
    var  newpassword : String?
    /** 用户是否登录 */
    var  isLogin : Bool {
        get{
            guard let token_temp = GDStorgeManager.standard.value(forKey: "token") as! String?   else{
                mylog("取登录状态时 , token为空")
                return false
            }
            
            
            if token_temp.characters.count == 0{
                mylog("取登录状态时,token字符串的长度为零")
                return false
            }
            mylog("取登录状态时,token的值为:\(token_temp)")
            guard let member_id_temp = member_id else {
                mylog("取登录状态时 , memberID的值为空")
                return false
            }
            mylog("取登录状态时 , memberID的值为:\(member_id_temp)")

            return member_id_temp.characters.count > 0 && member_id != "loginout" ? true : false
            
            
        }
    
    }
    
    
    func save() -> () {
        
    }
    func read() -> () {
        
    }
    
     init(dict : [String : AnyObject]) {
        super.init()
        self.setValuesForKeys(dict)
        if let data  = dict["data"] {
            if let memberid = data as? String{
                self.member_id = memberid
            }
        }
    }
    
    /////////////////////////////////////////////////////////////////
    
    
    
    /////////////////////////////////////////////////////////////////
  
    override func setValue(_ value: Any?, forKey key: String) {
        if key == "id" {
            self.member_id = value as? String
            return
        }
        super.setValue(value, forKey: key)
    }
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        //do nothing
    }
}
