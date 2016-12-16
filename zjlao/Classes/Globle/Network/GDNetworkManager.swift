//
//  GDNetworkManager.swift
//  zjlao
//
//  Created by WY on 16/12/12.
//  Copyright © 2016年 com.16lao.zjlao. All rights reserved.
//

import UIKit
import AFNetworking
enum RequestType: String {
    case POST = "POST"
    case GET = "GET"
    case PUT = "PUT"
}
private let hostName = "https://api.zjlao.com/"

private let dataErrorDomain = "com.zjlao.b2c"
class GDNetworkManager: AFHTTPSessionManager {
    //MARK:当前网络状态
    var gdNetWorkStatus : AFNetworkReachabilityStatus  {
        return AFNetworkReachabilityManager.shared().networkReachabilityStatus
        
    }
    var alert : GDAlertView = GDAlertView.networkLoading()
    var token : String? {
        get{
            
            
            
            if let result  = GDStorgeManager.standard.value(forKey: "token") {
                if  let token_temp =  result as? String   {
                    if token_temp.characters.count>0  && token_temp != "nil"{
                        return token_temp
                    }
                }
                
            }
            //            if  let token_temp =  UserDefaults.standard.value(forKey: "token") as? String   {
            //                if token_temp.characters.count>0  && token_temp != "nil"{
            //                    return token_temp
            //                }
            //            }
            return "nil"
        }
    }
    
//    override class func initialize(){
//        
//        NotificationCenter.default.addObserver(self, selector: #selector(noticeNetworkChanged(_:)), name: NSNotification.Name.AFNetworkingReachabilityDidChange, object: nil)
//        
//    }
    
    static let shareManager : GDNetworkManager = {
        let url = URL(string: hostName)!
        let mgr = GDNetworkManager(baseURL: url)
//        mgr.session.configuration.timeoutIntervalForRequest = 6 //timeoutIntervalForRequest时间内, 如果没有请求数据发送,则请求超时
        mgr.session.configuration.timeoutIntervalForResource = 6//timeoutIntervalForResource时间内,如果没有返回响应,则响应超时
        //添加支持的反序列化格式
        mgr.responseSerializer.acceptableContentTypes?.insert("text/plain")
        mgr.requestSerializer.setValue("2", forHTTPHeaderField: "APPID")
        mgr.requestSerializer.setValue("1", forHTTPHeaderField: "VERSIONID")
        mgr.requestSerializer.setValue("20160501", forHTTPHeaderField: "VERSIONMINI")
        mgr.requestSerializer.setValue((UIDevice.current.identifierForVendor?.uuidString)!, forHTTPHeaderField: "DID")
        //        mgr.requestSerializer.setValue("383B255B-87F7-466C-914A-0B1A35AA5DC3", forHTTPHeaderField: "DID")//先把UID写死
        
        
        
        return mgr
    }()
    static var isFirst = false//第一次监听不提示
    
