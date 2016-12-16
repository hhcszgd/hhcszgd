//
//  GDAlertView.swift
//  zjlao
//
//  Created by WY on 16/10/25.
//  Copyright © 2016年 WY. All rights reserved.
//

import UIKit
import MBProgressHUD
class GDAlertView: MBProgressHUD {
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

    class func networkLoading() -> GDAlertView  {
//        let pro  = GDAlertView.showAdded(to: UIApplication.shared.keyWindow!, animated: true)
        
//        if let window  = UIApplication.shared.keyWindow {
//            
//        }else{
//        
//        }
       let pro  =   GDAlertView.init(view: UIApplication.shared.keyWindow!)
        UIApplication.shared.keyWindow!.addSubview(pro)
        pro.graceTime = 2.0
//        pro.taskInProgress = true
//        pro.isHidden = true
//        pro.bezelView.backgroundColor = UIColor.clear//弹框部分的底色
        pro.mode = MBProgressHUDMode.indeterminate
//        pro.isSquare = false
//        pro.backgroundColor = UIColor.white//全屏白
        return pro
    }
    
//    func networkLoading()  {
//        let alert  = <#value#>
//        
//        self.show(animated: true)
//    }
    
    
    
    
    
   class func alert(_ message : String? ,image : UIImage? , time : Int , complateBlock : MBProgressHUDCompletionBlock? ) -> () {
        if message == nil && image == nil  { return }
    
        DispatchQueue.main.async {
                    let pro  = GDAlertView.showAdded(to: UIApplication.shared.keyWindow!, animated: true)
                    pro.bezelView.backgroundColor = UIColor.white//弹框部分的底色
                    pro.mode = MBProgressHUDMode.customView
                    pro.hide(animated: true, afterDelay: TimeInterval(time))
                    if message != nil {
                        pro.detailsLabel.text = message
                    }
                    if image != nil  {
                        pro.customView = UIImageView(image:image )
                    }
                    pro.completionBlock = {
                        if complateBlock != nil {
                            complateBlock!()
                        }
                    }
          };
    //            pro.backgroundView.backgroundColor = UIColor.white//全屏白
    //            pro.backgroundColor = UIColor.white//全屏白
    }
    
    
    
    func gdShow() {
        DispatchQueue.main.async {
            self.show(animated: true)
          };
    }
    func gdHide() {
        DispatchQueue.main.async {
            self.hide(animated: true)
            
          };
    }
    
    
    deinit {
        mylog("弹框销毁了")
    }
}
