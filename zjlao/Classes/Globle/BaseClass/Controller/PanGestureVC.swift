//
//  PanGestureVC.swift
//  zjlao
//
//  Created by WY on 16/10/13.
//  Copyright © 2016年 WY. All rights reserved.
//

import UIKit

 class PanGestureVC: GDNormalVC ,UIGestureRecognizerDelegate{

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
//        let target = self.navigationController?.interactivePopGestureRecognizer?.delegate
       let pan = UIPanGestureRecognizer.init(target: self, action: #selector(handleNavigationTransition(_:)))
        pan.delegate = self
        self.view.addGestureRecognizer(pan)
         self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false ;
        // Do any additional setup after loading the view.
    }
    func handleNavigationTransition(_:Any){
    
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func gestureRecognizerShouldBegin(gestureRecognizer: UIGestureRecognizer) -> Bool {
        ///判断是否是根控制器
        if self.childViewControllers.count == 1
        {
            return false
        }  
        return true
    }
    func testCommit() {
        mylog("首次提交")
    }
    func testFromDevToMaster() {
        mylog("测试从开发分支切换回柱分支并提交")
    }
    func testThriedCommit() {
        mylog("测试提交到开发分支")
    }
    func testtestFourthCommit() {
        mylog("测试提交到开发分支2")
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
