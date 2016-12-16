//
//  GDRefreshHeader.swift
//  zjlao
//
//  Created by WY on 16/10/24.
//  Copyright © 2016年 WY. All rights reserved.
//

import UIKit
import MJRefresh
class GDRefreshHeader: MJRefreshHeader {

    let label  = UILabel(frame: CGRect.zero)
    let logo = UIImageView(frame: CGRect.zero)
    
    /*
     // Only override draw() if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func draw(_ rect: CGRect) {
     // Drawing code
     }
     */
    override func prepare() {
        super.prepare()
        //设置控件的高度
        self.backgroundColor = UIColor.randomColor()
        self.label.backgroundColor = UIColor.randomColor()
        self.logo.backgroundColor = UIColor.randomColor()
        self.mj_h = 70.0
        //提示
        label.textColor = MainTitleColor
        label.font = UIFont.boldSystemFont(ofSize: 10)
        label.textAlignment = NSTextAlignment.center
        self.addSubview(label)
        //图片
        self.addSubview(logo)
        logo.image = UIImage.sd_animatedGIFNamed("loading")
        logo.contentMode = UIViewContentMode.scaleAspectFit
        
    }
    //设置子控件的位置和尺寸
    override func placeSubviews() {
        super.placeSubviews()
        self.setupFrame()
    }
    func setupFrame()  {

        let margin : CGFloat = 5.0
        self.label.sizeToFit()
        let logoW : CGFloat = 40.0
        let logoH : CGFloat = 40.0
        let logoX : CGFloat = (self.bounds.size.width-logoW)/2
        let logoY : CGFloat = margin
        let labelW : CGFloat = self.label.bounds.size.width
        let labelH : CGFloat = self.label.bounds.size.height
        let labelX : CGFloat = (self.bounds.size.width - self.label.bounds.size.width)/2
        let labelY : CGFloat = self.logo.frame.maxY+margin
        self.logo.frame = CGRect(x: logoX, y: logoY, width: logoW, height: logoH)
        self.label.frame = CGRect(x: labelX, y: labelY, width: labelW, height: labelH)
        
    }
    override  var state: MJRefreshState  {
        set{
            if (state == newValue) {return}
            super.state = newValue
            
            switch (state) {
                
            case MJRefreshState.idle:
//                self.label.text = "下拉加载更多";
                self.label.text = GDLanguageManager.titleByKey(key: "pullDownRefresh");
                self.setupFrame()//貌似有必要了, 不然当状态为没有更多数据时 , 再手动设置状态为闲置状态时 , 没有加载图片

//                self.logo.isHidden =  true
                break;
            case MJRefreshState.pulling:
//                self.label.text = "松开立即刷新";
                self.label.text = GDLanguageManager.titleByKey(key: "unloosenRefresh");
                self.setupFrame()
//                self.logo.isHidden = true
                break;

            case MJRefreshState.refreshing:
//                self.label.text = "刷新中...";
                self.label.text = GDLanguageManager.titleByKey(key: "refreshing");
                self.setupFrame()
//                self.logo.isHidden  = false
                break;
                
            case MJRefreshState.noMoreData:
                self.label.text = "";
                
                self.logo.isHidden = true
                self.label.frame = self.bounds;
                break;
            default:
                break;
            }
            
            
        }
        get{
            return super.state
        }
        
    }
    
    
    
    //MARK: 监听scrollView的contentOffset改变
    
    override func scrollViewContentOffsetDidChange(_ change: [AnyHashable : Any]!) {
        super.scrollViewContentOffsetDidChange(change)
        mylog("header拖拽比例\(self.pullingPercent)")
//        if self.pullingPercent>0.5 {
//            logo.image = UIImage(named: "bg_electric")
//        }else if self.pullingPercent>0.6{
//            logo.image = UIImage(named: "bg_female baby")
//        }else if self.pullingPercent>0.7{
//            logo.image = UIImage(named: "bg_coupon")
//        }else if self.pullingPercent>0.8{
//            logo.image = UIImage(named: "bg_franchise")
//        }else if self.pullingPercent>0.9{
//            logo.image = UIImage(named: "bg_collocation")
//        }else if self.pullingPercent>1.0{
//            logo.image = UIImage(named: "bg_Direct selling")
//        }
    }
    
    //MARK: 监听scrollView的contentSize改变
    override func scrollViewContentSizeDidChange(_ change: [AnyHashable : Any]!) {
        super.scrollViewContentSizeDidChange(change)
    }
    
    //MARK: 监听scrollView的拖拽状态改变
    
    //    override func scrollViewPanStateDidChange(_ change: [AnyHashable : Any]!) {
    //        super.scrollViewPanStateDidChange(change)
    //    }
    //MARK: 监听拖拽比例（控件被拖部分占footer的比例）
    override var pullingPercent: CGFloat {//当值在0.0~1.0做数据操作
        set{
            super.pullingPercent = newValue
//            mylog("\n\n\(self.pullingPercent)\n\n")
        }
        get{
            return super.pullingPercent
        }
    }
    

}
