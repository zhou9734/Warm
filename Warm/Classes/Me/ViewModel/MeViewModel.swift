//
//  MeViewModel.swift
//  Warm
//
//  Created by zhoucj on 16/9/17.
//  Copyright © 2016年 zhoucj. All rights reserved.
//

import UIKit

class MeViewModel: NSObject {
    var wmenu = [WMenu]()
    var settings = [WSetting]()

    func loadData() -> [WMenu]{
        do{
            let pathStr = NSBundle.mainBundle().pathForResource("MeTable", ofType: "json")
            let data = NSData(contentsOfFile: pathStr!)
            let dict = try NSJSONSerialization.JSONObjectWithData(data!, options: .AllowFragments) as! NSDictionary
            guard let datas = dict["data"] as? [[String : AnyObject]] else{
                return wmenu
            }
            for i in datas{
                let _wmenu = WMenu(dict: i)
                wmenu.append(_wmenu)
            }
            return wmenu
        }catch let error as NSError{
            CJLog(error)
            return wmenu
        }
    }

    func loadSetting() -> [WSetting]{
        do{
            let pathStr = NSBundle.mainBundle().pathForResource("Setting", ofType: "json")
            let data = NSData(contentsOfFile: pathStr!)
            let dict = try NSJSONSerialization.JSONObjectWithData(data!, options: .AllowFragments) as! NSDictionary
            guard let datas = dict["data"] as? [[String : AnyObject]] else{
                return settings
            }
            for i in datas{
                let _setting = WSetting(dict: i)
                settings.append(_setting)
            }
            return settings
        }catch let error as NSError{
            CJLog(error)
            return settings
        }

    }
}
