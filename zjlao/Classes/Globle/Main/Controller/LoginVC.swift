//
//  LoginVC.swift
//  mh824appWithSwift
//
//  Created by wangyuanfei on 16/9/13.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//

import UIKit

@objc protocol LoginDelegate : NSObjectProtocol {
   @objc optional  func loginResult(result : Bool)
    
}

class LoginVC: GDNormalVC {

    weak var loginDelegate : LoginDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.attritNavTitle = NSAttributedString(string: "登录")
        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor.randomColor()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func popToPreviousVC() {
        self.dismiss(animated: true, completion: {
            self.loginDelegate?.loginResult!(result: false)//登录成功(true)或失败(false)的回调 ,
        })
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        //        let secVC = VCWithNaviBar(vcType: VCType.WithBackButton)
        //        secVC.view.backgroundColor = UIColor.randomColor()
        //        let str =  NSAttributedString(string: "标题")
        //        secVC.attritNavTitle = str
        //
        //        self.navigationController?.pushViewController(secVC, animated: true)
        //        NetworkManager.shareManager.initToken({ (result) in
        //            mylog(result.data)
        //            mylog(result.msg)
        //            mylog(result.status!)
        //            }) { (error) in
        //                mylog(error)
        //        }
        GDNetworkManager.shareManager.login("wangyuanfei", password: "123456", success: { (result) in
//            mylog(result.data)
//            mylog(result.msg)
            mylog("登录成功")
            self.loginDelegate?.loginResult!(result: true)
            self.dismiss(animated: true, completion: { 
                //do something after dismiss
            })
        }) { (error) in
//            self.loginDelegate?.loginResult!(result: true)
           _ = self.checkErrorInfo(error: error)
            mylog(error)
        }
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
