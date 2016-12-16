//
//  GDRefreshBackFooter.swift
//  zjlao
//
//  Created by WY on 16/10/24.
//  Copyright © 2016年 WY. All rights reserved.
//

import UIKit
import MJRefresh
class GDRefreshBackFooter: MJRefreshBackFooter {
    
    let label  = UILabel(frame: CGRect.zero)
    let logo = UIImageView(frame: CGRect.zero)
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    override func prepare() {//1
        super.prepare()
        self.backgroundColor = UIColor.randomColor()
        self.label.backgroundColor = UIColor.randomColor()
        self.logo.backgroundColor = UIColor.randomColor()
        //设置控件的高度
        self.mj_h = 66.0
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
    override func placeSubviews() {//4//6/3
        super.placeSubviews()
        self.setupFrame()
    }
    func setupFrame()  {//3//5//7/2/4
        /**
         CGSize  labelSize =  [self.label.text sizeWithFont:self.label.font];
         CGFloat margin = 5;
         CGFloat logoW = 44 ;
         CGFloat logoH = 30;
         self.logo.frame=CGRectMake((self.bounds.size.width-logoW)/2, margin, logoW, logoH);
         self.label.frame = CGRectMake((self.bounds.size.width-labelSize.width)/2, CGRectGetMaxY(self.logo.frame)+margin, labelSize.width, labelSize.height);
         
         */
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
        self.label.frame =  self.state == MJRefreshState.noMoreData ? self.bounds :  CGRect(x: labelX, y: labelY, width: labelW, height: labelH)
        self.logo.frame = CGRect(x: logoX, y: logoY, width: logoW, height: logoH)
    }
    
    override func scrollViewPanStateDidChange(_ change: [AnyHashable : Any]!) {

        
    }
    
    override  var state: MJRefreshState  {//2/1
        set{
            if (state == newValue) {return}
            super.state = newValue
            
            switch (state) {
                
            case MJRefreshState.idle:
//                self.label.text = "上拉加载更多";
                self.label.text = GDLanguageManager.titleByKey(key: "pullUpLoad")
                //            [self setupFrame];//不必
                self.setupFrame()//貌似有必要了, 不然当状态为没有更多数据时 , 再手动设置状态为闲置状态时 , 没有加载图片
//                [self.loading stopAnimating];
//                [self.s setOn:NO animated:YES];
                self.logo.isHidden =  true
                break;
            case MJRefreshState.pulling:
//                self.label.text = "松开立即加载";
                self.label.text = GDLanguageManager.titleByKey(key: "unloosenLoad");
                self.setupFrame()
                self.logo.isHidden = true
                break;
                
                //        case MJRefreshStateWillRefresh:
                //            [self.s setOn:YES animated:YES];
                //            self.label.text = @"即将刷新刷新";
                //            [self setupFrame];
                //            [self.loading startAnimating];
                //            self.logo.hidden=NO;
                //            break;
                
                
            case MJRefreshState.refreshing:
//                self.label.text = "正在加载...";

                self.label.text = GDLanguageManager.titleByKey(key: "loading");
                self.setupFrame()
                self.logo.isHidden  = false
                break;
                
                
                
            case MJRefreshState.noMoreData:
//                self.label.text = "-- 亲,你看完了 --";

                self.label.text = GDLanguageManager.titleByKey(key: "noMoreData");
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
        mylog("footer拖拽比例\(self.pullingPercent)")
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
