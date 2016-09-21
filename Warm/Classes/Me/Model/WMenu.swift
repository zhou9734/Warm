//
//  Menu.swift
//  Warm
//
//  Created by zhoucj on 16/9/17.
//  Copyright © 2016年 zhoucj. All rights reserved.
//

import UIKit

class WMenu: NSObject {
    var menus: [Menu]?
    init(dict: [String: AnyObject]) {
        super.init()
        setValuesForKeysWithDictionary(dict)
    }
    override func setValue(value: AnyObject?, forKey key: String) {
        if key == "menus"{
            guard let _data = value as? [[String: AnyObject]] else{
                return
            }
            var _menus = [Menu]()
            for i in _data{
                let menu = Menu(dict: i)
                _menus.append(menu)
            }
            menus = _menus
            return
        }
        super.setValue(value, forKey: key)
    }
    //防治没有匹配到的key报错
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
    }
}
class Menu: NSObject {
    var image: String?
    var name: String?
    init(dict: [String: AnyObject]) {
        super.init()
        setValuesForKeysWithDictionary(dict)
    }
    //防治没有匹配到的key报错
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
    }
}
