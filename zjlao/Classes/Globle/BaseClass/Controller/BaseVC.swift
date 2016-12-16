//
//  BaseVC.swift
//  mh824appWithSwift
//
//  Created by wangyuanfei on 16/8/24.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//

import UIKit

class BaseVC: UIViewController {
   /* private*/ var errorView : GDErrorView?

    var TabBarHeight : CGFloat {
        return self.tabBarController?.tabBar.bounds.size.height ?? 44.0
    }
    var parameter : AnyObject? //用来接收关键参数的属性 (字符串 , 自定义模型等等)
    var keyModel : BaseModel? = BaseModel.init(dict: nil){
        didSet{
            mylog(keyModel)
        }
    
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.randomColor()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.addSubViews()
        self.setupContentAndFrame()
    }

    func addSubViews () {
        
    }
    func setupContentAndFrame () {
        
    }
    
    /// 网络请求失败时调用这个方法以判断是否是没联网 , 当网络错误是自动展示错误页面
    ///
    /// - Parameter error: 错误参数
    /// - Returns: 网络是否可用
    func checkErrorInfo(error:NSError) -> Bool {
        if error.code == -11111 {
            self.showErrorView()//网络错误
            return false
        }else{
            return true //非网络原因
        }
    }
    
    
    //MARK:页面加载错误是调这个方法
    func showErrorView ()  {
        self.errorView = GDErrorView()
        self.errorView?.addTarget(self, action: #selector(errorViewClick), for: UIControlEvents.touchUpInside)
        self.view.addSubview(errorView!)
//        self.view.insertSubview(errorView!, belowSubview: self.naviBar)
        self.errorView?.frame = self.view.bounds
        
        
    }
    //MARK://子类重写它 , 在方法中调hiddenErrorView()
    func errorViewClick ()  {
        
    }
    func hiddenErrorView()  {
        self.errorView?.removeFromSuperview()
        self.errorView = nil
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
