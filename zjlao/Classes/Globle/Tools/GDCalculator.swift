//
//  GDCalculator.swift
//  zjlao
//
//  Created by WY on 16/11/5.
//  Copyright © 2016年 com.16lao.zjlao. All rights reserved.
//

import UIKit

class GDCalculator: NSObject {
   class func GDAdaptation(_ paramater : CGFloat) -> CGFloat {
        var para = paramater
        let screenWidth = UIScreen.main.bounds.size.width
        if screenWidth >= 1024 { //ipadPro(12.9)
            para += 12
        }else if(screenWidth >= 768.0){//2X的ipadPro2X(7.9) ipadAir系列 , 1X的7.9寸ipad和mini
            para += 8
        }else if(screenWidth >= 414){//6plus , 7plus
            para += 4
        }else if(screenWidth >= 375){//6 , 7不变
            
        }else if(screenWidth >= 320){//5,5s,5c不变
            
        }else{//
            
        }
        return para
    }
}
/**
 
 */
