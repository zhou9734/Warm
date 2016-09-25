//
//  NetworkTools.swift
//  Warm
//
//  Created by zhoucj on 16/9/13.
//  Copyright © 2016年 zhoucj. All rights reserved.
//

import UIKit
import AFNetworking

class NetworkTools: AFHTTPSessionManager {
    //单例
    static let sharedInstance: NetworkTools = {
        //注意baseURL后面一定要写上斜线(/)
        let url = NSURL(string: "http://api.mid.warmup.cc/api/")!
        let instance = NetworkTools(baseURL: url, sessionConfiguration: NSURLSessionConfiguration.defaultSessionConfiguration())

        instance.responseSerializer.acceptableContentTypes =  NSSet(objects: "application/json", "text/json", "text/javascript", "text/plain") as Set
        return instance
    }()
    //MARK: - 获得主页数据
    func getHomeData(citycode: String, page: Int, count: Int, finished: (data: AnyObject?, error: NSError?)->()){
        // "v6/salon/recommends?citycode=440100&count=10&page=1&type=2"
        let path = "v6/salon/recommends"
        let params = ["citycode": citycode, "count": count, "page": page, "type": 2]

        GET(path, parameters: params, success: { (task, objc) -> Void in
            //返回数据给调用者
            guard let _array = objc["result"] else{
                finished(data: nil, error: NSError(domain: "com.mid.warmup.www", code: 666, userInfo: ["message" : "没有获取到微博数据"]))
                return
            }
            finished(data: _array, error: nil)
            }) { (task, error) -> Void in
                finished(data: nil, error: error)
        }
    }

    //MARK: - 获得体验数据
    func getExperienceData(citycode: String, page: Int, count: Int, finished: (data: AnyObject?, error: NSError?)->()){
        // v6/classes/recommends?citycode=440100&count=10&page=1&type=2
        let path = "v6/classes/recommends"
        let params = ["citycode": citycode, "count": count, "page": page, "type": 2]

        GET(path, parameters: params, success: { (task, objc) -> Void in
            //返回数据给调用者
            guard let _array = objc["result"] else{
                finished(data: nil, error: NSError(domain: "com.mid.warmup.www", code: 666, userInfo: ["message" : "没有获取到微博数据"]))
                return
            }
            finished(data: _array, error: nil)
            }) { (task, error) -> Void in
                finished(data: nil, error: error)
        }
    }

    //MARK: - 获取体验右上角日历数据
    func getExperienceDataForCalendar(citycode: String, page: Int, count: Int,date: String, finished: (data: AnyObject?, error: NSError?)->()){
        // v6/classes/calendar?citycode=440300&count=10&date=16-09-12&page=1
        let path = "v6/classes/calendar"
        let params = ["citycode": citycode, "count": count, "page": page, "date": date]

        GET(path, parameters: params, success: { (task, objc) -> Void in
            //返回数据给调用者
            guard let _array = objc["result"] else{
                finished(data: nil, error: NSError(domain: "com.mid.warmup.www", code: 666, userInfo: ["message" : "没有获取到微博数据"]))
                return
            }
            finished(data: _array, error: nil)
            }) { (task, error) -> Void in
                finished(data: nil, error: error)
        }
    }
    //MARK: - 过滤体验数据
    func filterExperienceData(areacode: Int64?, citycode: String, page: Int, count: Int,sort: Int64, tagid: Int64?,finished: (data: AnyObject?, error: NSError?)->()){
        // v6/classes/search?citycode=440300&count=10&page=1&sort=1
        // v6/classes/search?areacode=440303&citycode=440300&count=10&page=1&sort=1&tagid=1
        let path = "v6/classes/search"
        let params: NSMutableDictionary = ["citycode": citycode, "count": count, "page": page, "sort": "\(sort)"]

        if let _tagid = tagid where _tagid != 999{
            params.setObject("\(_tagid)", forKey: "tagid")
        }
        if let _areacode = areacode  where _areacode != 999{
            params.setObject("\(_areacode)", forKey: "areacode")
        }
        GET(path, parameters: params, success: { (task, objc) -> Void in
            //返回数据给调用者
            guard let _array = objc["result"] else{
                finished(data: nil, error: NSError(domain: "com.mid.warmup.www", code: 666, userInfo: ["message" : "没有获取到微博数据"]))
                return
            }
            finished(data: _array, error: nil)
            }) { (task, error) -> Void in
                finished(data: nil, error: error)
        }
    }
    ///MARK: - 根据城市编号获得所有区
    func loadAreasByCityCode(cityCode: String, finished: (data: AnyObject?, error: NSError?)->()){
        //v3/classes/areas?code=440300
        let path = "v3/classes/areas"
        let params = ["code": cityCode]

        GET(path, parameters: params, success: { (task, objc) -> Void in
            //返回数据给调用者
            guard let _array = objc["result"] else{
                finished(data: nil, error: NSError(domain: "com.mid.warmup.www", code: 666, userInfo: ["message" : "没有获取到微博数据"]))
                return
            }
            finished(data: _array, error: nil)
            }) { (task, error) -> Void in
                finished(data: nil, error: error)
        }
    }
    //MARK: - 获得专题详细
    func loadSubjectDetail(subjectId: Int64, finished: (data: AnyObject?, error: NSError?)->()){
        let path = "v6/subject/\(subjectId)"
        GET(path, parameters: [], success: { (task, objc) -> Void in
            //返回数据给调用者
            guard let _array = objc["result"] else{
                finished(data: nil, error: NSError(domain: "com.mid.warmup.www", code: 666, userInfo: ["message" : "没有获取到微博数据"]))
                return
            }
            finished(data: _array, error: nil)
            }) { (task, error) -> Void in
                finished(data: nil, error: error)
        }
    }
    //MARK: - 获得话题详情
    func loadSalonDetail(salonId: Int64,finished: (data: AnyObject?, error: NSError?)->()){
        // v6/salon/449/app
        let path = "v6/salon/\(salonId)/app"
        GET(path, parameters: [], success: { (task, objc) -> Void in
            //返回数据给调用者
            guard let _array = objc["result"] else{
                finished(data: nil, error: NSError(domain: "com.mid.warmup.www", code: 666, userInfo: ["message" : "没有获取到微博数据"]))
                return
            }
            finished(data: _array, error: nil)
            }) { (task, error) -> Void in
                finished(data: nil, error: error)
        }
    }

    //MARK: - 获得某一个专题
    func loadClassesDetail(classesid: Int64, finished: (data: AnyObject?, error: NSError?)->()){
        // v6/classes/1873
        let path = "v6/classes/\(classesid)"
        GET(path, parameters: [], success: { (task, objc) -> Void in
            //返回数据给调用者
            guard let _array = objc["result"] else{
                finished(data: nil, error: NSError(domain: "com.mid.warmup.www", code: 666, userInfo: ["message" : "没有获取到微博数据"]))
                return
            }
            finished(data: _array, error: nil)
            }) { (task, error) -> Void in
                finished(data: nil, error: error)
        }
    }
}
