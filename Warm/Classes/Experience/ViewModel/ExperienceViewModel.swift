//
//  ExperienceViewModel.swift
//  Warm
//
//  Created by zhoucj on 16/9/14.
//  Copyright © 2016年 zhoucj. All rights reserved.
//

import UIKit

class ExperienceViewModel: NSObject {
    //标签
    var tags: [WTags] = [WTags]()
    var classes: [WClass] = [WClass]()
    var citys: [WCity] = [WCity]()
    var areas: [WDict] = [WDict]()

    func resetData(){
        tags.removeAll()
        classes.removeAll()
    }

    func loadData(citycode: String, page: Int, finished: (data: AnyObject?, error: NSError?)->()){
        unowned let tmpSelf = self
        NetworkTools.sharedInstance.getExperienceData(citycode, page: page, count: pageSize) { (data, error) -> () in
            // 安全校验
            if error != nil{
                finished(data: nil, error: error)
                return
            }
            guard let _data = data else{
                return
            }
            guard let _tags = _data["tags"] as? [[String: AnyObject]] else{
                return
            }
            guard let _classes = _data["classes"] as? [[String: AnyObject]] else{
                return
            }
            if page == 1{
                for _tag in _tags {
                    let tag = WTags(dict: _tag)
                    tmpSelf.tags.append(tag)
                }
            }

            for _class in _classes{
                let cla = WClass(dict: _class)
                cla.areatimeStr = "\(cla.area!) · \(NSDate.formatterData(cla.starttime, formatterStr: "MM月-dd日")) - \(NSDate.formatterData(cla.endtime, formatterStr: "MM月-dd日"))"
                tmpSelf.classes.append(cla)
            }
            finished(data: data, error: error)
        }
    }

    func loadCityData() -> [WCity]{
        do{
            let pathStr = NSBundle.mainBundle().pathForResource("City", ofType: "json")
            let data = NSData(contentsOfFile: pathStr!)
            let dict = try NSJSONSerialization.JSONObjectWithData(data!, options: .AllowFragments) as! NSDictionary
            guard let datas = dict["data"] as? [[String : AnyObject]] else{
                return citys
            }
            for i in datas{
                let _city = WCity(dict: i)
                citys.append(_city)
            }
            return citys
        }catch let error as NSError{
            CJLog(error)
            return citys
        }
    }

    func loadECalendarData(citycode: String, page: Int, count: Int,date: String, finished: (data: AnyObject?, error: NSError?)->()){
        unowned let tmpSelf = self
        NetworkTools.sharedInstance.getExperienceDataForCalendar(citycode, page: page, count: pageSize, date: date) { (data, error) -> () in
            // 安全校验
            if error != nil{
                finished(data: nil, error: error)
                return
            }
            guard let _classes = data as? [[String: AnyObject]] else{
                return
            }
            for _class in _classes{
                let cla = WClass(dict: _class)
                cla.areatimeStr = "\(cla.area!) · \(NSDate.formatterData(cla.starttime, formatterStr: "MM月-dd日")) - \(NSDate.formatterData(cla.endtime, formatterStr: "MM月-dd日"))"
                tmpSelf.classes.append(cla)
            }
            finished(data: data, error: error)
        }
    }

    func filterExperienceData(areacode: Int64?, citycode: String, page: Int, count: Int,sort: Int64, tagid: Int64?,finished: (data: AnyObject?, error: NSError?)->()){
        unowned let tmpSelf = self
        NetworkTools.sharedInstance.filterExperienceData(areacode, citycode: citycode, page: page, count: pageSize, sort: sort, tagid: tagid) { (data, error) -> () in
            // 安全校验
            if error != nil{
                finished(data: nil, error: error)
                return
            }
            guard let _classes = data as? [[String: AnyObject]] else{
                return
            }
            for _class in _classes{
                let cla = WClass(dict: _class)
                cla.areatimeStr = "\(cla.area!) · \(NSDate.formatterData(cla.starttime, formatterStr: "MM月-dd日")) - \(NSDate.formatterData(cla.endtime, formatterStr: "MM月-dd日"))"
                tmpSelf.classes.append(cla)
            }
            finished(data: data, error: error)
        }

    }

    func loadAreasByCityCode(cityCode: String, finished: (data: AnyObject?, error: NSError?)->()){
        unowned let tmpSelf = self
        areas.removeAll()
        NetworkTools.sharedInstance.loadAreasByCityCode(cityCode) { (data, error) -> () in
            // 安全校验
            if error != nil{
                finished(data: nil, error: error)
                return
            }
            guard let _areas = data as? [[String: AnyObject]] else{
                return
            }
            for area in _areas{
                let _area = WDict(dict: area)
                tmpSelf.areas.append(_area)
            }
            let area = WDict(name: "所有地区", code: 999)
            tmpSelf.areas.insert(area, atIndex: 0)
            finished(data: data, error: error)
        }
    }

    func loadDictDataByFile(fileName: String) -> [WDict]{
        var dicts = [WDict]()
        do{
            let pathStr = NSBundle.mainBundle().pathForResource(fileName, ofType: "json")
            let data = NSData(contentsOfFile: pathStr!)
            let dict = try NSJSONSerialization.JSONObjectWithData(data!, options: .AllowFragments) as! NSDictionary

            guard let datas = dict["result"] as? [[String : AnyObject]] else{
                return dicts
            }
            for i in datas{
                let _dict = WDict(dict: i)
                dicts.append(_dict)
            }
            return dicts
        }catch let error as NSError{
            CJLog(error)
            return dicts
        }
    }


}
