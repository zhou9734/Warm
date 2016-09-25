//
//  WDict.swift
//  Warm
//
//  Created by zhoucj on 16/9/21.
//  Copyright © 2016年 zhoucj. All rights reserved.
//

import UIKit

class WDict: NSObject {
    var name: String?
    var code: Int64 = -1
    init(name: String, code: Int64) {
        self.name = name
        self.code = code
    }
    init(dict: [String: AnyObject]) {
        super.init()
        setValuesForKeysWithDictionary(dict)
    }

    //防治没有匹配到的key报错
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
    }
}
