//
//  WTag.swift
//  Warm
//
//  Created by zhoucj on 16/9/14.
//  Copyright © 2016年 zhoucj. All rights reserved.
//

import UIKit

class WTags: NSObject {
    //tagid
    var tagid: Int64 = -1
    //排序
    var sort: Int64 = -1
    //图片地址
    var avatar: String?
    //创建时间
    var created_at: Int64 = -1
    //更新时间
    var updated_at: Int64 = -1
    var tag: WTag?
    init(dict: [String: AnyObject]) {
        super.init()
        setValuesForKeysWithDictionary(dict)
    }
    override func setValue(value: AnyObject?, forKey key: String) {
        if key == "tag"{
            guard let _data = value else{
                return
            }
            tag = WTag(dict: _data as! [String: AnyObject])
            return
        }
        super.setValue(value, forKey: key)
    }
    //防治没有匹配到的key报错
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
    }

}
class WTag: NSObject {
    //id
    var id: Int64 = -1
    //标签名称
    var name: String?
    //图标
    var icon: String?
    //类型
    var type: Int64 = -1
    //创建时间
    var created_at: Int64 = -1
    //更新时间
    var updated_at: Int64 = -1
    init(dict: [String: AnyObject]) {
        super.init()
        setValuesForKeysWithDictionary(dict)
    }
    //防治没有匹配到的key报错
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
    }

}
