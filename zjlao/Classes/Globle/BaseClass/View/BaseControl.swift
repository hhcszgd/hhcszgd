//
//  BaseControl.swift
//  mh824appWithSwift
//
//  Created by wangyuanfei on 16/9/12.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//

import UIKit

class BaseControl: UIControl {

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.white
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
//    var myModel : BaseControlModel?
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
/*
     func boundingRect(with size: CGSize, options: NSStringDrawingOptions = [], attributes: [String : Any]? = nil, context: NSStringDrawingContext?) -> CGRect
     */
    lazy var titleLabel = UILabel()
    lazy var subTitleLabel = UILabel()
    lazy var additionalLabel = UILabel()
    
    
    lazy var imageView = UIImageView()
    lazy var subImageView = UIImageView()
    lazy var additionalImageView = UIImageView()
    lazy var backImageView = UIImageView()
    
    lazy var customView = UIView()
    
    lazy var textField = UITextField()
    

}
