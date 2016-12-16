//
//  PTableHeaderSub.swift
//  mh824appWithSwift
//
//  Created by wangyuanfei on 16/9/12.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
/*tableView的header里面的子控件**/

import UIKit

class PTableHeaderSub: BaseControl {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

    var model  = ProfileSubModel(dict:nil) {
        didSet{
            if model.number != nil {
                self.titleLabel.text = "\(model.number)"
            }else if model.number == nil && model.localImgName == nil  {
                self.titleLabel.text = "0"
            }else if model.number == nil && model.localImgName != nil{
                self.imageView.image = UIImage(named: model.localImgName!)
            }
            
//            self.topTitleLabel.text = model.number == nil ? "0" : "\(model.number)"
//            self.topTitleLabel.text = "\(model.number)"
            self.subTitleLabel.text = model.name
//            mylog(model.name)
//            mylog(bottomTitleLabel.text)
//            self.setNeedsLayout()
//            self.layoutIfNeeded()
        }
        
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.clear
        self.addSubview(self.titleLabel)
        self.addSubview(self.imageView)
        self.imageView.contentMode = UIViewContentMode.scaleAspectFit
        self.titleLabel.textAlignment = NSTextAlignment.center
        self.titleLabel.font = UIFont.systemFont(ofSize: 14*SCALE)
        self.subTitleLabel.font = UIFont.systemFont(ofSize: 14*SCALE)
        self.titleLabel.textColor = UIColor.white
        self.subTitleLabel.textColor = UIColor.white
        self.subTitleLabel.textAlignment = NSTextAlignment.center
        self.addSubview(self.subTitleLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.titleLabel.frame = CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height/2)
        self.imageView.frame =  CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height/2)

        self.subTitleLabel.frame = CGRect(x: 0, y: self.bounds.size.height/2, width: self.bounds.size.width, height: self.bounds.size.height/2)
        
    }
    
}
