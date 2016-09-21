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
        super.setValue(value, forKey: key)
    }
}