//
//  GDRefreshGifHeader.swift
//  zjlao
//
//  Created by WY on 16/12/15.
//  Copyright © 2016年 com.16lao.zjlao. All rights reserved.
//

import UIKit
import MJRefresh
class GDRefreshGifHeader: MJRefreshGifHeader {
    //MARK:refresh  这个控件的高度是根据图片的像素数类定的 , 像素限制在40个点(注意2X和3X)
    override func prepare() {
        mylog(self )
        super.prepare()
        mylog(self )
        //设置控件的高度
        self.mj_h = 70.0
        self.backgroundColor = UIColor.randomColor()
        self.stateLabel.backgroundColor = UIColor.randomColor()
        self.gifView.backgroundColor = UIColor.randomColor()
        //提示
        self.stateLabel.textColor = MainTitleColor
        self.stateLabel.font = UIFont.boldSystemFont(ofSize: 10)
        self.stateLabel.textAlignment = NSTextAlignment.center
        //图片
       gifView.contentMode = UIViewContentMode.scaleAspectFit//在这设置没用


        
    }
    //设置子控件的位置和尺寸
    override func placeSubviews() {
        mylog(self )
        super.placeSubviews()
        self.setupFrame()
    }
    func setupFrame()  {
        
        let margin : CGFloat = 5.0
        self.stateLabel.sizeToFit()
        let logoW : CGFloat = 40.0
        let logoH : CGFloat = 40.0
        let logoX : CGFloat = (self.bounds.size.width-logoW)/2
        let logoY : CGFloat = margin
        let labelW : CGFloat = self.stateLabel.bounds.size.width
        let labelH : CGFloat = self.stateLabel.bounds.size.height
        let labelX : CGFloat = (self.bounds.size.width - self.stateLabel.bounds.size.width)/2
//        let labelY : CGFloat = self.gifView.frame.maxY+margin
        let labelY : CGFloat = logoH + logoY + margin

        self.gifView.frame = CGRect(x: logoX, y: logoY, width: logoW, height: logoH)
        self.stateLabel.frame = CGRect(x: labelX, y: labelY, width: labelW, height: labelH)
        gifView.contentMode = UIViewContentMode.scaleAspectFit
        
    }
    override  var state: MJRefreshState  {
        set{
            if (state == newValue) {return}
            super.state = newValue
            
            switch (state) {
                
            case MJRefreshState.idle:
                //                self.label.text = "下拉加载更多";
                self.stateLabel.text = GDLanguageManager.titleByKey(key: "pullDownRefresh");
                self.setupFrame()//貌似有必要了, 不然当状态为没有更多数据时 , 再手动设置状态为闲置状态时 , 没有加载图片
                
//                self.gifView.isHidden =  true
                break;
            case MJRefreshState.pulling:
                //                self.label.text = "松开立即刷新";
                self.stateLabel.text = GDLanguageManager.titleByKey(key: "unloosenRefresh");
                self.setupFrame()
//                self.gifView.isHidden = true
                break;
                
            case MJRefreshState.refreshing:
                //                self.label.text = "刷新中...";
                self.stateLabel.text = GDLanguageManager.titleByKey(key: "refreshing");
                self.setupFrame()
//                self.gifView.isHidden  = false
                break;
                
            case MJRefreshState.noMoreData:
                self.stateLabel.text = "";
                
                self.gifView.isHidden = true
                self.stateLabel.frame = self.bounds;
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
//        mylog("header拖拽比例\(self.pullingPercent)")
        mylog("header拖拽比例\(self.gifView.frame)")
//        if self.pullingPercent>0.5 {
//            gifView.image = UIImage(named: "bg_electric")
//        }else if self.pullingPercent>1.0{
//            gifView.image = UIImage(named: "bg_Direct selling")
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

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
