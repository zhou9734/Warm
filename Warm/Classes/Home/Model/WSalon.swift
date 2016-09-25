//
//  WSalon.swift
//  Warm
//
//  Created by zhoucj on 16/9/13.
//  Copyright © 2016年 zhoucj. All rights reserved.
//最下面的tableView数据

import UIKit

class WSalon: NSObject {
    //id
    var id: Int64 = -1
    //用户id
    var userid: Int64 = -1
    //标题
    var title: String?
    //图片地址
    var avatar: String?
    //
    var origin: Int64 = -1
    //状态
    var status: Int64 = -1
    //专题id
    var classesid: Int64 = 0
    //
    var buy: AnyObject?
    var follow_count: Int64 = -1
    var comment_count: Int64 = -1
    var talk_about: String?
    //创建时间
    var created_at: Int64 = -1
    //更新时间
    var updated_at: Int64 = -1
    //删除时间
    var deleted_at: Int64 = 0
    //分享
    var share: WShare?
    var talk_about_divider: String?
    var user: WUser?
    var content: [String] = [String]()

    init(dict: [String: AnyObject]) {
        super.init()
        setValuesForKeysWithDictionary(dict)
    }
    override func setValue(value: AnyObject?, forKey key: String) {
        if key == "share"{
            guard let _data = value else{
                return
            }
            share = WShare(dict: _data as! [String: AnyObject])
            return
        }
        if key == "user"{
            guard let _data = value else{
                return
            }
            user = WUser(dict: _data as! [String: AnyObject])
            return
        }
        if key == "content"{
            guard let datas = value as? [String] else{
                return
            }
            content = datas
            return
        }
        super.setValue(value, forKey: key)
    }
    //防治没有匹配到的key报错
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
    }

}
class WShare: NSObject {
    var img: String?
    var url: String?
    init(dict: [String: AnyObject]) {
        super.init()
        setValuesForKeysWithDictionary(dict)
    }
    //防治没有匹配到的key报错
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
    }
}

class WUser: NSObject {
    //id
    var id: Int64 = -1
    //昵称
    var nickname: String?
    //图片地址
    var avatar: String?
    //个性签名
    var signature: String?
    init(dict: [String: AnyObject]) {
        super.init()
        setValuesForKeysWithDictionary(dict)
    }
    //防治没有匹配到的key报错
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
    }

}
