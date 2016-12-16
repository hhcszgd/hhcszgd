//
//  UILabel+Extension.swift
//  Weibo
//
//  Created by apple on 15/11/29.
//  Copyright © 2015年 mac. All rights reserved.
//

import UIKit


extension UILabel {
    
    //便利的构造函数  不能和指定的构造函数重名
    convenience init(title: String,color: UIColor = UIColor.darkGray,fontSize: CGFloat,margin: CGFloat = 0) {
        self.init()
        
        text = title
        textColor = color
        font = UIFont.systemFont(ofSize: fontSize)
        //设置行数
        numberOfLines = 0
        //设置居中显示
        textAlignment = NSTextAlignment.center
        
        if margin > 0 {
            preferredMaxLayoutWidth = UIScreen.main.bounds.size.width - 2 * margin
            textAlignment = NSTextAlignment.left
        }
        //设置大小
        sizeToFit()
        
    }
}
