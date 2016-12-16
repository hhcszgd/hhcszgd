//
//  String+Regex.swift
//  正则表达式
//
//  Created by apple on 15/12/6.
//  Copyright © 2015年 mac. All rights reserved.
//

import Foundation

extension String {
    
    //元祖类型
    func linkText() -> (url: String?,text: String?) {
        
        //匹配方法
        let pattern = "<a href=\"(.*?)\" .*?>(.*?)</a>"
        let regex = try! NSRegularExpression(pattern: pattern, options: [])
        //调用 正则表达式的核心方法之一
        guard let result = regex.firstMatch(in: self, options: [], range: NSRange(location: 0, length:characters.count)) else {
            print("匹配方案有误")
            return (nil,nil)
        }
   
        let range1 = result.rangeAt(1)
        let subStr1 = (self as NSString).substring(with: range1)
        
        let range2 = result.rangeAt(2)
        let subStr2 = (self as NSString).substring(with: range2)
        
        
        return (subStr1,subStr2)
    }
    
    

    //MARK: -MD5算法
    func md5() ->String!{
        let str = self.cString(using: String.Encoding.utf8)
        let strLen = CUnsignedInt(self.lengthOfBytes(using: String.Encoding.utf8))
        let digestLen = Int(CC_MD5_DIGEST_LENGTH)//如果报错就在bridgeing-header中加上#import <CommonCrypto/CommonDigest.h>

        let result = UnsafeMutablePointer<CUnsignedChar>.allocate(capacity: digestLen)
        CC_MD5(str!, strLen, result)
        let hash = NSMutableString()
        for i in 0 ..< digestLen {
            hash.appendFormat("%02x", result[i])
        }
        result.deinitialize()
        return String(format: hash as String)
    }
    
    
    //MARK: Unicode转中文
        var unicodeStr:String {
            let tempStr1 = self.replacingOccurrences(of: "\\u", with: "\\U")
            let tempStr2 = tempStr1.replacingOccurrences(of: "\"", with: "\\\"")
            let tempStr3 = ("\"" + tempStr2) + "\""
            let tempData = tempStr3.data(using: String.Encoding.utf8)
            var returnStr:String = ""
            do {
                returnStr = try PropertyListSerialization.propertyList(from: tempData!, options: PropertyListSerialization.MutabilityOptions(), format: nil) as! String
            } catch {
                print(error)
            }
            return returnStr.replacingOccurrences(of: "\\r\\n", with: "\n")
        }
    
}
