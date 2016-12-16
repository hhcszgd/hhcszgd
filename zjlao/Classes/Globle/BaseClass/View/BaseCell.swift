//
//  BaseCell.swift
//  mh824appWithSwift
//
//  Created by wangyuanfei on 16/9/20.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//

import UIKit

class BaseCell: UITableViewCell {
    
    weak var subViewDelegate : ActionDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
