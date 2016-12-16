//
//  SettingVC.swift
//  zjlao
//
//  Created by WY on 16/10/16.
//  Copyright © 2016年 WY. All rights reserved.
//

import UIKit

import SDWebImage


class SettingVC: GDNormalVC {

//    let tableView = BaseTableView.init(frame: <#T##CGRect#>, style: <#T##UITableViewStyle#>)

    let topComtaier = UIView()
    let switchButton = UISwitch()
    let loginOutButton = UIButton()
    let versionLabel =  UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(self.topComtaier)
        self.view.addSubview(self.loginOutButton)
          self.loginOutButton.addTarget(self , action: #selector(performLoginOut), for: UIControlEvents.touchUpInside)
        self.topComtaier.backgroundColor = UIColor.randomColor()
    }

    override func addSubViews() {
        for subView in self.topComtaier.subviews {
            subView.removeFromSuperview()
        }
        let lines : NSInteger = 5
        for _ in 0 ..< lines {
            let rowView = RowView.init(frame: CGRect.zero)
            self.topComtaier.addSubview(rowView)
        }
        self.versionLabel.font = UIFont.systemFont(ofSize: 12*SCALE)
        self.versionLabel.textColor = SubTitleColor
        self.view.addSubview(self.versionLabel)

    }
    /*
     //设置页面
     "SSoundNotice" = "消息通知提示" ;
     "SImageQuarlity" = "图片质量" ;
     "SClearCache" = "清除缓存" ;
     "SGrade" = "给我们评分" ;
     "SChangeLanguage" = "更改语言" ;
     "SCurrentVersion" = "当前版本号为" ;
     "SLoginout" = "退出登录" ;
     */
    override func setupContentAndFrame() {
        self.attritNavTitle = NSAttributedString.init(string: GDLanguageManager.titleByKey(key: "SSetting"))//"设置"
        //topContainer
        let lineH : CGFloat  = 44.0
        let margin : CGFloat = 5.0
        let lines : NSInteger = 5
        self.topComtaier.frame = CGRect(x: 0, y: 88, width: GDDevice.width, height: (lineH+margin) * CGFloat(lines) )
        for (index , rowView) in self.topComtaier.subviews.enumerated() {
            if let rowView  = rowView as? RowView {
                rowView.frame  =  CGRect(x: 0, y: (lineH+margin)*CGFloat(index), width: GDDevice.width, height: lineH)
                rowView.titleLabel.font = UIFont.systemFont(ofSize: 12*SCALE)
                if index == 0{//消息通知
                    //                self.switchButton.center = CGPoint(x: screenW - 10 - self.switchButton.bounds.width, y: (rowView.bounds.size.height - self.switchButton.bounds.size.height ) * 0.5)//自定义控件缺陷,center 无效 , 只能用frame
                    self.switchButton.frame = CGRect(x: GDDevice.width - 10 - self.switchButton.bounds.size.width, y: (rowView.bounds.size.height - self.switchButton.bounds.size.height)*0.5, width: self.switchButton.bounds.size.width, height: self.switchButton.bounds.size.height)
                    rowView.diyView = self.switchButton
                    self.switchButton.addTarget(self, action: #selector(changeNoticeCustomSound(sender:)), for: UIControlEvents.valueChanged)
                    rowView.titleLabel.text = GDLanguageManager.titleByKey(key: "SSoundNotice")//"消息通知提示"
                    rowView.additionalImageView.isHidden = true
                }else if index == 1 {
                    //图片质量选择
                    rowView.addTarget(self, action: #selector(changeImageQuality(sender : )), for: UIControlEvents.touchUpInside)
                    rowView.titleLabel.text = GDLanguageManager.titleByKey(key: "SImageQuarlity")//"图片质量"
                    rowView.subTitleLabel.text = GDLanguageManager.titleByKey(key: "SSmartMode")//"智能模式"
                }else if index == 2{
                    //清除缓存
                    rowView.addTarget(self, action: #selector(clearCache(sender : )), for: UIControlEvents.touchUpInside)
                    rowView.titleLabel.text = GDLanguageManager.titleByKey(key: "SClearCache")//"清除缓存"
                    rowView.additionalImageView.isHidden = true
                    DispatchQueue.global(qos: .userInitiated).async {
                        //your code here
                        DispatchQueue.main.async { [weak self] in
                            rowView.subTitleLabel.text = "\(SDImageCache.shared().getSize()/1024/1024) MB"
                        }
                    }
                }else if index == 3 {
                            //评分
                            rowView.addTarget(self, action: #selector(valuation(sender : )), for: UIControlEvents.touchUpInside)
                            rowView.titleLabel.text = GDLanguageManager.titleByKey(key: "SGrade")//"给我们评分"
                }else if index ==  4 {
                            //评分
                            rowView.addTarget(self, action: #selector(performChangeLanguage(sender : )), for: UIControlEvents.touchUpInside)
                            rowView.titleLabel.text = GDLanguageManager.titleByKey(key: "SChangeLanguage")//"更改语言"
                }else { }
            }
        }
        //版本号
        mylog(Bundle.main.localizedInfoDictionary)
        mylog(Bundle.main.infoDictionary)
        if let versionCodeStr = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String {
            
            self.versionLabel.text = "\(GDLanguageManager.titleByKey(key: "SCurrentVersion")) : \(versionCodeStr)"
        }
        self.versionLabel.sizeToFit()
        self.versionLabel.center = CGPoint(x: GDDevice.width/2, y: self.topComtaier.frame.maxY+14)
        //退出按钮
        self.loginOutButton.backgroundColor = UIColor.red
        let w : CGFloat = GDDevice.width - 40
        let h : CGFloat = 48.0
        let x : CGFloat = (GDDevice.width - w) / 2
        let y : CGFloat = self.topComtaier.frame.maxY + 44.0
        self.loginOutButton.frame = CGRect(x: x, y: y, width: w, height: h)
        self.loginOutButton.setTitle(GDLanguageManager.titleByKey(key: "SLoginout"), for: UIControlState.normal)
        self.loginOutButton.embellishView(redius: 5)
      }
   
    func performLoginOut() {
        mylog("退出登录")
        if Account.shareAccount.isLogin {
            GDNetworkManager.shareManager.loginOut({ (result) in
                mylog(result.description)

                GDAlertView.alert("退出成功", image: nil, time: 2, complateBlock: {
                     _ = self.navigationController?.popViewController(animated: true)
                })

            }) { (error) in
                
                GDAlertView.alert("退出成功", image: nil, time: 2, complateBlock: {
                    _ = self.navigationController?.popViewController(animated: true)
                })
                mylog(error)
            }
        }else{
            GDAlertView.alert("未 登 录", image: nil, time: 2, complateBlock: nil)
        }
        
    }
    func valuation(sender : RowView){
        mylog("评分")
        let urlStr = "itms-apps://itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=1133780608"
        let url = URL(string: urlStr)
        guard let  realUrl = url  else {
            return
        }
        if UIApplication.shared.canOpenURL(realUrl) {
            UIApplication.shared.openURL(realUrl)
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
            self.loginOutButton.isHidden = !Account.shareAccount.isLogin
    }
    func clearCache(sender : RowView){
        mylog("清除缓存")
        SDImageCache.shared().clearMemory()
        SDImageCache.shared().cleanDisk()
        GDAlertView.alert("清除成功", image: nil, time: 2, complateBlock: nil)
        sender.subTitleLabel.text = "0 MB"
    }
    func changeImageQuality(sender : RowView){
        mylog("改变图片质量")
    }
    func changeNoticeCustomSound(sender : UISwitch){
        mylog("改变声音")
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func performChangeLanguage(sender : RowView){
        mylog("更改语言")
        let chooseLanguageVCModel = BaseModel(dict: nil)
        chooseLanguageVCModel.actionkey = "ChooseLuanguageVC"
        SkipManager.skip(viewController: self, model: chooseLanguageVCModel)
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        mylog(self.naviBar.isHidden)
    }

}
