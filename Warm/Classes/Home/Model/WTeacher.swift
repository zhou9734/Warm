//
//  WTeacher.swift
//  Warm
//
//  Created by zhoucj on 16/9/25.
//  Copyright © 2016年 zhoucj. All rights reserved.
//

import UIKit

class WTeacher: NSObject {
    //id
    var id: Int64 = -1
    //类型
    var type: Int64 = -1
    //状态
    var status: Int64 = -1
    //创建时间
    var ctime: Int64 = -1
    //更新时间
    var utime: Int64 = -1
    //登录时间
    var logintime: Int64 = -1
    //手机号码
    var mobile: String = ""
    //邮件
    var email: String = ""
    //昵称
    var nickname: String = ""
    //性别
    var gender: Int64 = 1
    //生日
    var birthday: Int64 = -2209017600
    //个性签名
    var signature: String = ""
    //头像地址
    var avatar: String?
    init(dict: [String: AnyObject]) {
        super.init()
        setValuesForKeysWithDictionary(dict)
    }
    //防治没有匹配到的key报错
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
    }
}
