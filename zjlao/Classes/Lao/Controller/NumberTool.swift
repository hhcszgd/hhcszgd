//
//  NumberTool.swift
//  mh824appWithSwift
//
//  Created by wangyuanfei on 16/9/5.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//

import UIKit

class NumberTool: NSObject {

    var timer : Timer?
    var i = 0
    var type = "+"
    
    var theReturnType = ""
    var callback :  ((_ i : Int ) -> ())?
    
    override init() {
        super.init()
        timer =  Timer.scheduledTimer(timeInterval: 0.5, target: self , selector: #selector(repeatChangeValue), userInfo: nil, repeats: true )
        RunLoop.current.add(timer!, forMode: RunLoopMode.commonModes)
        
    }
    
    func repeatChangeValue() -> () {
        
        theReturnType = self.returnType(i)
        if theReturnType == "+" {
            i += 1
            type = "+"
        }else if theReturnType == "-"{
            i -= 1
            type = "-"
        }else if theReturnType == "."{
            if type == "+" {
                i += 1
            }
            if type == "-" {
                i -= 1
            }
        }
        
        self.callback!(i)
        print(i)
        
    }

    func returnType (_ i : Int) -> String  {
        if i<=0 {
            return "+"
        } else if i>=10 {
            return "-"
        }
        return "."
    }
    
    
    func test () -> () {
        NumberTool.init().callback = {(i) in
            print("打印1~10~1~10~1........\(i)")
        }
    }
}
