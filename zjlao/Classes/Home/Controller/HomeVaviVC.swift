//
//  HomeVaviVC.swift
//  mh824appWithSwift
//
//  Created by wangyuanfei on 16/8/24.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//

import UIKit

class HomeVaviVC: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(LaoNaviVC.languageChanged), name: GDLanguageChanged, object: nil)

        self.tabBarItem.image = UIImage(named: "tab_home_normal")
        self.tabBarItem.selectedImage = UIImage(named: "tab_home_click")
        self.navigationBar.isHidden = true;
//        NSLocalizedString()
//        self.tabBarItem.title = NSLocalizedString("tabBar_home", tableName: "LocalizableEN", bundle: Bundle.main, value:"", comment: "") // 加载指定语言包名(LocalizableEN) 里的键对应的值
//        self.tabBarItem.title = NSLocalizedString("tabBar_home", tableName: LanguageTableName, bundle: Bundle.main, value:"", comment: "") // 加载指定语言包名(LocalizableEN) 里的键对应的值
        self.tabBarItem.title  = GDLanguageManager.titleByKey(key: LTabBar_home) //gotTitleStr(key: "tabBar_home")
        
        // Do any additional setup after loading the view.
    }
    func languageChanged() {
        self.tabBarItem.title = GDLanguageManager.titleByKey(key: LTabBar_classify)  // gotTitleStr(key: "tabBar_lao")
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
