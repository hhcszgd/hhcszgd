//
//  AppDelegate.swift
//  mh824appWithSwift
//
//  Created by wangyuanfei on 16/10/24.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//

import UIKit
import CoreData

import MBProgressHUD
import UserNotifications
import AFNetworking
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate , AfterChangeLanguageKeyVCDidApear,UNUserNotificationCenterDelegate{
    
    //MARK:////////////////////////////////////属性相关//////////////////////////////////////////
    
    
    var window: UIWindow?
    
    
    
    //MARK:////////////////////////////////////XXXXXX相关//////////////////////////////////////////
    
    
    
    //MARK:////////////////////////////////////jpush相关//////////////////////////////////////////
    func setupJpush(launchOptions: [UIApplicationLaunchOptionsKey: Any]?)   {
        JPUSHService.setup(withOption: launchOptions, appKey: "97771ee938d1dc6354c0451d", channel: "WYAppStore", apsForProduction: true, advertisingIdentifier: nil)
        //        JPUSHService.setup(withOption: launchOptions, appKey: "97771ee938d1dc6354c0451d", channel: "WYAppStore", apsForProduction: true)
    }
    
    
    
    
    
    //MARK:////////////////////////////////////原生推送相关//////////////////////////////////////////
    func setupOriginPushNotification()  {
        if #available(iOS 10.0, *){
            let novifiCenter = UNUserNotificationCenter.current()
            novifiCenter.delegate = self
            novifiCenter.requestAuthorization(options: [UNAuthorizationOptions.alert , UNAuthorizationOptions.sound , UNAuthorizationOptions.badge], completionHandler: { (resule, error) in
                if(resule ){
                    mylog("成功")
                }else{
                    mylog("注册失败\(error)")
                }
            })
        }else{
            
            let setting = UIUserNotificationSettings(types: [UIUserNotificationType.alert ,UIUserNotificationType.badge , UIUserNotificationType.sound ], categories: nil)
            UIApplication.shared.registerUserNotificationSettings(setting)
        }
        UIApplication.shared.registerForRemoteNotifications()
        
    }
    
    
    
    
    
    //MARK:////////////////////////////////////iOS10接收远程推送相关//////////////////////////////////////////
    
    @available(iOS 10.0, *)//程序在前台的通知
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Swift.Void){
        let userInfo = notification.request.content.userInfo
        GDAlertView.alert(userInfo.description, image: nil, time: 4, complateBlock: nil)
        if notification.request.trigger?.isKind(of: UNPushNotificationTrigger.self) ?? false {
            JPUSHService.handleRemoteNotification(userInfo)
        }
        mylog("程序在前台时 : ios10 接收到的远程推送\(userInfo)")
        completionHandler(UNNotificationPresentationOptions.sound)
    }
    
    
    // The method will be called on the delegate when the user responded to the notification by opening the application, dismissing the notification or choosing a UNNotificationAction. The delegate must be set before the application returns from applicationDidFinishLaunching:.
    @available(iOS 10.0, *)//程序在后台或退出时的通知
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Swift.Void){
        let userInfo = response.notification.request.content.userInfo
        GDAlertView.alert(userInfo.description, image: nil, time: 4, complateBlock: nil)
        if response.notification.request.trigger?.isKind(of: UNPushNotificationTrigger.self) ?? false {
            JPUSHService.handleRemoteNotification(userInfo)
        }
        mylog("程序在后台时 : ios10 接收到的远程推送\(userInfo)")
        completionHandler()
    }
    
    
    
    
    //MARK:////////////////////////////////////iOS8,9接收远程推送相关//////////////////////////////////////////
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        JPUSHService.handleRemoteNotification(userInfo)
        mylog("iOS 8 , 9 接收到的远程推送\(userInfo)")
        completionHandler(UIBackgroundFetchResult.newData)
    }
    

    
    
    
    
    //MARK:////////////////////////////////////XXXXXX相关//////////////////////////////////////////
    
    
    
    
    
    
    //MARK:////////////////////////////////////XXXXXX相关//////////////////////////////////////////
    
    
    
    
    
    
    //MARK:////////////////////////////////////通用链接相关//////////////////////////////////////////
    
    func application(_ application: UIApplication, continue userActivity: NSUserActivity, restorationHandler: @escaping ([Any]?) -> Void) -> Bool{
        if userActivity.activityType == NSUserActivityTypeBrowsingWeb {
            let webPageUrl = userActivity.webpageURL
            let host = webPageUrl?.host
            if let hostStr = host  {
                if hostStr == "zjlao.com" || hostStr == "www.zjlao.com" || hostStr == "m.zjlao.com" || hostStr == "items.zjlao.com" {
                    
                    /*
                     //进行我们需要的处理
                     NSLog(@"_%d_%@",__LINE__,@"通用链接测试成功");
                     NSLog(@"_%d_%@",__LINE__,webpageURL.absoluteString);
                     NSURLComponents * components = [NSURLComponents componentsWithString:webpageURL.absoluteString];
                     NSArray * queryItems =  components.queryItems;
                     NSString * actionkey =  nil ;
                     NSString * ID = nil ;
                     for (NSURLQueryItem * item  in queryItems) {
                     if ([item.name isEqualToString:@"actionkey"]) {
                     if ([item.value isEqualToString:@"shop"]) {
                     actionkey = @"HShopVC";
                     }else if ([item.value isEqualToString:@"goods"]){
                     actionkey = @"HGoodsVC";
                     }else{
                     actionkey = item.value;
                     }
                     NSLog(@"_%d_%@",__LINE__,item.value);
                     }else if ([item.name isEqualToString:@"ID"]){
                     ID = item.value;
                     NSLog(@"_%d_%@",__LINE__,item.value);
                     }
                     
                     NSLog(@"_%d_%@",__LINE__,item.name);
                     NSLog(@"_%d_%@",__LINE__,item.value);
                     }
                     if (actionkey && ID ) {
                     BaseModel * model = [[[BaseModel alloc] init]initWithDict:@{@"actionkey":actionkey,@"paramete":ID}];
                     model.actionKey = actionkey;
                     model.keyParamete = @{@"paramete":ID};
                     [[SkipManager shareSkipManager] skipByVC:[KeyVC shareKeyVC] withActionModel:model];
                     }
                     
                     */
                    
                }else{
                    if UIApplication.shared.canOpenURL(webPageUrl!) {
                        UIApplication.shared.openURL(webPageUrl!)
                    }
                
                }
            }
        }
        
        return true
    }
    
    
    
    
    //MARK:////////////////////////////////////网络监测相关//////////////////////////////////////////
    func initnetWorkManager() {
                    NotificationCenter.default.addObserver(GDNetworkManager.self, selector: #selector(GDNetworkManager.noticeNetworkChanged(_:)), name: NSNotification.Name.AFNetworkingReachabilityDidChange, object: nil)
               AFNetworkReachabilityManager.shared().startMonitoring()
    }
    
    
    func setupRootVC() -> () {
//        let mainTabbarVC = MainTabbarVC()
//        let keyVC = KeyVC(rootViewController: mainTabbarVC)
//        
//        keyVC.mainTabbarVC = mainTabbarVC
//        mainTabbarVC.delegate = keyVC
//        self.window = UIWindow(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height))
//        self.window!.rootViewController = keyVC
//        self.window!.makeKeyAndVisible()
        self.window = nil
        self.window = UIWindow(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height))
        self.window!.rootViewController = KeyVC.share
        self.window!.makeKeyAndVisible()

    }
    
    
    
    //MARK:////////////////////////////////////////////更改语言相关//////////////////////////////////////////////////////
    
    
    
    
    //    func performChangeLanguage(targetLanguage : String)  {
    //
    //
    //        let noticStr_currentLanguageIs = NSLocalizedString("currentLanguageIs", tableName: LanguageTableName, bundle: Bundle.main, value:"", comment: "") // 提示语 中文的话 :@"当前语言是"   , 英文的花 : @"currentLanguageIs" (提示语也要国际化)
    //        let noticeStr_changeing = NSLocalizedString("languageChangeing", tableName: LanguageTableName, bundle: Bundle.main, value:"", comment: "") // 提示语 中文的话 @"语言更改中"  英文的话 @"languageChangeing" (提示语也要国际化)
    //
    //
    //        if targetLanguage == LanguageTableName && targetLanguage == LFollowSystemLanguage {//切换前后语言相同 , 除了提示之外不做任何变化
    //            GDAlertView.alert("重启app以生效", image: nil, time: 2, complateBlock: nil)
    //        }else if targetLanguage == LanguageTableName {//切换前后语言相同 , 除了提示之外不做任何变化
    //            GDAlertView.alert("\(noticStr_currentLanguageIs)\(GDLanguageManager.titlebyKey(key: LLanguageID))", image: nil, time: 2, complateBlock: nil)
    //
    //        }else if (targetLanguage == LFollowSystemLanguage){//由自定义语言切换为跟随系统语言
    //            if targetLanguage ==  GDLanguageManager.gotcurrentSystemLanguage() {//当切换前的自定义语言跟当前系统语言一样时 ,只保存 ,不重新切换 (如何获取系统语言??)
    //                GDStorgeManager.standard.set(LFollowSystemLanguage, forKey: "LanguageTableName")
    //            }else{//否则即保存又重新切换
    //                UserDefaults.standard.set(LFollowSystemLanguage, forKey: "LanguageTableName")
    ////                performChangeTheLanguage(targetLanguageTableName:targetLanguage)
    ////                self.resetKeyVC()
    ////                //                alert("\(noticeStr_changeing)", time: 3)
    ////                self.showNotic(autoHide: false, showStr:"\(noticeStr_changeing)" )
    //            }
    //            GDAlertView.alert("重启app以生效", image: nil, time: 2, complateBlock: nil)
    //        }else{//切换为自定义语言
    //            let oldLanguageName = LanguageTableName
    //            UserDefaults.standard.set(targetLanguage, forKey: "LanguageTableName")
    //            if  GDLanguageManager.titlebyKey(key: LLanguageID)  != nil {
    //                if GDLanguageManager.titlebyKey(key: LLanguageID) == "languageID"  {//gotTitleStr(key:)这个方法如果找不到键所对应的值 , 就把键返回,同时也说明本地没有相应的语言包
    //                    GDAlertView.alert("没有相应的语言包", image: nil, time: 2, complateBlock: nil)
    //                    UserDefaults.standard.set(oldLanguageName, forKey: "LanguageTableName")//顺便改回原来的语言
    //                }else{
    //                     UserDefaults.standard.set(targetLanguage, forKey: "LanguageTableName")
    //                    self.resetKeyVC()
    //                    //                alert("\(noticeStr_changeing)", time: 3)
    //                    self.showNotic(autoHide: false, showStr:"\(noticeStr_changeing)" )
    //                }
    //            }else{
    //                GDAlertView.alert("没有相应的语言包", image: nil, time: 2, complateBlock: nil)
    //                UserDefaults.standard.set(oldLanguageName, forKey: "LanguageTableName")//顺便改回原来的语言
    //            }
    //
    //        }
    //
    //    }
    
