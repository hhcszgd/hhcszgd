
//
//  UIView+ViewController.swift
//  Weibo
//
//  Created by apple on 16/11/2.
//  Copyright © 2015年 mac. All rights reserved.
//

import UIKit
/**
*  将 UIView 及其子类的响应者链条中的 视图控制器获取到
*/

extension UIView {
    
    func navController() -> UINavigationController? {
        //遍历响应者链条 获取导航视图控制器
        //获取视图的下一个响应者
        
        var next = self.next
        
        repeat {
            if let nextObj = next as? UINavigationController {
                return nextObj
            }
            //获取下一个响应者的下一个响应者
            next = next?.next
        
        } while (next != nil)
        
        
        return nil
    }
}
