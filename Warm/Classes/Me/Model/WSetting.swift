//
//  WSetting.swift
//  Warm
//
//  Created by zhoucj on 16/9/19.
//  Copyright © 2016年 zhoucj. All rights reserved.
//

import UIKit

class WSetting: NSObject {
    var leftTitle: String?
    var rightTitle: String?
    init(dict: [String: AnyObject]) {
        super.init()
        setValuesForKeysWithDictionary(dict)
    }
    //防治没有匹配到的key报错
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
    }
}
