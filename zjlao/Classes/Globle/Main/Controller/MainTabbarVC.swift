//
//  MainTabbarVC.swift
//  mh824appWithSwift
//
//  Created by wangyuanfei on 16/8/24.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//

import UIKit

class MainTabbarVC: UITabBarController {
    let mainTabbar  =  MainTabbar.share
    override func viewDidLoad() {
        super.viewDidLoad()
        mainTabbar.delegate = self
        setValue(mainTabbar, forKey: "tabBar")
        self.addchileVC()
    }
    
    override  var selectedIndex: Int  {
        set {
            super.selectedIndex = newValue
        }
        get{
            return super.selectedIndex
        }
    
    }
    func addchileVC() -> () {

        for subVC in self.childViewControllers {
            subVC.removeFromParentViewController()
        }
        self.addChildViewController(HomeVaviVC(rootViewController: HomeVC()))
        self.addChildViewController(ClassifyNaviVC(rootViewController: ClassifyVC()))
        self.addChildViewController(LaoNaviVC(rootViewController: LaoVC()))
        self.addChildViewController(ShopCarNaviVC(rootViewController: ShopCarVC()))
        self.addChildViewController(ProfileNaviVC(rootViewController: ProfileVC()))

        
        mylog(self.childViewControllers)
        
    }
    
    func restartAfterChangeLanguage() {
        self.setViewControllers([HomeVaviVC(rootViewController: HomeVC()),ClassifyNaviVC(rootViewController: ClassifyVC()),LaoNaviVC(rootViewController: LaoVC()),ShopCarNaviVC(rootViewController: ShopCarVC()),ProfileNaviVC(rootViewController: ProfileVC())], animated: true)
    }
    
//     func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool{
//        return true
//    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
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
