//
//  ProfileVC.swift
//  mh824appWithSwift
//
//  Created by wangyuanfei on 16/8/24.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//
//TODO: 消息按钮 固定不随tableView滚动
import UIKit

class ProfileVC: UIViewController ,ActionDelegate {
    let tableView = UITableView.init(frame: CGRect.init(x: 0, y: 0, width: GDDevice.width, height: GDDevice.height), style: UITableViewStyle.plain)
    var tableHeaderData : [AnyObject] {
        get{
            var tableHeaderModels = [AnyObject]()
            for item in totalData {
                guard let channelModel = item as? ProfileChannelModel else { continue}
                guard let key = channelModel.key else {continue}
                if key == "userinfo" {
                    tableHeaderModels.append(item)
                    break
                }
            }
            return tableHeaderModels
        }
    
    } //目前有个字典:头像,商品收藏,店铺收藏,我的足迹,用户等级
    var tableViewData : [AnyObject] {
        get{
            var tableModels = [AnyObject]()
            for item in totalData {
                guard let channelModel  = item as? ProfileChannelModel else { continue}
                guard let key = channelModel.key else {continue}
                
                switch key {
                case "order"  :
                    tableModels.append(channelModel)
                    break
                case "my_capital" :
                     tableModels.append(channelModel)
                    break
                case  "set"  :
                    tableModels.append(channelModel)
                    break
                case  "help" :
                    tableModels.append(channelModel)
                    break
                case "member_club" :
                    tableModels.append(channelModel)
                    break
                default: break
                }
            }
            return tableModels
        }
        
    }//有N个包含不同字段的字典
    var totalData = [AnyObject](){
        willSet {
//            totalData = newValue
        }
        
        didSet {
            
            var tempchannelModels = [AnyObject]()
            for item in totalData {
                guard var dict = item as? [String : AnyObject] else { continue}
                var tempSubModels = [AnyObject]()
                guard let tempItems = dict["items"] else {
                    
                    
                    let profileChannelModel = ProfileChannelModel(dict: dict)
                    tempchannelModels.append(profileChannelModel)
                    continue
                }
                guard let items = tempItems as? [AnyObject] else {
                    continue
                }
                for subItem in items {
                    guard let tempSubItem = subItem as? [String : AnyObject] else {continue}
                    let subModel = ProfileSubModel(dict: tempSubItem)
                    tempSubModels.append(subModel)
                }
                dict["items"] = tempSubModels as AnyObject?
                
                let profileChannelModel = ProfileChannelModel(dict: dict)
                tempchannelModels.append(profileChannelModel)
            }

            
            
            totalData =  tempchannelModels
        
        }
    
    }//原始总数据 , 将会拆分成上面连个小数组
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.automaticallyAdjustsScrollViewInsets = false
//        self.title = "profile"
//        self.title = NSLocalizedString("tabBar_profile", tableName: nil, bundle: Bundle.main, value:"", comment: "")
        self.view.backgroundColor = UIColor.orange
               // Do any additional setup after loading the view.
        self.setupTableView()
        
    }
    func setupTableView() -> () {
        tableView.frame = CGRect(x: 0, y: 0, width: GDDevice.width, height: GDDevice.height);
        self.view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        self.tableView.separatorStyle=UITableViewCellSeparatorStyle.none
        let tableHeader = PTableHeaderView(frame: CGRect(x: 0, y: 0, width: GDDevice.width, height:  GDCalculator.GDAdaptation(200.0)))
        tableHeader.actionDelegate = self
        tableView.tableHeaderView = tableHeader
        
    }
    

    func performAction( model: BaseModel) {
         SkipManager.skip(viewController: self, model: model)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.gotData(.initialize, success: { (result) in
            
        }) { (error) in
            
        }

    }
    
    func gotData(_ type:LoadDataType ,success: (_ result:OriginalNetDataModel) -> () , failure : (_ error : NSError) ->() ) -> () {
        switch type {
        case .initialize:
            if Account.shareAccount.isLogin {
                GDNetworkManager.shareManager.gotProfilePageData({ (result) in//网络获取数据成功
                    guard let tempTotalData = result.data as? [AnyObject] else {return}
                    self.totalData = tempTotalData
                    mylog(self.totalData)
                    mylog(self.tableHeaderData)
                    mylog(self.tableViewData)
                    guard let headerView =  self.tableView.tableHeaderView as? PTableHeaderView else {return}
                    guard let headerModel = self.tableHeaderData.first as? ProfileChannelModel else {return}
                    headerView.headerChannelModel = headerModel//给头视图赋值
                    
                    self.tableView.reloadData()
                    
                }) { (error) in //网络失败时,从bundel读取数据
                    guard  let profileDictDataPath = gotResourceInSubBundle("ProfileData", type: "plist", directory: "Txt") else {
                        return
                    }
                    
                    if  let profileDictData = NSDictionary.init(contentsOfFile: profileDictDataPath){
                        
                        
                        let originalNetDataModel = OriginalNetDataModel.init(dict: profileDictData as! [String : AnyObject])
                        self.totalData = originalNetDataModel.data as! [AnyObject]
                        guard let headerView =  self.tableView.tableHeaderView as? PTableHeaderView else {return}
                        guard let headerModel = self.tableHeaderData.first as? ProfileChannelModel else {return}
                        headerView.headerChannelModel = headerModel//给头视图赋值
                        
                        self.tableView.reloadData()
                        mylog("网络获取失败,从硬盘获取个人中心数据")
                    }else {
                        mylog("从硬盘读取数据错误")
                    }
                    mylog(error)
                }
                
            }else{
                guard  let profileDictDataPath = gotResourceInSubBundle("ProfileData", type: "plist", directory: "Txt") else {
                    return
                }
                if  let profileDictData = NSDictionary.init(contentsOfFile: profileDictDataPath){
                    let originalNetDataModel = OriginalNetDataModel.init(dict: profileDictData as! [String : AnyObject])
                    self.totalData = originalNetDataModel.data as! [AnyObject]
                    guard let headerView =  self.tableView.tableHeaderView as? PTableHeaderView else {return}
                    guard let headerModel = self.tableHeaderData.first as? ProfileChannelModel else {return}
                    headerView.headerChannelModel = headerModel//给头视图赋值
                    
                    self.tableView.reloadData()
                    mylog("网络获取失败,从硬盘获取个人中心数据")
                }else {
                    mylog("从硬盘读取数据错误")
                }
            }
            break
        case .reload: //这个可以实现一下(看需求)
            
            break
        case .loadMore://这个没必要实现了
            
            break
            
//        default: break
        }
    }


}

