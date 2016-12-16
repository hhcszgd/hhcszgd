//
//  ShopCarNaviVC.swift
//  mh824appWithSwift
//
//  Created by wangyuanfei on 16/8/24.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//

import UIKit

class ShopCarNaviVC: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(LaoNaviVC.languageChanged), name: GDLanguageChanged, object: nil)

        self.tabBarItem.image = UIImage(named: "tab_Shopping Cart_normal")
        self.tabBarItem.selectedImage = UIImage(named: "tab_Shopping Cart_click")
//        self.tabBarItem.title = NSLocalizedString("tabBar_shopcar", tableName: LanguageTableName, bundle: Bundle.main, value:"", comment: "")
        self.navigationBar.isHidden = true;

        self.tabBarItem.title = GDLanguageManager.titleByKey(key: LTabBar_shopcar)//gotTitleStr(key: "tabBar_shopcar")
//        self.tabBarItem.title = "shopcar"
//        self.tabBarItem.selectedImage?.renderingMode = UIImageRenderingMode.UIImageRenderingModeAlwaysOriginal
        // Do any additional setup after loading the view.
    }
    func languageChanged() {
        self.tabBarItem.title = GDLanguageManager.titleByKey(key: LTabBar_shopcar)  // gotTitleStr(key: "tabBar_lao")
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if self.childViewControllers.count != 0 {
            viewController.hidesBottomBarWhenPushed = true
        }
        super.pushViewController(viewController, animated: animated)
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