    class func noticeNetworkChanged(_ note : Notification) -> () {
        if !isFirst  {
            isFirst = true
            return
        }
        guard let userInfo = (note as NSNotification).userInfo else {return}
        let currentNetworkStatus = userInfo[AFNetworkingReachabilityNotificationStatusItem] as! Int
        /**
         AFNetworkReachabilityStatusUnknown          = -1,
         AFNetworkReachabilityStatusNotReachable     = 0,
         AFNetworkReachabilityStatusReachableViaWWAN = 1,
         AFNetworkReachabilityStatusReachableViaWiFi = 2,*/
        if currentNetworkStatus == -1 {//AFNetworkReachabilityStatus.Unknown
            GDAlertView.alert("网络连接失败\n请检查网络", image: nil, time: 2, complateBlock: nil)
        }else if (currentNetworkStatus == 0){//AFNetworkReachabilityStatus.notReachable
            GDAlertView.alert("网络错误", image: nil, time: 2, complateBlock: nil)
        }else if (currentNetworkStatus == 1){//AFNetworkReachabilityStatus.reachableViaWWAN
            GDAlertView.alert("当前网络环境为移动蜂窝网络", image: nil, time: 2, complateBlock: nil)
        }else if (currentNetworkStatus == 2){//AFNetworkReachabilityStatus.reachableViaWiFi
            GDAlertView.alert("当前网络环境为wifi", image: nil, time: 2, complateBlock: nil)
        }
    }
    func printMessage(_ urlString : String , paramete : AnyObject?) -> () {
        #if DEBUG
            
            
            if let obj :AnyObject = paramete {
                
                print("📩原始数据[\(urlString)] <-->  \n\(obj)")
            }
            
            
            if let error : NSError = paramete as? NSError {
                print("📩原始数据[\(urlString)] <-->  \n\(error)")
                
            }
        #endif
    }
    //次终极自定义请求 // 闭包参数result 保证只要回调 就一定有值
    func requestDataFromNewWork(_ method: RequestType, urlString: String,parameters:[String : AnyObject],success: @escaping (_ result:OriginalNetDataModel) -> () , failure : @escaping (_ error : NSError) ->()) {
        
        if token != nil  && token! != "nil" {
            var para  = parameters
            
            para["token"] = token! as AnyObject?
            mylog(para)
            self.requestJSONDict(method, urlString: urlString, parameters: para, success: { (result) in
                success(result)
            }, failure: { (error) in
                failure(error)
            })
        }else{
            initToken({ (result) in
                mylog(self.token)
                var para  = parameters
                
                if let tempToken = self.token {
                    
                    
                    para["token"] =  tempToken as AnyObject?
                    self.requestJSONDict(method, urlString: urlString, parameters: para, success: { (result) in
                        success(result)
                    }, failure: { (error) in
                        failure(error)
                    })
                    
                }else{
                    GDAlertView.alert("初始化失败 , 请重试", image: nil, time: 2, complateBlock: nil)
                    let gdError = NSError(domain: "wrongDomain.com", code: -10001, userInfo: ["reason" : "netWorkError"])
                    failure(gdError)
                }
                
            }, failure: { (error) in
                //初始化失败,
                let gdError = NSError(domain: "wrongDomain.com", code: -10001, userInfo: ["reason" : "netWorkError"])
                failure(gdError)
            })
            
        }
        
        
    }
    
