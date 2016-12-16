//
//  ImgTxtView.swift
//  mh824appWithSwift
//
//  Created by wangyuanfei on 16/9/12.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
/*先看width 和height 哪个小 , 哪个小就以哪个为基准*/

import UIKit

class ImgTxtView: BaseControl {

    /*
     lazy var titleLabel = UILabel()//底部标题
     lazy var subTitleLabel = UILabel()//头部数量标题
     lazy var imageView = UIImageView()//图片视图
     lazy var additionalLabel = UILabel()//额外的文字标题(bedge数量)
     */
    
    let container = UIView()
    
    var model  = ProfileSubModel(dict:nil) {
        didSet{
            //当图片为网络图片链接时
            //当图片不是网络链接时
            if model.localImgName != nil {
                if let imgName = model.localImgName {
                    self.imageView.image = UIImage(named: imgName)
                }
            }else{
//                self.imageView.sd_setImage(with: imgStrConvertToUrl("服务器图片地址"))//
            }
            //            self.topTitleLabel.text = "\(model.number)"
            self.subTitleLabel.text = model.name
            //            self.setNeedsLayout()
            //            self.layoutIfNeeded()
        }
        
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
//        self.backgroundColor = UIColor.randomColor()
        self.addSubview(self.container)
        self.container.addSubview(self.imageView)
        self.imageView.contentMode = UIViewContentMode.scaleAspectFit
       
        self.subTitleLabel.font = UIFont.systemFont(ofSize: 14*SCALE)
        self.subTitleLabel.textColor = UIColor.white
        self.subTitleLabel.textAlignment = NSTextAlignment.center
        self.container.addSubview(self.subTitleLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let  selfW = self.bounds.size.width
        let  selfH = self.bounds.size.height
        
        var containerW : CGFloat = 0.0
        var  containerH : CGFloat = 0.0
        if selfW < selfH {
             containerW = selfW
             containerH = containerW
        }else {
        
             containerH = selfH
             containerW = containerH
        }
        self.container.bounds = CGRect(x: 0, y: 0, width: containerW, height: containerH)
        self.container.center = CGPoint(x: selfW/2, y: selfH/2)
        
//        self.bottomTitleLabel.sizeToFit()
        let margin : CGFloat = 5.0 ;
        let bottomTitleW =  selfW
        let bottomTitleH = self.subTitleLabel.font.lineHeight
        let bottomTitleX : CGFloat = 0.0 ;
        let bottomTitleY = selfH - bottomTitleH - margin
        
        let leftH = self.container.bounds.size.height - margin * 3 - bottomTitleH //conainer的剩余高度
        
        let imageViewH = leftH
        let imageViewW = imageViewH
        let imageViewX = margin
        let imageViewY = margin
        
        self.imageView.frame = CGRect(x: 0, y: 0, width: imageViewW, height: imageViewH)
        self.imageView.center = CGPoint(x: self.container.bounds.size.width/2, y: imageViewY + imageViewH/2)
        self.subTitleLabel.bounds = CGRect(x: 0, y: 0, width: bottomTitleW, height: bottomTitleH)
        self.subTitleLabel.center = CGPoint(x: self.container.bounds.size.width/2, y: bottomTitleY + bottomTitleH/2)
        
    }

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
