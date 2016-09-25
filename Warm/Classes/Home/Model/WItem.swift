//
//  WItem.swift
//  Warm
//
//  Created by zhoucj on 16/9/22.
//  Copyright © 2016年 zhoucj. All rights reserved.
//

import UIKit

class WItem: NSObject {
    var id: String?
    var type: Int64 = -1
    var info: String?
    var salon: WSalon?
    var classes: WClass?
    init(dict: [String: AnyObject]) {
        super.init()
        setValuesForKeysWithDictionary(dict)
    }
    override func setValue(value: AnyObject?, forKey key: String) {
        if "salon" == key{
            guard let _data = value as? [String: AnyObject] else{
                return
            }
            salon = WSalon(dict: _data)
            return
        }
        if "classes" == key{
            guard let _data = value as? [String: AnyObject] else{
                return
            }
            classes = WClass(dict: _data)
            return
        }
        super.setValue(value, forKey: key)
    }
    //防治没有匹配到的key报错
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
    }
}