extension ProfileVC :  UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.tableViewData.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if  let channelModel = self.tableViewData[indexPath.row] as? ProfileChannelModel {
            if let key = channelModel.key {
                if let cell = tableView.dequeueReusableCell(withIdentifier: "cell") {
                    if let trueCell = cell as? PtableViewCell {
                        trueCell.channelModel = channelModel
                        trueCell.subViewDelegate = self
                    }
                    
                    return cell
                }else{
                    /*
                    switch key {
                    case "order":
                        return  OrderCell.init(style: UITableViewCellStyle.default, reuseIdentifier: key)
                        
                        break
                    case "my_capital":
                        return  CapitalCell.init(style: UITableViewCellStyle.default, reuseIdentifier: key)
                        
                        break
                    case "set":
                        return  SetCell.init(style: UITableViewCellStyle.default, reuseIdentifier: key)
                        
                        break
                    case "help":
                        return  HelpCell.init(style: UITableViewCellStyle.default, reuseIdentifier: key)
                        
                        break
                    case "member_club":
                         return  ClubCell.init(style: UITableViewCellStyle.default, reuseIdentifier: key)
                        
                        break
                    default:
                         return  UITableViewCell.init(style: UITableViewCellStyle.default, reuseIdentifier: "systemCell")
                    }

                    */
                    
                    let cell = PtableViewCell.init(style: UITableViewCellStyle.default, reuseIdentifier: "cell")
                    cell.channelModel = channelModel
                    cell.subViewDelegate = self 
                    return cell
                }
                
            }
            
        }
        
        return  UITableViewCell.init(style: UITableViewCellStyle.default, reuseIdentifier: "systemCell")
        
        
        
        
//        if  let cell  : UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell") {
//            cell.backgroundColor = UIColor.randomColor()
//            return cell
//        }else{
//            let theCell = UITableViewCell.init(style: UITableViewCellStyle.default, reuseIdentifier: "cell")
//            theCell.backgroundColor = UIColor.randomColor()
//            return theCell
//        }
//        if
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard  let channelModel = self.tableViewData[indexPath.row] as? ProfileChannelModel else{return 0.000001}
        guard let key = channelModel.key else {return 0.0000001}
        let cacuModel = CaculateModel()
        
        cacuModel.headerHeight = 44 ;
        switch key {
        case "order" , "my_capital":
            cacuModel.toHeaderMargin = 1
            cacuModel.itemCount = 1 
            cacuModel.itemHeight = NavigationBarHeight
            cacuModel.bottomMargin = 10
            break
//        case "my_capital":
//            cacuModel.toHeaderMargin = 1
//            cacuModel.itemCount = 1
//            cacuModel.itemHeight = 80.0
//            cacuModel.toHeaderMargin = 1
//            
//            break
        case "set" , "help" , "member_club":
            cacuModel.bottomMargin = 1
            
            break
//        case "help":
//            
//            
//            break
//        case "member_club":
//            
//            
//            break
        default:
            break
        }
        
        
       return CaculateManager.newCaculateRowHeight(caculateModel: cacuModel)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        SkipManager.skip(viewController: self, model: BaseModel.init(dict: ["actionkey" : "goodscollect" as AnyObject]))
    }
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        self.viewDidLoad()
    }

}
