//
//  UIButton+Extension.swift
//  Weibo
//
//  Created by apple on 15/11/29.
//  Copyright © 2015年 mac. All rights reserved.
//

import UIKit

/**
*  给UIButton  扩展构造方法
*/

extension UIButton {
    
    //扩展构造方法  
    // 分类中不能够添加指定的构造方法 
    //不能够添加存储型属性  只能够添加只读属性 和 方法  
    //convenience  只能够调用 本类的构造方法  针对指定的构造函数 进行额外操作(扩展)
    convenience init(title: String,backImage: String?,color: UIColor,fontSize: CGFloat = 15,isNeedHighlighted: Bool = false,imageName: String? = nil){
        //便利的构造方法 可以访问self对象 
        self.init()
    
        setTitle(title, for: UIControlState())
        if backImage != nil {
            setBackgroundImage(UIImage(named: backImage!), for: UIControlState())
            
            if isNeedHighlighted  {
                setBackgroundImage(UIImage(named: backImage! + "_highlighted"), for: UIControlState())
            }
        }
        
       
        if imageName != nil {
            setImage(UIImage(named: imageName!), for: UIControlState())
        }
        setTitleColor(color, for: UIControlState())
        titleLabel?.font = UIFont.systemFont(ofSize: fontSize)

        sizeToFit()
    }
    
    
    
    /**
     button便利构造方法
     
     - parameter imageName: 按钮的图片
     - parameter backImage: 按钮的背景图片
     
     - returns: 实例化的按钮
     */
    convenience init(imageName: String, backImage: String?){
        //便利的构造方法 可以访问self对象
        self.init()
        if backImage != nil {
            setBackgroundImage(UIImage(named: backImage!), for: UIControlState())
            setBackgroundImage(UIImage(named: backImage! + "_highlighted"), for: .highlighted)
        }
        
  
        setImage(UIImage(named: imageName), for: UIControlState())
        setImage(UIImage(named: imageName + "_highlighted"), for: .highlighted)
   
        
        sizeToFit()
    }
}
