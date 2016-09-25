//
//  WRecommend.swift
//  Warm
//
//  Created by zhoucj on 16/9/13.
//  Copyright © 2016年 zhoucj. All rights reserved.
//取暖精选

import UIKit

class WRecommend: WBase {
    //图片
    var data: WData?
    var rdata: WRecommendData?
    //数据
    override func setValue(value: AnyObject?, forKey key: String) {
        if key == "data"{
            guard let _data = value else{
                return
            }
            data = WData(dict: _data as! [String: AnyObject])
            return
        }
        if key == "rdata"{
            guard let _data = value else{
                return
            }
            rdata = WRecommendData(dict: _data as! [String: AnyObject])
            return
        }
        super.setValue(value, forKey: key)
    }

}
class WRecommendData: NSObject {
    //id
    var id: Int64 = -1
    //状态
    var status: Int64 = -1
    //用户id
    var userid: Int64 = -1
    //名称
    var name: String?
    //描述
    var desc: String?
    //图片地址
    var images: String?
    //城市编码
    var citycode: Int64 = -1
    //区域编码
    var areacode: Int64 = -1
    //地址
    var address: String?
    //精度
    var longitude: CGFloat = 0.0
    //纬度
    var latitude: CGFloat = 0.0
    //价格
    var price: CGFloat = 0.0
    //喜欢的数量
    var like_count: Int64 = 0
    //开始时间
    var starttime: Int64 = -1
    //结束时间
    var endtime: Int64 = -1
    var ctime: Int64 = -1
    var utime: Int64 = -1
    //浏览次数
    var view_count: Int64 = 1
    var key_words: String?
    var sort: Int64 = -1
    var booking: Int64 = -1
    var buy_count: Int64 = -1
    var heat: Int64 = -1

    init(dict: [String: AnyObject]) {
        super.init()
        setValuesForKeysWithDictionary(dict)
    }
    override func setValue(value: AnyObject?, forKey key: String) {
        if key == "description"{
            desc = "\(value!)"
            return
        }
        super.setValue(value, forKey: key)
    }
    //防治没有匹配到的key报错
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
    }
}
