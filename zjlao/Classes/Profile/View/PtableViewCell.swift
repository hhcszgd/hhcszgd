//
//  PtableViewCell.swift
//  mh824appWithSwift
//
//  Created by wangyuanfei on 16/9/20.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
/*个人中心自定义tableViewCell**/

import UIKit

class PtableViewCell: BaseCell  , ActionDelegate{

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    var channelModel = ProfileChannelModel(dict : nil){
        didSet{
            if let channelName = channelModel.channel {
                self.cellHeader.cellHeaderModel = channelModel
                self.cellHeader.titleLabel.text = channelName
//                self.cellHeader. = channelModel
                if let items = channelModel.items{
                    if items.count > 0 {
                        cellBody.arr = items as! [ProfileSubModel]
                    }
                    
                }
            }
            if let key = channelModel.key {
                channelModel.judge = true
                switch key {
                case "order":
                    self.cellHeader.subTitleLabel.text = "查看全部订单"
//                    self.cellHeader.myModel = channelModel 

                    
                    break
                case "my_capital":
                    
                    self.cellHeader.subTitleLabel.text = "查看全部资产"
                    break
                case "set":
                    channelModel.judge = false
                    self.cellHeader.imageView.image = UIImage(named:"icon_set up")
                    break
                case "help":
                    channelModel.judge = false
                    self.cellHeader.imageView.image = UIImage(named:"icon_help")
                                
                    break
                case "member_club":
                    
                    self.cellHeader.imageView.image = UIImage(named:"icon_To evaluate")
                    break
                default:
                    break
                }

            }
            
            
           
            
            self.setNeedsLayout()
            self.layoutIfNeeded()
        }
    }
    
    
    
    let cellHeader  = PTableCellHeader()
    let cellBody = PTableCellBody()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?){
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = UITableViewCellSelectionStyle.none
        self.contentView.backgroundColor = BackGrayColor  //UIColor.lightGray//
        self.contentView.addSubview(cellHeader)
        cellHeader.addTarget(self, action:#selector(cellHeaderClick(sender:)) , for:UIControlEvents.touchUpInside)

        self.contentView.addSubview(cellBody)
        cellBody.actionDelegate = self
    }
    //MARK: customDelegate
    func performAction(model: BaseModel) {
        self.subViewDelegate?.performAction(model: model)
    }
//   @objc  func mmclick (sender : BaseControl) -> () {
//        
//    }
    @objc func cellHeaderClick(sender : PTableCellHeader) {//header 用key标识 , 子控件用actionkey
        self.subViewDelegate?.performAction(model: sender.cellHeaderModel)
        mylog(sender.cellHeaderModel.key)
        mylog(sender.cellHeaderModel.actionkey)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let headerX : CGFloat = 0
        let headerY : CGFloat = 0
        let headerW : CGFloat = self.bounds.size.width
        let headerH : CGFloat = 44.0
        
        self.cellHeader.frame = CGRect(x: headerX, y: headerY, width: headerW, height: headerH)
        
        
        if let items = channelModel.items{
            if items.count > 0 {
                self.cellBody.isHidden = false
                let toHeaderMargin : CGFloat = 1.0
                let bodyX : CGFloat = 0
                let bodyY : CGFloat =   headerH + toHeaderMargin
                let bodyW : CGFloat = self.bounds.size.width
                let bodyH : CGFloat = NavigationBarHeight
                self.cellBody.frame = CGRect(x: bodyX, y: bodyY, width: bodyW, height: bodyH)

            }else{
                self.cellBody.isHidden = true
            }
            
        }else{
            self.cellBody.isHidden = true
        }
        
    }

}
