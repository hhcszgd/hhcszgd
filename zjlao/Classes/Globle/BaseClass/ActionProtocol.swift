//
//  ActionProtocol.swift
//  mh824appWithSwift
//
//  Created by wangyuanfei on 2016/9/28.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//

import UIKit

protocol ActionDelegate : NSObjectProtocol {
    func performAction( model : BaseModel)

}
@objc protocol QRViewDelegate : NSObjectProtocol{
   func qrView(view : QRView , didCompletedWithQRValue : String)
}

@objc  protocol AfterChangeLanguageKeyVCDidApear {
    func languageHadChanged() -> ()
}
