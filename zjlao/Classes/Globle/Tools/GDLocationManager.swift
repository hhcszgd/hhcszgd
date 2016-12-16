//
//  GDLocationManager.swift
//  zjlao
//
//  Created by WY on 16/10/31.
//  Copyright © 2016年 WY. All rights reserved.
//


import UIKit

import CoreLocation



typealias closureType = (String , NSError) -> ()

class GDLocationManager: NSObject ,CLLocationManagerDelegate {
    
    let localtionManager  =  CLLocationManager.init()
    
    var callback : ( (String? , NSError?) -> ())?//  = {  String , NSError in
    // mylog("")
    //}
    
    override init() {
        super.init()
        localtionManager.delegate = self
        
    }
    
    func start ( call : @escaping  (String? , NSError?) -> () ) -> () {
        self.callback = call
        self.localtionManager.requestWhenInUseAuthorization()
        self.localtionManager.startUpdatingLocation()
    }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        self.gotCity(location: locations.first!) { (error, CLPlacemarkArrM) in
            
        }
    }
    
    
    
    
    
    func gotCity(location : CLLocation , result : @escaping ( Error? , [CLPlacemark]?) -> ()) -> Void {
        let geoCoder = CLGeocoder.init()
        geoCoder.reverseGeocodeLocation(location) { (CLPlacemarkArr, error) in
            
            let placemark = CLPlacemarkArr?.first
            
            mylog("name : \(placemark?.name)")
            mylog("thoroughfare : \(placemark?.thoroughfare)")
            mylog("locality : \(placemark?.name)")
            mylog("administrativeArea : \(placemark?.administrativeArea)")
            mylog("country : \(placemark?.country)")
            mylog("postalCode : \(placemark?.postalCode)")
            
            mylog("isoCountryCode : \(placemark?.isoCountryCode)")
            mylog("subAdministrativeArea : \(placemark?.subAdministrativeArea)")
            mylog("subLocality : \(placemark?.subLocality)")//区
            mylog("addressDictionary : \(placemark?.addressDictionary)")//区
            
            let  resultArrM = placemark?.addressDictionary?["FormattedAddressLines"] as? [AnyObject]
            if let formatterStr  = resultArrM?.first {
                if let Str = formatterStr as? String {
                    mylog(Str)
                    self.localtionManager.stopUpdatingLocation()
                    self.callback?(Str,error as? NSError)
                }
            }
            result(error ,  CLPlacemarkArr)
            mylog(error)
        }
        
        
    }
    
}














/*    location             : CLLocation 类型, 位置对象信息, 里面包含经纬度, 海拔等等
 region                 : CLRegion 类型, 地标对象对应的区域
 addressDictionary  : NSDictionary 类型, 存放街道,省市等信息
 name                : NSString 类型, 地址全称
 thoroughfare        : NSString 类型, 街道名称
 locality            : NSString 类型, 城市名称//不太准 , 也可能是乡
 administrativeArea : NSString 类型, 省名称 //也可能是直辖市名 //
 country                : NSString 类型, 国家名称
 subLocality ://区
 
 取 addressDictionary 最靠谱
 addressDictionary["Country"] //国家
 addressDictionary["State"] //省/直辖市
 addressDictionary["City"] //城市
 addressDictionary["SubLocality"] //区
 addressDictionary["Name"] //乡镇
 addressDictionary["CountryCode"] //国家码(中国的是CN)
 
 addressDictionary["FormattedAddressLines"] //格式化后的全部地址 (是个数组,  .first取第一个)
 */
/*addressDictionary : Optional([AnyHashable("Country"): 中国, AnyHashable("City"): 郑州市, AnyHashable("Name"): 侯寨乡, AnyHashable("State"): 河南省, AnyHashable("FormattedAddressLines"): <__NSArrayM 0x60000024d140>(
 中国河南省郑州市二七区侯寨乡
 
 addressDictionary : Optional([AnyHashable("Country"): 中国, AnyHashable("City"): 北京市, AnyHashable("Name"): 妙峰山镇, AnyHashable("State"): 北京市, AnyHashable("FormattedAddressLines"): <__NSArrayM 0x600000056320>(
 中国北京市门头沟区妙峰山镇
 )
 , AnyHashable("CountryCode"): CN, AnyHashable("SubLocality"): 门头沟区])
 )*/
