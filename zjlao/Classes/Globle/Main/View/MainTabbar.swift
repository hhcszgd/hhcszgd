//
//  MainTabbar.swift
//  mh824appWithSwift
//
//  Created by wangyuanfei on 16/8/24.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//

import UIKit

class MainTabbar: UITabBar {

    
    static let share: MainTabbar = {
        let tempTabBar = MainTabbar()
        return tempTabBar
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
//        self.backgroundColor = randomColor
        self.tintColor = UIColor.orange
        self.barTintColor = UIColor.white
//        self.backgroundImage = UIImage(named: "tab_me_click")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
