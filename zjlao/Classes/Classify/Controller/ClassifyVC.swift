//
//  ClassifyVC.swift
//  mh824appWithSwift
//
//  Created by wangyuanfei on 16/8/24.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//

import UIKit

class ClassifyVC: GDNormalVC {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.yellow
//        self.title = NSLocalizedString("tabBar_classify", tableName: nil, bundle: Bundle.main, value:"", comment: "")
//        UIColor(hexString: "#ffe700ff")
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.showErrorView()
        self.naviBar.currentBarStatus = .changing
        mylog(self.naviBar.currentBarStatus)
        mylog(self.naviBar.alpha)
        /**    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"prefs:"]];*/
//        UIApplication.shared.openURL(URL(string: UIApplicationOpenSettingsURLString) ?? URL(string: "http://www.baidu.com")! )
//        UIApplication.shared.openURL(URL(string: "appsetting") ?? URL(string: "http://www.baidu.com")! )
//        (UIApplication.shared.delegate as? AppDelegate)?.performChangeLanguage(targetLanguage: "LocalizableCH")//更改语言
//        URL(UIApplication.shared.openURL(URL(string: UIApplicationOpenSettingsURLString)!)
    }
    override func errorViewClick() {
        self.hiddenErrorView()
    }
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        self.navigationController?.pushViewController(VCWithNaviBar.init(vcType: VCType.withBackButton), animated: true)
//    }

}
