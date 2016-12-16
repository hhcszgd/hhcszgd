//
//  UIVIew_extention.swift
//  zjlao
//
//  Created by WY on 16/10/16.
//  Copyright © 2016年 WY. All rights reserved.
//

import Foundation
import UIKit
extension UIView {
   public func embellishView(redius : CGFloat)  {
        self.layer.cornerRadius = redius
        self.layer.masksToBounds = true
    }
}
