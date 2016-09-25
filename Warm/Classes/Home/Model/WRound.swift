//
//  WRounds.swift
//  Warm
//
//  Created by zhoucj on 16/9/13.
//  Copyright © 2016年 zhoucj. All rights reserved.
// 顶部循环滚动图片

import UIKit

class WRound: WBase {
    //图片
    var data: WData?{
        didSet{
            if let _rdata = rdata{
                guard let _ = _rdata.avatar else{
                    rdata?.avatar = data?.avatar
                    return
                }
            }else{
                let rd = WRdata()
                rd.avatar = data!.avatar
                rdata = rd
                return
            }
        }
    }
    //数据
    var rdata: WRdata?
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
                let _rdata = WRdata()
                _rdata.avatar = data?.avatar
                rdata = _rdata
                return
            }
            rdata = WRdata(dict: _data as! [String: AnyObject])
            return
        }
        super.setValue(value, forKey: key)
    }

}
class WData: NSObject {
    //图片地址
    var avatar: String?
    init(dict: [String: AnyObject]) {
        super.init()
        setValuesForKeysWithDictionary(dict)
    }
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
    }
    override var description : String {
        let pops = ["avatar"]
        let dict = dictionaryWithValuesForKeys(pops)
        return "\(dict)"
    }
}
class WRdata: NSObject {
    //id
    var id: Int64 = -1
    //标题
    var title: String?
    //图片地址
    var avatar: String?
    //喜欢的数量
    var like_count: Int64 = 0
    //创建时间
    var created_at: Int64 = -1
    //更新时间
    var updated_at: Int64 = -1
    //分享地址
    var share_url: String?
    //内容
    var content: String?
    var itmes: [WItem]?
    var liked: Bool = false
    override init() {
        super.init()
    }
    init(dict: [String: AnyObject]) {
        super.init()
        setValuesForKeysWithDictionary(dict)
    }
    override func setValue(value: AnyObject?, forKey key: String) {
        if "items" == key{
            guard let _data = value as? [[String: AnyObject]] else{
                return
            }
            var _itmes = [WItem]()
            for i in _data{
                let _item = WItem(dict: i)
                _itmes.append(_item)
            }
            itmes = _itmes
            return
        }
        super.setValue(value, forKey: key)
    }
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
    }
}
