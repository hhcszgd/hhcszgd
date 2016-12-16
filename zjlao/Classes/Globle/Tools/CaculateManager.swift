//
//  CaculateManager.swift
//  mh824appWithSwift
//
//  Created by wangyuanfei on 16/9/16.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//

import UIKit

class CaculateManager: NSObject {
    
    
// private   class func  caculateRowHeight(itemsCount : Int , itemHeight : CGFloat , columnCount : Int , topHeight : CGFloat , bottomHeight : CGFloat , topMargin : CGFloat , bottomMargin : CGFloat ) -> CGFloat {
//
//
//            if itemsCount > 0  {
//                return topHeight + bottomHeight + topMargin + bottomMargin  + self.caculateItemsHeight(itemsCount: itemsCount,itemHeight :itemHeight , columnCount: columnCount)
//            }else {
//                return topHeight + bottomHeight + topMargin + bottomMargin + itemHeight
//            }
//    }
    
    
  private class  func caculateItemsHeight(itemsCount:Int ,itemHeight : CGFloat , columnCount:Int ) -> CGFloat {
        if  itemsCount % columnCount == 0 {
            let rows =  itemsCount / columnCount
            return CGFloat (rows + 1) * itemHeight
        }else {
             let rows =  itemsCount / columnCount
            return CGFloat (rows) * itemHeight
        }
    }
    
    
    
    class func newCaculateRowHeight(caculateModel : CaculateModel) -> (CGFloat){
        var   result : CGFloat = 0.0
        if caculateModel.itemCount == 0  {
            result  = caculateModel.topMargin  + caculateModel.headerHeight + caculateModel.toHeaderMargin + caculateModel.toFooterMargin + caculateModel.footerHeight + caculateModel.bottomMargin
        }else if caculateModel.itemCount == 1 {
            result  = caculateModel.topMargin  + caculateModel.headerHeight + caculateModel.toHeaderMargin + caculateModel.itemHeight + caculateModel.toFooterMargin + caculateModel.footerHeight + caculateModel.bottomMargin
            
        }else if caculateModel.itemCount > 1{
            let itemsTotalHeight = self.caculateItemsHeight(itemsCount: caculateModel.itemCount, itemHeight: caculateModel.itemHeight, columnCount: caculateModel.itemColumnCount)
            result  = caculateModel.topMargin  + caculateModel.headerHeight + caculateModel.toHeaderMargin + caculateModel.toFooterMargin + caculateModel.footerHeight + caculateModel.bottomMargin + itemsTotalHeight
        }
        return  result
    }
    
}


class CaculateModel: NSObject {
    var topMargin : CGFloat = 0
    var headerHeight : CGFloat  = 0
    var toHeaderMargin : CGFloat = 0
    var itemHeight : CGFloat = 0
    var itemCount : NSInteger = 0
    var itemMargin : CGFloat = 0
    var itemColumnCount : NSInteger = 1
    var toFooterMargin : CGFloat = 0
    var footerHeight : CGFloat = 0
    var bottomMargin : CGFloat = 0

    
}
