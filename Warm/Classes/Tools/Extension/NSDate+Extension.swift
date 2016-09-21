//
//  NSDate+Extension.swift
//  Warm
//
//  Created by zhoucj on 16/9/14.
//  Copyright © 2016年 zhoucj. All rights reserved.
//

import UIKit
extension NSDate {
    /// 根据一个字符串创建一个NSDate
    class func createDate(timeStr: String, formatterStr: String) -> NSDate{
        let formatter = NSDateFormatter()
        formatter.dateFormat = formatterStr
        // 如果不指定以下代码, 在真机中可能无法转换
        formatter.locale = NSLocale(localeIdentifier: "en")
        let date = formatter.dateFromString(timeStr)!
        let zone = NSTimeZone.systemTimeZone()
        let interval = zone.secondsFromGMTForDate(date)
        return date.dateByAddingTimeInterval(Double(interval))
    }

    class func formatterData(intTime: Int64, formatterStr: String) -> String {
        let d = NSDate(timeIntervalSince1970: Double(intTime))
        let formatter = NSDateFormatter()
        formatter.dateFormat = formatterStr
        // 如果不指定以下代码, 在真机中可能无法转换
        formatter.locale = NSLocale(localeIdentifier: "en")
        return formatter.stringFromDate(d)
    }
    //格式化字符串
    func formatterData(formatterStr: String) -> String {
        let formatter = NSDateFormatter()
        formatter.dateFormat = formatterStr
        // 如果不指定以下代码, 在真机中可能无法转换
        formatter.locale = NSLocale(localeIdentifier: "en")
        return formatter.stringFromDate(self)
    }
    //一个月有多少天
    func numberOfDayInCurrentMonth() -> Int{
        return NSCalendar.currentCalendar().rangeOfUnit(NSCalendarUnit.Day, inUnit: NSCalendarUnit.Month, forDate: self).length
    }
    //某个月的第一个星期有几天
    func firstWeekOfMonth() ->Int {
        let Week: NSInteger = NSCalendar.currentCalendar().ordinalityOfUnit(.Day, inUnit: NSCalendarUnit.WeekOfMonth, forDate: self)
        return Week-1
    }
    //确定某个月的第一天是星期
    func firstDayOfCurrentMonth() -> NSDate?{
        var startDate: NSDate?
        let ok = NSCalendar.currentCalendar().rangeOfUnit(NSCalendarUnit.Month, startDate: &startDate, interval: nil, forDate: self)
        assert(ok, "计算一个月的第一天是星期几失败")
        let zone = NSTimeZone.systemTimeZone()
        let interval = zone.secondsFromGMTForDate(self)
        return startDate!.dateByAddingTimeInterval(Double(interval))
    }

    func nextMonth() -> NSDate{
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        var date = NSDate()
        //得到年月的1号
        if((self.currentMonth+1)==13){
            date = dateFormatter.dateFromString("\(self.currentYear+1)-\(01)-01 23:59:59")!
        }
        else{
            date = dateFormatter.dateFromString("\(self.currentYear)-\(self.currentMonth+1)-01 23:59:59")!
        }
        return date
    }
    func prevMonth() -> NSDate{
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        var date = NSDate()
        //得到年月的1号
        if((self.currentMonth-1)==0){
            let str:String="\(self.currentYear-1)-\(12)-01 23:59:59"
            date = dateFormatter.dateFromString(str)!
        }else{
            let str:String="\(self.currentYear)-\(self.currentMonth-1)-01 23:59:59"
            date = dateFormatter.dateFromString(str)!
        }
        return date
    }

    /// 返回当前日期 年份
    var currentYear:Int{
        get{
            return getFormatDate("yyyy")
        }
    }
    /// 返回当前日期 月份
    var currentMonth:Int{
        get{
            return getFormatDate("MM")
        }
    }
    /// 返回当前日期 天
    var currentDay:Int{
        get{
            return getFormatDate("dd")
        }
    }
    /// 返回当前日期 小时
    var currentHour:Int{
        get{
            return getFormatDate("HH")
        }
    }
    /// 返回当前日期 分钟
    var currentMinute:Int{
        get{
            return getFormatDate("mm")
        }
    }
    /// 返回当前日期 秒数
    var currentSecond:Int{
        get{
            return getFormatDate("ss")
        }
    }

    /**
     获取yyyy  MM  dd  HH mm ss

     - parameter format: 比如 getFormatDate(yyyy) 返回当前日期年份

     - returns: 返回值
     */
    func getFormatDate(format:String)->Int{
        let dateFormatter:NSDateFormatter = NSDateFormatter();
        dateFormatter.dateFormat = format;
        let dateString:String = dateFormatter.stringFromDate(self);
        var dates:[String] = dateString.componentsSeparatedByString("")
        let Value  = dates[0]
        if(Value==""){
            return 0
        }
        return Int(Value)!
    }
}
