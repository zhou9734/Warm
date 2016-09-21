//
//  WBase.swift
//  Warm
//
//  Created by zhoucj on 16/9/13.
//  Copyright © 2016年 zhoucj. All rights reserved.
//

import UIKit

class WBase: NSObject {
    //id
    var id: Int64 = -1
    //种类
    var kind: Int64 = -1
    //外键
    var rid: String?
    //类型
    var type: Int64 = -1
    //城市编码
    var citycode: Int64 = -1
    //排序
    var sort: Int64 = -1
    //开始时间
    var starttime: Int64 = 0
    //结束时间
    var endtime: Int64 = 0
    //创建时间
    var created_at: Int64 = -1
    //更新时间
    var updated_at: Int64 = -1
    //删除时间
    var deleted_at: Int64 = 0
    
    init(dict: [String: AnyObject]) {
        super.init()
        setValuesForKeysWithDictionary(dict)
    }
    //防治没有匹配到的key报错
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
    }
    override var description : String {
        let pops = ["id", "kind", "rid", "citycode", "sort", "starttime", "endtime", "created_at", "updated_at", "deleted_at"]
        let dict = dictionaryWithValuesForKeys(pops)
        return "\(dict)"
    }
}