    //(终极自定义)基于核心网络框架的核心方法 进行封装  以后所有的网络请求 都走这个方法(初始化方法除外)
    private  func requestJSONDict(_ method: RequestType, urlString: String,parameters:[String : AnyObject],success: @escaping (_ result:OriginalNetDataModel) -> () , failure : @escaping (_ error : NSError) ->()) {
        //MARK:在失败回调里 ,如果错误码是-11111  , 代表网络错误  , 测试在自定义控制器里就可以执行showErrorView
        
        if gdNetWorkStatus == AFNetworkReachabilityStatus.notReachable || gdNetWorkStatus == AFNetworkReachabilityStatus.unknown {
            GDAlertView.alert("请求失败 , 请检查网络", image: nil, time: 2, complateBlock: nil)
            let gdError = NSError(domain: "wrongDomain.com", code: -11111, userInfo: ["reason" : "netWorkError"])
            failure(gdError)
            
            return
        }
        if urlString != "LoginOut" { self.alert.gdShow()}//退出是立即生效的, 不转圈
        mylog( UIDevice.current.identifierForVendor?.uuidString)
        mylog("\(urlString)\(parameters)")
        var  para : [String : AnyObject] = [String : AnyObject]()
        for key in parameters.keys {
            //                let keyStr = key as String
            //                para["keyStr"] = parameters[keyStr]
            para[key] = parameters[key]
        }
        mylog("ddddddddasdfasdf\(para)")
        var url   =  "V2/"
        url = url + urlString
        url = url + "/rest"
        
        if method == RequestType.GET {
            //实现GET请求
            get(url, parameters: para, progress: nil , success: { (_, result) in
                //                mylog(result)
                self.alert.gdHide()///////////////////////////
                self.printMessage(urlString, paramete: result as AnyObject?)
                if let dict = result as? [String : AnyObject] {
                    //执行成功回调
                    let model = OriginalNetDataModel.init(dict: dict)
                    success(model)
                    return
                }
                //如果程序走到这里  成功回调的结果 无法转换为字典形式的数据
                let error = NSError(domain: dataErrorDomain, code: -10000, userInfo: [NSLocalizedDescriptionKey : "(手动判断)数据格式错误"])
                self.printMessage(urlString, paramete: error)
                failure(error)
            }, failure: { (_, error) in
                self.alert.gdHide()////////////////////////////////
                //执行失败的回调
                self.printMessage(urlString, paramete: error as AnyObject?)
                failure( error as NSError)
                
            })
            
        } else if method == RequestType.POST{
            //实现POST请求
            mylog("zzzzzzzzz\(para)")
            post(url, parameters: para, progress: nil, success: { (_, result) in
                self.alert.gdHide()///////////////////////////
                self.printMessage(urlString, paramete: result as AnyObject?)
                if let dict = result as? [String : AnyObject] {
                    //执行成功回调
                    let model = OriginalNetDataModel.init(dict: dict)
                    success(model)
                    return
                }
                //如果程序走到这里  成功回调的结果 无法转换为字典形式的数据
                let error = NSError(domain: dataErrorDomain, code: -10000, userInfo: [NSLocalizedDescriptionKey : "(手动判断)数据格式错误"])
                self.printMessage(urlString, paramete: error)
                failure(error)
            }, failure: { (_, error) in
                self.alert.gdHide()///////////////////
                //执行失败的回调
                self.printMessage(urlString, paramete: error as AnyObject?)
                failure( error as NSError)
                
            })
            
        }else if method == RequestType.PUT {
            put(url, parameters: para, success: { (_, result) in
                self.alert.gdHide()//////////////////////
                self.printMessage(urlString, paramete: result as AnyObject?)
                if let dict = result as? [String : AnyObject] {
                    //执行成功回调
                    let model = OriginalNetDataModel.init(dict: dict)
                    success(model)
                    return
                }
                //如果程序走到这里  成功回调的结果 无法转换为字典形式的数据
                let error = NSError(domain: dataErrorDomain, code: -10000, userInfo: [NSLocalizedDescriptionKey : "(手动判断)数据格式错误"])
                self.printMessage(urlString, paramete: error)
                failure(error)
            }, failure: { (_, error) in
                self.alert.gdHide()//////////////////////////////
                //执行失败的回调
                self.printMessage(urlString, paramete: error as AnyObject?)
                failure( error as NSError)
                
            })
        }
    }
    
    
    //MARK: 初始化token
    func initToken(_ success : @escaping (_ result : OriginalNetDataModel) -> () , failure : @escaping (_ error : NSError) -> ()) -> () {
        
        if token != nil && token != "nil" {
            mylog(token)
            success(OriginalNetDataModel.init(dict: ["data": "" as AnyObject , "msg" : "" as AnyObject, "status" : "0" as AnyObject]))
            return;
        }
        let url  = "InitKey"
        let para = [String : AnyObject]()
        self.requestJSONDict(RequestType.GET, urlString: url, parameters: para, success: { (result) in
            var tempToken =  (UIDevice.current.identifierForVendor?.uuidString)! + (result.data as? String ?? "")
            //            tempToken = tempToken?.md5()
            //            var tempToken = "383B255B-87F7-466C-914A-0B1A35AA5DC3" + (result.data as! String)//先把token写死
            tempToken = tempToken.md5()
            
            GDStorgeManager.standard.setValue(tempToken, forKey: "token")
            success(result)
        }) { (error) in
            failure(error)
            GDAlertView.alert("初始化失败 , 请检查网络", image: nil, time: 2, complateBlock: nil)
        }
        
    }
    //MARK: 退出登录
    func loginOut(_ success : @escaping (_ result : OriginalNetDataModel) -> () , failure : @escaping (_ error : NSError) -> ()) -> () {
        let url = "LoginOut"
        let para = [String : AnyObject]()
        Account.shareAccount.deleteAccountFromDisk()//有没有联网都退出
        GDStorgeManager.standard.setValue("nil", forKey: "token")//token 赋值为空//不管有没有联网
        self.requestDataFromNewWork(RequestType.POST, urlString: url, parameters: para, success: { (result) in
            if Int (result.status!) > 0 {
                //                Account.shareAccount.deleteAccountFromDisk()
                //                UserDefaults.standard.setValue("nil", forKey: "token")//token 赋值为空
            }
            success(result)
        }) { (error) in
            failure(error)
        }
    }
    //MARK: 登录
    
    func login(_ name : String , password : String , success : @escaping (_ result : OriginalNetDataModel) -> () , failure : @escaping (_ error : NSError) -> ()) -> () {
        let url = "Login"
        let para = ["username" : name ,  "password" : password ]
        requestDataFromNewWork(RequestType.POST, urlString: url , parameters: para as [String : AnyObject] , success: { (result) in
            if  let status =  result.status as? Int {
                if status > 0 {
                    if let data = result.data {//登录成功 , 先把memberID放到内存中 , 方便其他类取用(此处是用来判断登录状态)
                        if let memberid = data as? String {
                            Account.shareAccount.member_id = memberid
                        }
                    }
                    self.gotPersonalData({ (result) in
                        
                    }, failure: { (error) in
                    })
                }
                
            }
            
            success(result)
        }) { (error) in
            failure(error)
        }
    }
    
    
    //MARK: 获取个人资料
    
