//
//  PTableCellBody.swift
//  mh824appWithSwift
//
//  Created by wangyuanfei on 2016/9/27.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
/*header下方的容器控件**/

import UIKit

class PTableCellBody: BaseView {

    var arr : [ProfileSubModel] = [ProfileSubModel](){
        didSet{
            for sub in self.subviews {
                sub.removeFromSuperview()
            }
            for itemModel in arr {
                itemModel.judge = true
               let item = PTableViewSub.init(frame: CGRect.zero)
                item.addTarget(self, action: #selector(click(sender:)), for: UIControlEvents.touchUpInside )
                //在这里手动给图片字段赋值
                guard let itemModelActionKey = itemModel.actionkey else {  continue  }
                switch itemModelActionKey {
                case "pay"://待付款
                    itemModel.localImgName = "icon_After payment"
                    break
                    
                case "ship"://待发货
                    itemModel.localImgName = "icon_To delivery"
                    break
                    
                case "receive"://待收货
                    
                    itemModel.localImgName = "icon_The receipt"
                    break
                    
                case "comment"://待评价
                    itemModel.localImgName = "icon_To evaluate"
                    break
                    
                case "over"://售后
                    itemModel.localImgName = "icon_return"
                    break
                    
                case "balance"://余额
                    itemModel.localImgName = "icon_balance"

                    break
                    
                case "coupons"://优惠券
                    itemModel.localImgName = "icon_coupon"
                    
                    break
                    
                case "coins"://积分
                    itemModel.localImgName = "icon_Lcoin"
                    
                    break
           
                    
                default: break
                    
                }
                item.model = itemModel
                self.addSubview(item)
            }
            
            
            self.setNeedsLayout()
            self.layoutIfNeeded()
        }
    }
    
  @objc  func click(sender : PTableViewSub) {
        self.actionDelegate?.performAction(model: sender.model)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
//        self.backgroundColor = UIColor.randomColor()
        let selfW = self.bounds.size.width
        let selfH = self.bounds.size.height
        let itemH = selfH
        let itemW : CGFloat = selfW / CGFloat(self.arr.count)
        for index in 0..<self.subviews.count {
           let item = self.subviews[index]
            item.frame = CGRect(x: CGFloat(index)*itemW, y: 0, width: itemW, height: itemH)
        }
        
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
