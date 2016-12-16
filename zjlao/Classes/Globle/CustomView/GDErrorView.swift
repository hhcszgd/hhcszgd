//
//  GDErrorView.swift
//  zjlao
//
//  Created by WY on 16/10/25.
//  Copyright © 2016年 WY. All rights reserved.
//

import UIKit

class GDErrorView: BaseControl {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.imageView = UIImageView(image: UIImage(named: "bg_icon_ff"))
        self.addSubview(self.imageView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        self.imageView.center = self.center
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
