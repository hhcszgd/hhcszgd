//
//  TabBarVCAnimat.swift
//  zjlao
//
//  Created by WY on 16/11/9.
//  Copyright © 2016年 com.16lao.zjlao. All rights reserved.
//

import UIKit

class TabBarVCAnimat: NSObject , UIViewControllerAnimatedTransitioning {
    public func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval{
        return 0.1
    }
    
    // This method can only  be a nop if the transition is interactive and not a percentDriven interactive transition.
    public func animateTransition(using transitionContext: UIViewControllerContextTransitioning){
        //目的ViewController
        
        let  toViewController : UIViewController = transitionContext.viewController(forKey:  UITransitionContextViewControllerKey.to)!
        
        //起始ViewController
        
        let fromViewController : UIViewController  = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from)!
        
        var fromX : CGFloat = 0.0
        var toX  : CGFloat = 0.0
        if fromViewController.isKind(of: HomeVaviVC.self) {
            fromX = -GDDevice.width
            toX = GDDevice.width
        }else if (fromViewController.isKind(of: ClassifyNaviVC.self)){
            if toViewController.isKind(of: HomeVaviVC.self) {
                fromX = GDDevice.width
                toX = -GDDevice.width
            }else{
                fromX = -GDDevice.width
                toX = GDDevice.width
            }
        }else if (fromViewController.isKind(of: LaoNaviVC.self)){
            if toViewController.isKind(of: HomeVaviVC.self) || toViewController.isKind(of: ClassifyNaviVC.self) {
                fromX = GDDevice.width
                toX = -GDDevice.width
            }else{
                fromX = -GDDevice.width
                toX = GDDevice.width
            }
        }else if (fromViewController.isKind(of: ShopCarNaviVC.self)){
            if toViewController.isKind(of: ProfileNaviVC.self) {
                fromX = -GDDevice.width
                toX = GDDevice.width
            }else{
                fromX = GDDevice.width
                toX = -GDDevice.width
            }
        }else if (fromViewController.isKind(of: ProfileNaviVC.self)){
            fromX = GDDevice.width
            toX = -GDDevice.width
        }
        
        
        mylog(fromViewController)
        mylog(toViewController)
        //添加toView到上下文
        transitionContext.containerView.insertSubview(toViewController.view, belowSubview: fromViewController.view)
        //自定义动画
        toViewController.view.transform = CGAffineTransform.init(translationX: toX, y: 0)
//        toViewController.view.transform = CGAffineTransformMakeTranslation(0, -568);
        UIView.animate(withDuration: self.transitionDuration(using: transitionContext), /*delay: 0, usingSpringWithDamping: 0.55, initialSpringVelocity: 1.0 / 0.55, options: UIViewAnimationOptions.allowAnimatedContent,*/ animations: {
            
            fromViewController.view.transform = CGAffineTransform.init(translationX: fromX, y: 0)
            toViewController.view.transform = CGAffineTransform.identity
        }) { (finished) in
            fromViewController.view.transform = CGAffineTransform.identity
            // 声明过渡结束时调用 completeTransition: 这个方法
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
            
        }

    }

}
