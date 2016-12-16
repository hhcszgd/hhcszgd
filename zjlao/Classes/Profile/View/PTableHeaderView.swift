//
//  PTableHeaderView.swift
//  mh824appWithSwift
//
//  Created by wangyuanfei on 16/9/8.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
/*tableView的头视图**/

import UIKit
import SDWebImage
class PTableHeaderView: BaseView{
//    weak var actionDelegate : ActionDelegate?
    var headerChannelModel : ProfileChannelModel =  ProfileChannelModel(dict : nil) {
        didSet {
            
            if Account.shareAccount.isLogin {
                name.text = Account.shareAccount.name
            }else {
                name.text = "点击登录"
            }
            
            guard let items =  headerChannelModel.items else {return}
            
            for item in self.menuContainer.subviews {
                item.removeFromSuperview()
            }
            
            for item in items {
                guard let subModel = item as? ProfileSubModel else{ continue}
                subModel.judge = true
                guard let actionKey = subModel.actionkey else {continue}
                //            actionDelegate?.fuckfuck(self, model: BaseModel(dict: nil))
                if actionKey == "info" {//头像
                    self.iconContainer.model = subModel
                    if let imgUrl = subModel.img {
                        if Account.shareAccount.head_images != nil {//从账户对象里取去 , 但有一种可能是取不到的 , 登录完以后,由于网络原因,先执行获取个人首页 ,后执行获取个人信息 , 此时头像链接是个人中心接口中的无效头像链接
                           self.icon.sd_setImage(with: imgStrConvertToUrl(Account.shareAccount.head_images!), for: UIControlState())
                        }else   if imgStrConvertToUrl(imgUrl) != nil  {//此接口反的头像链接不能用
                            self.icon.sd_setImage(with: imgStrConvertToUrl(imgUrl), for: UIControlState())
                        }else{//显示站位图片
                            self.icon.setImage(UIImage(named: "bg_nohead" ), for: UIControlState())
                        }
                    }else{//显示站位图片
                        self.icon.setImage(UIImage(named: "bg_nohead" ), for: UIControlState())
                    }
                    
                }else if (actionKey == "goodscollect"){//商品收藏
                    let goodcollect =  PTableHeaderSub()
                    goodcollect.model = subModel
                    self.menuContainer.addSubview(goodcollect)
                    goodcollect.addTarget(self, action: #selector(click(sender:)), for: UIControlEvents.touchUpInside)
                    mylog("商品收藏")
                }else if (actionKey == "shopcollect"){//店铺收藏
                    let shopcollect =  PTableHeaderSub()
                    shopcollect.addTarget(self, action: #selector(click(sender:)), for: UIControlEvents.touchUpInside)

                    shopcollect.model = subModel
                    self.menuContainer.addSubview(shopcollect)
                    mylog("店铺收藏")
                }else if (actionKey == "focusbrand"){//足迹
                    let foothistory =  PTableHeaderSub()
                    foothistory.addTarget(self, action: #selector(click(sender:)), for: UIControlEvents.touchUpInside)

                    subModel.localImgName = "icon_footprint"//加载本地图片 ,手动赋值
                    foothistory.model = subModel
                    
                    self.menuContainer.addSubview(foothistory)
                    mylog("足迹")
                }else if (actionKey == "usergrade"){//等级
                    mylog("等级")
                    guard let levelImageName = subModel.level else {
                        levelImg.isHidden = true
                        continue
                    }
                    if let  levelNum =  Int(levelImageName) {
                        if levelNum == 0 {
                             levelImg.isHidden = true
                        }else {
                            levelImg.isHidden = false
                            levelImg.image = UIImage(named: "level_v\(levelNum)")
                        }
                    }else{
                        levelImg.isHidden = true
                    }

                }
            }
            
            /*保险起见 , 再给头像赋值一次*/
            if Account.shareAccount.head_images != nil {
                self.icon.sd_setImage(with: imgStrConvertToUrl(Account.shareAccount.head_images!), for: UIControlState())
            }else{//显示站位图片
                self.icon.setImage(UIImage(named: "bg_nohead" ), for: UIControlState())
            }
            self.setNeedsLayout()//这两句才能确定调用layoutSubviews
            self.layoutIfNeeded()
        }
    
    }
    let iconContainer = PTableHeaderSub()//头像容器视图
   

    let icon  = UIButton.init()//头像
    let levelImg = UIImageView.init()//等级
    let name = UILabel()//用户名
    let menuContainer = UIView() //收藏,足迹等子视图的容器视图
  private  let backImageView = UIImageView()//头部背景视图
    var backImg : UIImage? = UIImage.init(named: "bg_my")
//    let gooodCollect = UIView()//商品收藏
//    let shopCollect = UIView()//店铺收藏
//    let footHistory = UIView()//足迹
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backImageView.image = backImg
        self.addSubview(backImageView)
        self.addSubview(iconContainer)
        self.iconContainer.addTarget(self, action: #selector(click(sender:)), for: UIControlEvents.touchUpInside)
        self.addSubview(name)
        self.addSubview(menuContainer)
        iconContainer.addSubview(icon)
//        icon.backgroundColor = UIColor.randomColor()
//        icon.addTarget(self, action: #selector(click(sender:)), for: UIControlEvents.touchUpInside)
        icon.isUserInteractionEnabled = false
        iconContainer.addTarget(self, action: #selector(click(sender:)), for: UIControlEvents.touchUpInside)
        iconContainer.addSubview(levelImg)
//        levelImg.backgroundColor = UIColor.randomColor()
//        name.backgroundColor = UIColor.randomColor()
        name.font = UIFont.systemFont(ofSize: 14*SCALE)
        name.textColor = UIColor.white
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        let backImgViewW : CGFloat = GDDevice.width
         var backImgViewH : CGFloat = 0
        if backImg != nil {
            
             backImgViewH = (backImg?.size.height)!/(backImg?.size.width)!*backImgViewW
        }else{
            backImgViewH = GDDevice.width
            self.backgroundColor = UIColor.orange
        }
        
        
        
        let backImgViewX : CGFloat = 0
        let backImgViewY : CGFloat = -(backImgViewH - self.bounds.size.height)
        self.backImageView.frame = CGRect(x: backImgViewX, y: backImgViewY, width: backImgViewW, height: backImgViewH)
        
        iconContainer.bounds = CGRect(x: 0, y: 0, width: 66 * SCALE, height: 66 * SCALE)
        iconContainer.center = CGPoint(x: self.frame.size.width/2, y: self.frame.size.height/2)
        icon.frame = iconContainer.bounds
        levelImg.bounds = CGRect(x: 0, y: 0, width: 20, height: 20)
        levelImg.center = self.test(66*SCALE)
        
        icon.layer.cornerRadius = 66.0 * SCALE / 2
        icon.layer.masksToBounds = true
        
        levelImg.layer.cornerRadius = 20.0 * SCALE / 2
        levelImg.layer.masksToBounds = true
        name.sizeToFit()
        name.center = CGPoint(x: self.bounds.size.width/2, y: iconContainer.frame.maxY + name.bounds.size.height/2)
        let menuW = self.bounds.size.width
        let menuH = 44 * SCALE
        let menuX : CGFloat = 0.0
        let menuY = self.bounds.size.height - menuH
        
        self.menuContainer.frame = CGRect(x: menuX, y: menuY, width: menuW, height: menuH)
        
        if self.menuContainer.subviews.count > 0 {
            let oneW = self.bounds.size.width / CGFloat(self.menuContainer.subviews.count)
            for  index in 0 ..< self.menuContainer.subviews.count {
                let item  = self.menuContainer.subviews[index]
                item.frame = CGRect(x: oneW * CGFloat(index), y: 0, width: oneW, height: self.menuContainer.bounds.size.height)
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func click(sender : BaseControl ) -> () {
        if let transSender = sender as? PTableHeaderSub {
            self.actionDelegate?.performAction(model: transSender.model)
        }else{
            mylog("profile 首页头部点击无效")
        }
    }
    

    
    func test (_ bianChang : CGFloat) -> (CGPoint) { //给定一个正方形UIView的边长 求小圆的圆心在 内切圆边上的最表 , 即等级图片的中心点 在头像所处的内切圆边上的坐标
//        sqrt(<#T##Double#>)//开方
        let zhiJiaoBian = bianChang/2
        let xieBian = sqrt(zhiJiaoBian * zhiJiaoBian*2)
        let xiaoXieBian = xieBian - zhiJiaoBian
        let xiaoZhiJiaoBian =  sqrt(xiaoXieBian * xiaoXieBian / 2)
        let levelCenter =  CGPoint(x: bianChang-xiaoZhiJiaoBian, y: bianChang - xiaoZhiJiaoBian)
        
        
        return levelCenter
    }

}



