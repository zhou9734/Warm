//
//  WClass.swift
//  Warm
//
//  Created by zhoucj on 16/9/14.
//  Copyright © 2016年 zhoucj. All rights reserved.
//

import UIKit

class WClass: WRecommendData {
    //分享url
    var share_url: String?
    //地区
    var area: String?
    var tags: [WTag]?
    var tags_bd: [WTag]?
    var heat_detail: AnyObject?
    var areatimeStr: String?
    var teacher: WTeacher?
    var info: WInfo?
    var goods: [WGoods] = [WGoods]()

    override func setValue(value: AnyObject?, forKey key: String) {
        if key == "tags"{
            guard let _data = value as? [[String: AnyObject]] else{
                return
            }
            var _tags = [WTag]()
            for i in _data{
                let tmpTag = WTag(dict: i )
                _tags.append(tmpTag)
            }
            tags = _tags
            return
        }
        if key == "tags_bd"{
            guard let _data = value as? [[String: AnyObject]] else{
                return
            }
            var _tags_bds = [WTag]()
            for i in _data{
                let temp = WTag(dict: i)
                _tags_bds.append(temp)
            }
            tags_bd = _tags_bds
            return
        }
        if key == "teacher"{
            guard let _data = value as? [String: AnyObject] else{
                return
            }
            teacher = WTeacher(dict: _data)
            return
        }
        if key == "info"{
            guard let _data = value as? [String: AnyObject] else{
                return
            }
            info = WInfo(dict: _data)
            return
        }
        if key == "goods"{
            guard let _data = value as? [[String: AnyObject]] else{
                return
            }
            var _goods = [WGoods]()
            for i in _data{
                let temp = WGoods(dict: i)
                _goods.append(temp)
            }
            goods = _goods
            return
        }
        super.setValue(value, forKey: key)
    }
}
class WInfo: NSObject {
    var classesid: Int64 = -1
    //详细
    var detail: String?
    //如何参与
    var buy_tips: String = ""
    //提示
    var warmup_tips: String = ""

    init(dict: [String: AnyObject]) {
        super.init()
        setValuesForKeysWithDictionary(dict)
    }
    //防治没有匹配到的key报错
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
    }
}
class WGoods: NSObject{
    var id: Int64 = -1
    var price: CGFloat = 0.0
    var price_detail: String = ""
    var classesid: Int64 = -1
    var start_time: Int64 = -1
    var end_time: Int64 = -1
    init(dict: [String: AnyObject]) {
        super.init()
        setValuesForKeysWithDictionary(dict)
    }
    //防治没有匹配到的key报错
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
    }
}