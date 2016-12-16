//
//  BaseTableView.swift
//  zjlao
//
//  Created by WY on 16/10/16.
//  Copyright © 2016年 WY. All rights reserved.
//

import UIKit

class BaseTableView: UITableView {
    override init(frame: CGRect, style: UITableViewStyle) {
        super.init(frame: frame, style: style)
//        self.setupBackgroundView()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
//    func setupBackgroundView(){
//        let backView = UIView()
//        backView.backgroundColor = UIColor.orange
//        self.backgroundView = backView
//        self.addObserver(self, forKeyPath: "contentOffset", options: [NSKeyValueObservingOptions.new , NSKeyValueObservingOptions.old], context: nil )
//        //        swh.frame = CGRect(x: 100, y: 10, width: 300, height:300)
//    }
//    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
//        guard let objAny  = object else {
//             super.observeValue(forKeyPath: keyPath, of: object, change: change, context: context)
//            return
//        }
//        guard let obj = objAny as? BaseTableView else {
//             super.observeValue(forKeyPath: keyPath, of: object, change: change, context: context)
//            return
//        }
//        if (obj == self /**_tableView*/  && keyPath == "contentOffset") {
////do sonething
////            mylog(keyPath)
////            mylog(object)
////            mylog("new  \(change?[NSKeyValueChangeKey.newKey])")
////            mylog("kind  \(change?[NSKeyValueChangeKey.kindKey])")
////            mylog("old  \(change?[NSKeyValueChangeKey.oldKey])")
////            mylog(context)
// 
////            guard  let offsetAny = change?[NSKeyValueChangeKey.newKey] else {
////                return
////            }
////            
////            guard  let offset = offsetAny as? CGPoint else {//转不成CGPoint格式 , 代替方法一 : 用 tableView.contentOffset(self.contentOffset)
////                return
////            }
//            let offset  = self.contentOffset
//            
//            self.operationSometringAboutContentOffset(contentOffset : offset)
//        
//        }else if (obj == self /**_tableView*/  && keyPath == "xxxxxx"){
//            //doSomethingElse
//        }else {
//            super.observeValue(forKeyPath: keyPath, of: object, change: change, context: context)
//        }
//        
//
//    }
//    func operationSometringAboutContentOffset(contentOffset : CGPoint) {
//
//        if contentOffset.y < 0  && contentOffset.y > -77 {// 下拉了0~100 个点(滑到某个点 就提示松手可刷新)
//            mylog("下拉")
//        }else if (contentOffset.y < -77 ){
//            mylog("松手刷新")
//            if self.isDragging {
//                mylog("拖拽中")
//            }else{
//                mylog("松手了")
//                UIView.animate(withDuration: 0.5, animations: { 
//                     self.contentInset = UIEdgeInsets(top:  44, left: 0, bottom: 0, right: 0)
//                    }, completion: { (bool) in
//                        UIView.animate(withDuration: 0.5 , animations: {
//                        
//                            self.contentInset = UIEdgeInsets(top:  0, left: 0, bottom: 0, right: 0)
//                        })
//                })
//
//            }
//        }else if (contentOffset.y > self.contentSize.height - self.bounds.size.height + 77){
//            mylog("有时候放手,意味着获取得更多")
//            if self.isDragging {
//                mylog("拖拽中")
//            }else{
//                mylog("松手了")
//                UIView.animate(withDuration: 0.5, animations: {
//                    self.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 44, right: 0)
//                    }, completion: { (bool) in
//                        UIView.animate(withDuration: 0.5 , animations: {
//                            self.contentInset = UIEdgeInsets(top:  0, left: 0, bottom: 0, right: 0)
//                        })
//                })
//
//            }
//        }else if (contentOffset.y > (self.contentSize.height - self.bounds.size.height )){//划到底了 (滑到某个点 就提示松手可加载,再让tableView的contentInset偏离一段距离 , 加载完回调取消contentInset赋值)
//            mylog("上拉")
//            
//        
//        }
//    }
//    deinit {
//        self.removeObserver(self, forKeyPath: "contentOffset", context: nil)
//        
//    }


}
