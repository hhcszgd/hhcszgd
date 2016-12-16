//
//  ChooseLanguageVC.swift
//  zjlao
//
//  Created by WY on 16/10/19.
//  Copyright © 2016年 WY. All rights reserved.
/*进来时  确定按钮不可用 , 只有选择非当前语言后 确定按钮才可用**/

import UIKit

import MJRefresh
class ChooseLanguageVC: GDNormalVC/*,UITableViewDelegate ,*/ /*, UITableViewDataSource */{
    let languages : [String] = [/*LFollowSystemLanguage,*/LEnglish,LChinese]
    let bottomButton = UIButton()
//    let tableView = BaseTableView(frame: CGRect.zero, style: UITableViewStyle.plain)
    var  currentLanguageIndexPath = IndexPath(row: 111, section: 0)
    var  selectedLanguageIndexPath = IndexPath(row: 1111, section: 0)
    
    var choosedIndexPaths = [String : IndexPath]()
    
    var selectedLanguage : String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.naviBar.currentBarActionType = .offset // .color//.alpha //
        self.naviBar.layoutType = .asc
        self.automaticallyAdjustsScrollViewInsets = false
        self.setupSubViews()
        self.view.addSubview(bottomButton)
//        self.view.addSubview(tableView)
//        self.naviBar.currentBarStatus = .disapear
        // Do any additional setup after loading the view.
    }

    func setupSubViews()  {
        self.tableView.contentInset = UIEdgeInsetsMake(NavigationBarHeight, 0, 0, 0)
        let margin : CGFloat = 20.0
        
        let btnW : CGFloat = GDDevice.width - margin * 2
        let btnH : CGFloat = 44
        let btnX : CGFloat = margin
        let btnY : CGFloat = GDDevice.height - margin - btnH
        self.bottomButton.frame = CGRect(x: btnX, y: btnY, width: btnW, height: btnH)
        
        let tableViewX : CGFloat = 0
//        let tableViewY : CGFloat = NavigationBarHeight
        let tableViewY : CGFloat = 0
        let tableViewW : CGFloat = GDDevice.width
        let tableViewH : CGFloat = btnY - tableViewY - margin
        self.tableView.frame = CGRect(x: tableViewX, y: tableViewY, width: tableViewW, height: tableViewH)
//        self.tableView.contentInset  = UIEdgeInsetsMake(NavigationBarHeight, 0, 20, 0)
        self.tableView.backgroundColor = UIColor.randomColor()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        
        self.bottomButton.embellishView(redius: 5)
        self.bottomButton.backgroundColor = UIColor.red
        self.bottomButton.setTitle(GDLanguageManager.titleByKey(key: "confirm"), for: UIControlState.normal)
        self.bottomButton.addTarget(self, action: #selector(sureClick(sender:)), for: UIControlEvents.touchUpInside)
        self.bottomButton.setTitleColor(UIColor.white, for: UIControlState.normal)
        self.bottomButton.setTitleColor(UIColor.gray, for: UIControlState.disabled)
        self.bottomButton.isEnabled = false
        
    }
    override func refresh ()  {
        self.tableView.reloadData()
        self.tableView.mj_header.endRefreshing()
        self.tableView.mj_footer.state = MJRefreshState.idle
    }
    override func loadMore ()  {
        self.tableView.mj_footer.endRefreshingWithNoMoreData()
    }
    //MARK:UITableViewDelegate and UITableViewDataSource
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return self.languages.count ;
    }
    
    
    // Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
    // Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        var cell  = tableView.dequeueReusableCell(withIdentifier: "cell")
        if cell == nil  {
            cell = BaseCell(style: UITableViewCellStyle.subtitle, reuseIdentifier: "cell")
        }
        cell?.textLabel?.text = self.languages[indexPath.row]
        cell?.selectionStyle = UITableViewCellSelectionStyle.blue
        if let  currentLanguage = GDLanguageManager.LanguageTableName   {
            
            if self.selectedLanguageIndexPath.row == 1111 {//第一次
                if currentLanguage == languages[indexPath.row] {
                    cell?.isSelected = true
                    cell?.detailTextLabel?.text = "选中"
                    self.currentLanguageIndexPath = indexPath
                }else{
                    cell?.detailTextLabel?.text = "未选中"
                }
                
                
            }else{//点击了任何行以后
                if indexPath == self.selectedLanguageIndexPath {
                    cell?.detailTextLabel?.text = "选中"
                }else{
                    cell?.detailTextLabel?.text = "未选中"
                }
                if self.currentLanguageIndexPath == self.selectedLanguageIndexPath {
                    self.bottomButton.isEnabled = false
                    
                }else{
                    self.bottomButton.isEnabled = true
                }
            }

        }
        return cell ?? BaseCell()
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //无关紧要
        let currentStr = "\(indexPath.row)"
        if  let _ = self.choosedIndexPaths[currentStr] {//键能找到值
            self.choosedIndexPaths.removeValue(forKey: currentStr)
        }else{//找不到就加进去
            self.choosedIndexPaths[currentStr] = indexPath
        }
        //        self.tableView.beginUpdates()
        //        self.tableView.endUpdates()

        
        
        //重要
        self.selectedLanguageIndexPath = indexPath
        self.selectedLanguage = self.languages[indexPath.row]
        self.tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
         let currentStr = "\(indexPath.row)"
        if  let _ = self.choosedIndexPaths[currentStr] {
            return 66
        }else{return 44}
        
    }
    //MARK:customMethod
    func sureClick(sender : UIButton) {
        mylog(GDStorgeManager.standard.object(forKey: "AppleLanguages"))
        mylog(GDLanguageManager.gotcurrentSystemLanguage())
        if self.selectedLanguage == "" {
            GDAlertView.alert("请选择目标语言", image: nil, time: 2, complateBlock: nil)
            return
        }
        GDLanguageManager.performChangeLanguage(targetLanguage: self.selectedLanguage)
        NotificationCenter.default.post(name: GDLanguageChanged, object: nil, userInfo: nil)
        GDAlertView.alert("保存成功", image: nil , time: 2) {
            self.navigationController?.popViewController(animated: true)
        }
//        (UIApplication.shared.delegate as? AppDelegate)?.performChangeLanguage(targetLanguage: self.selectedLanguage)//更改语言

    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        mylog(scrollView.contentOffset)
//        mylog(scrollView.contentSize)
//        mylog(scrollView.bounds.size)
//        self.naviBar.currentBarActionType = .alpha
//        self.naviBar.layoutType = .desc
        self.naviBar.change(by: scrollView)
//        self.naviBar.changeWithOffset(offset: (scrollView.contentOffset.y + 64) / scrollView.contentSize.height)
//        self.naviBar.changeWithOffset(offset: scrollView.contentOffset.y, contentSize: scrollView.contentSize)

    }

}