    func gotPersonalData(_ success : @escaping (_ result : OriginalNetDataModel) -> () , failure : @escaping (_ error : NSError) -> ())  -> () {
        let url = "UserInfo"
        let para = [String : AnyObject]()
        requestDataFromNewWork(RequestType.GET, urlString: url, parameters: para, success: { (result) in
            
            if result.status == 30 {
                if let strMessage = result.data as? String{
                    mylog(strMessage)
                }
                if let dictMessage = result.data as? [String : AnyObject]{
                    mylog(dictMessage)
                    Account.init(dict: dictMessage).saveAccount()
                }
                if let arrMessage = result.data as? [AnyObject]{
                    mylog(arrMessage)
                    let arr = arrMessage.first
                    if let subDictMessage = arr as? [String : AnyObject]{
                        mylog(subDictMessage)
                        Account.init(dict: subDictMessage).saveAccount()
                    }
                    if let subArrMessage = arr as? [AnyObject]{
                        mylog(subArrMessage)
                    }
                    if let subStrMessage = arr as? String{
                        mylog(subStrMessage)
                    }
                }
                
            }
            
            success(result)
            
        }) { (error) in
            failure(error)
        }
        
    }
    
    //MARK: 获取个人中心页面数据
    
    func gotProfilePageData(_ success : @escaping (_ result : OriginalNetDataModel) -> () , failure : @escaping (_ error : NSError) -> ()) -> () {
        let url = "MyPage"
        let para = [String : AnyObject]()
        requestDataFromNewWork(RequestType.GET, urlString: url, parameters: para, success: { (result) in
            success(result)
        }) { (error) in
            failure(error)
        }
    }
    
    
    //MARK: 获取购物车
    func gotShopCarData(_ success : @escaping (_ result : OriginalNetDataModel) -> () , failure : @escaping (_ error : NSError) -> ()) -> () {
        /**GET: http://api.zjlao.com/V2/ShopCart/rest*/
        let url = "ShopCart"
        //        let para = ["username" : name ,  "password" : password ]
        let para = [String : AnyObject]()
        requestDataFromNewWork(RequestType.GET, urlString: url, parameters: para, success: { (result) in
            success(result)
        }) { (error) in
            failure(error)
        }
    }
    
    //MARK: 商品规格
    func gotGoodsSpecification(goodsID : String , _ success : @escaping (_ result : OriginalNetDataModel) -> () , failure : @escaping (_ error : NSError) -> ())  {
        /**GET: http://api.zjlao.com/V2/SelectSpec/rest*/
        
        let url = "SelectSpec"
        //        let para = ["username" : name ,  "password" : password ]
        let para = ["goods_id":goodsID]
        requestDataFromNewWork(RequestType.GET, urlString: url, parameters: para as [String : AnyObject], success: { (result) in
            success(result)
        }) { (error) in
            failure(error)
        }
        
    }
    
    
    //MARK: 保存deviceToken和registerID
    func saveDeviceTokenAndRegisterID(deviceToken : String? , registerID : String? ,  _ success : @escaping (_ result : OriginalNetDataModel) -> () , failure : @escaping (_ error : NSError) -> ()) -> () {
        
        if deviceToken == nil && registerID == nil  {
            failure(NSError.init())
            return
        }
        /**POST: http://api.zjlao.com/V2/Push/rest*/
        let url = "Push"
        //        let para = ["username" : name ,  "password" : password ]
        var para = [String : AnyObject]()
        if let deviceTokenStr = deviceToken  {
            para["devicetoken"] = deviceTokenStr as AnyObject
        }
        if let registerIDStr  = registerID {
            para["registrationID"] = registerIDStr as AnyObject
        }
        requestDataFromNewWork(RequestType.POST, urlString: url, parameters: para, success: { (result) in
            success(result)
        }) { (error) in
            failure(error)
        }
    }
    
    //MARK:
    //MARK:
    //MARK:
    //MARK:
    //MARK:
    //MARK:
    //MARK:
    //MARK:
    //MARK:
    //MARK:
    //MARK:
    //MARK:
    //MARK:
    //MARK:
    //MARK:
    //MARK:
    //MARK:
    //MARK:
    //MARK:
    //MARK:
    //MARK:
    //MARK:
    //MARK:
    //MARK:
    //MARK:
    //MARK:
    //MARK:
    //MARK:
    //MARK:
    //MARK:
    //MARK:
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    

}
