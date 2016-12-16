//
//  HomeVC.swift
//  mh824appWithSwift
//
//  Created by wangyuanfei on 16/8/24.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//

import UIKit
import MBProgressHUD
import AFNetworking
class HomeVC: GDNormalVC  {

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        self.viewDidLoad()
    }

    func testxxx() {
        var count: UInt32 = 0
        let ivars = class_copyIvarList(BaseModel.self, &count)
        
        for i in 0 ..< count {
            let ivar = ivars![Int(i)]
            let name = ivar_getName(ivar)
            mylog(String(cString: name!))
        }
        free(ivars)
    }
    func testyyy() {
        var count: UInt32 = 3

        let objc_property_tS = class_copyPropertyList(BaseModel.self, &count)
        for i in 0 ..< count {
            let objc_property_tO = objc_property_tS![Int(i)]
            let name = property_getName(objc_property_tO)
            mylog(String(cString: name!))
        }
        free(objc_property_tS)
    }
    func setupTableView() {
        tableView.contentInset = UIEdgeInsets(top: NavigationBarHeight, left: 0, bottom: TabBarHeight, right: 0)
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupTableView()
       self.testyyy()
        self.naviBar.backgroundColor  = UIColor.orange
        self.naviBar.currentBarActionType = .color//.alpha //.offset //
        self.naviBar.layoutType = .asc
//        NSLocalizedString(<#T##key: String##String#>, comment: <#T##String#>)//默认加载Localizable
//        NSLocalizedString(<#T##key: String##String#>, tableName: <#T##String?#>, bundle: <#T##Bundle#>, value: <#T##String#>, comment: <#T##String#>)
        
//        self.title = NSLocalizedString("tabBar_home", tableName: nil, bundle: Bundle.main, value:"", comment: "")
        self.view.backgroundColor = UIColor.randomColor()

        
        
        let leftBtn1 = UIButton(type: UIButtonType.contactAdd)
        naviBar.leftBarButtons = [leftBtn1]
        let rightBtn1 = UIButton(type: UIButtonType.contactAdd)
        naviBar.rightBarButtons = [rightBtn1]
        let navTitleView = NavTitleView()
        navTitleView.backgroundColor = UIColor.randomColor()
        navTitleView.insets = UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10);
        naviBar.navTitleView = navTitleView
        
        self.setupTableView()
        
        
        leftBtn1.addTarget(self, action: #selector(qrScanner), for: UIControlEvents.touchUpInside)
        // Do any additional setup after loading the view.
    }
    func qrScanner()  {
        let model = BaseModel.init(dict: ["actionkey" : "QRCodeScannerVC" as AnyObject])
        SkipManager.skip(viewController: self, model: model)
        
//        let qrvc = QRCodeScannerVC(vcType: VCType.withBackButton)
//        qrvc.delegate = self
//        self.navigationController?.pushViewController(qrvc, animated: true )
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    override  func sectionIndexTitles(for tableView: UITableView) -> [String]?{
        var arr = [String]()
        for   index in 0..<3  {
            arr.append(" \(index) ")
        }
        return arr
    }
    func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool{
        if indexPath.row == 0  {
            return true
        }else{
            return false 
        }
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.tableView.allowsMultipleSelection = true
        mylog(self.naviBar.isHidden)

//                self.tableView.setEditing(true , animated: true )
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 18
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.naviBar.change(by: scrollView)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        self.navigationController?.pushViewController(VCWithNaviBar.init(vcType: VCType.withBackButton), animated: true)
         self.navigationController?.pushViewController(GDNormalVC(), animated: true)
    }
    
    
    

    func gotData(_ type:LoadDataType ,success: (_ result:OriginalNetDataModel) -> () , failure : (_ error : NSError) ->() ) -> () {
        switch type {
        case .initialize:
            
            break
        case .reload:
            
            break
        case .loadMore:
            
            break
//            
//        default: break
        }
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
