//
//  NSDate+Extension.swift
//  时间处理
//
//  Created by apple on 15/12/6.
//  Copyright © 2015年 mac. All rights reserved.
//

import Foundation

extension Date {
    static func sinaDate(_ dateString: String) -> Date? {
        
        //转换日期字符串
        //1.实例化 formater 对象
        let df = DateFormatter()
        //2.指定格式
        df.dateFormat = "EEE MMM dd HH:mm:ss zzz yyyy"
        //设置本地化标示符  真机一定需要指定本地标示符  否则无法转化
        df.locale = Locale(identifier: "en")
        //3.转换为日期对象
        return df.date(from: dateString)

    }
    
    
    /*
    刚刚(一分钟内)
    X分钟前(一小时内)
    X小时前(当天)

    
    昨天 HH:mm(昨天)
    MM-dd HH:mm(一年内)
    yyyy-MM-dd HH:mm(更早期)
    NSCelander  日历对象  提供了非常丰富的日期处理函数
    */
    
    
    func fullDescription() -> String{
        
        //1.获取需要比较的时间和当前时间的间隔
        let cl = Calendar.current
        if cl.isDateInToday(self) {
            //当天
            let delta = Int(Date().timeIntervalSince(self))
            if delta < 60 {
                return "刚刚"
            } else if delta < 60 * 60 {
                return ("\(delta / 60)分钟前")
            } else {
                return ("\(delta / 3600)小时前")
            }
        } else {
            
            //实例化 日期格式化对象
            let df = DateFormatter()
            let comman = "HH:mm"
            if cl.isDateInYesterday(self) {
                //昨天
                df.dateFormat = "昨天 " + comman
            } else {
                //非昨天
                let result = (cl as NSCalendar).components(.year, from: self, to: Date(), options: [])
                if result.year == 0 {
                    //当年
                    df.dateFormat = "MM-dd " + comman
                } else {
                    //非当年
                    df.dateFormat = "yyyy-MM-dd " + comman
                }
            }
            
            let str = df.string(from: self)
            return str
        }
    }
}
