//
//  GDFont.swift
//  zjlao
//
//  Created by WY on 16/11/5.
//  Copyright © 2016年 com.16lao.zjlao. All rights reserved.
//

import UIKit

class GDFont: UIFont {
    
    override class func systemFont(ofSize : CGFloat ) -> UIFont{
        var size = ofSize
        let screenWidth =  UIScreen.main.bounds.size.width
        if screenWidth >= 1024 { //ipadPro(12.9)
            size += 6
        }else if(screenWidth >= 768.0){//2X的ipadPro2X(7.9) ipadAir系列 , 1X的7.9寸ipad和mini
            size += 4
        }else if(screenWidth >= 414){//6plus , 7plus
            size += 2
        }else if(screenWidth >= 375){//6 , 7不变
            
        }else if(screenWidth >= 320){//5,5s,5c不变
            
        }else{//
            
        }
       return super.systemFont(ofSize: size)
    
    }
}

/**设备尺寸
 6和7  2X:           (375.0, 667.0)
 6p和7p  3X:         (414.0, 736.0)
 se和5和5s和5c  2X:   (320.0, 568.0)
 ipadPro(12.9)2X:  (1024.0, 1366.0)
 ipadPro(9.7)和ipadAir系列2X:   (768.0, 1024.0)
 ipadRetina(7.9寸设备)1X: (768.0, 1024.0)
 */