//    func resetKeyVC() {
//        let mainTabbarVC = MainTabbarVC()
//        let keyVC = KeyVC(rootViewController: mainTabbarVC)
//        keyVC.keyVCDelegate = self
//        keyVC.mainTabbarVC = mainTabbarVC
//        mainTabbarVC.delegate = keyVC
//        UIApplication.shared.keyWindow!.rootViewController = keyVC
//    }
    var hub : MBProgressHUD?
    func showNotic(autoHide : Bool , showStr : String) -> () {
        //        changeLanguageLabel.frame = CGRect(x: 0, y: 0, width: 100, height: 40)
        if hub == nil {
            
        }
        hub  = MBProgressHUD.showAdded(to: window!, animated: true)
        hub?.detailsLabel.text = showStr
        hub?.mode = MBProgressHUDMode.text
        if autoHide {
            hub?.hide(animated: true, afterDelay: TimeInterval(3))
        }else{
            
        }
    }
    func hidNotice() -> () {
        hub?.hide(animated: true)
    }
    func languageHadChanged() {
        self.hidNotice()
    }
    
    //MARK:////////////////////////////////////appDelegate代理方法//////////////////////////////////////////
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        mylog(UIScreen.main.bounds)
        //        UserDefaults.standard.set(nil, forKey: "LanguageTableName")
        self.setupRootVC()
        self.initnetWorkManager()
        self.setupOriginPushNotification()
        self.setupJpush(launchOptions: launchOptions)
        // Override point for customization after application launch.
        return true
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        let device_ns = NSData.init(data: deviceToken)
        let token:String = device_ns.description.trimmingCharacters(in: CharacterSet(charactersIn: "<>" ))//需要传给服务器
        GDNetworkManager.shareManager.saveDeviceTokenAndRegisterID(deviceToken: token , registerID: nil , { (respodsData) in
            mylog("deviceToken\(respodsData.msg)")
        }, failure: { (error ) in
            mylog("deviceToken保存失败\(error)")
        })
        
        mylog(token)
        JPUSHService.registerDeviceToken(deviceToken)
        //        [registrationIDCompletionHandler:]?
        JPUSHService.registrationIDCompletionHandler { (respondsCode, registrationID) in
            mylog("极光注册远程通知成功后获取的注册ID\(registrationID)\n\n状态码是\(respondsCode)")//需要传给服务器
            GDNetworkManager.shareManager.saveDeviceTokenAndRegisterID(deviceToken: nil , registerID: registrationID, { (respondsData) in
                mylog("registrationID\(respondsData.msg)")
            }, failure: { (error ) in
                mylog("registrationID保存失败\(error)")
            })
        }
    }
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        mylog("注册远程推送失败\(error)")
    }

    
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
        self.saveContext()
    }
    
    
    
    
    //MARK:////////////////////////////////////coreData相关//////////////////////////////////////////
    
    
    
    
    
    // MARK: - Core Data stack
    
    lazy var applicationDocumentsDirectory: URL = {
        // The directory the application uses to store the Core Data store file. This code uses a directory named "com.16lao.new.mh824appWithSwift" in the application's documents Application Support directory.
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return urls[urls.count-1]
    }()
    
    
    lazy var managedObjectModel: NSManagedObjectModel = {
        // The managed object model for the application. This property is not optional. It is a fatal error for the application not to be able to find and load its model.
        let modelURL = Bundle.main.url(forResource: "mh824appWithSwift", withExtension: "momd")!
        return NSManagedObjectModel(contentsOf: modelURL)!
    }()
    
    lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator = {
        // The persistent store coordinator for the application. This implementation creates and returns a coordinator, having added the store for the application to it. This property is optional since there are legitimate error conditions that could cause the creation of the store to fail.
        // Create the coordinator and store
        let coordinator = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
        let url = self.applicationDocumentsDirectory.appendingPathComponent("SingleViewCoreData.sqlite")
        var failureReason = "There was an error creating or loading the application's saved data."
        do {
            try coordinator.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: url, options: nil)
        } catch {
            // Report any error we got.
            var dict = [String: AnyObject]()
            dict[NSLocalizedDescriptionKey] = "Failed to initialize the application's saved data" as AnyObject?
            dict[NSLocalizedFailureReasonErrorKey] = failureReason as AnyObject?
            
            dict[NSUnderlyingErrorKey] = error as NSError
            let wrappedError = NSError(domain: "YOUR_ERROR_DOMAIN", code: 9999, userInfo: dict)
            // Replace this with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog("Unresolved error \(wrappedError), \(wrappedError.userInfo)")
            abort()
        }
        
        return coordinator
    }()
    
    lazy var managedObjectContext: NSManagedObjectContext = {
        // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.) This property is optional since there are legitimate error conditions that could cause the creation of the context to fail.
        let coordinator = self.persistentStoreCoordinator
        var managedObjectContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        managedObjectContext.persistentStoreCoordinator = coordinator
        return managedObjectContext
    }()
    
    // MARK: - Core Data Saving support
    
    func saveContext () {
        if managedObjectContext.hasChanges {
            do {
                try managedObjectContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                NSLog("Unresolved error \(nserror), \(nserror.userInfo)")
                abort()
            }
        }
    }
    
    
    
}

