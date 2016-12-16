//
//  ProfileNaviVC.swift
//  mh824appWithSwift
//
//  Created by wangyuanfei on 16/8/24.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//

import UIKit

class ProfileNaviVC: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(LaoNaviVC.languageChanged), name: GDLanguageChanged, object: nil)

        self.navigationBar.isHidden = true
        self.tabBarItem.image = UIImage(named: "tab_me_normal")
        self.tabBarItem.selectedImage = UIImage(named: "tab_me_click")
//        self.tabBarItem.title = "profile"
//         self.tabBarItem.title = NSLocalizedString("tabBar_profile", tableName: LanguageTableName, bundle: Bundle.main, value:"", comment: "") //当找不到相应的语言包时  , 默认显示上一次设置的语言
        self.tabBarItem.title = GDLanguageManager.titleByKey(key: LTabBar_profile) //gotTitleStr(key: "tabBar_profile")
        
        // Do any additional setup after loading the vie\w.
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
    func languageChanged() {
        self.tabBarItem.title = GDLanguageManager.titleByKey(key: LTabBar_profile)  // gotTitleStr(key: "tabBar_lao")
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
