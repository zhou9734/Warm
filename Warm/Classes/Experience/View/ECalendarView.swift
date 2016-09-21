//
//  CalendarView.swift
//  Calendar
//
//  Created by zhoucj on 16/9/20.
//  Copyright © 2016年 zhoucj. All rights reserved.
//

import UIKit

class ECalendarView: UIView {
    let days = ["一", "二", "三", "四", "五", "六", "日"]
    let btnWidth = ScreenWidth / 7.0
    var selectedDate = NSDate(){
        didSet{
            changeSelectedDateBtn(selectedDate)
        }
    }
    var nowDate: NSDate = NSDate(){
        didSet{
            createCalendar(nowDate)
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func setupUI(){
        backgroundColor = UIColor.whiteColor()
        nowDate = NSDate()
    }
    //MARK: - 创建日历
    private func createCalendar(date: NSDate){
        for i in subviews{
            i.removeFromSuperview()
        }
        for i in 0..<days.count{
            let btn = UIButton()
            btn.setTitle(days[i], forState: .Normal)
            btn.setTitleColor(UIColor.blackColor(), forState: .Normal)
            btn.titleLabel?.font = UIFont.systemFontOfSize(17)
            btn.frame = CGRect(x: CGFloat(i) * btnWidth, y: 10, width: btnWidth - 20, height: btnWidth - 20)
            addSubview(btn)
        }

        let dayOfMonth = date.numberOfDayInCurrentMonth()
        let firstDayOfMonth = date.firstDayOfCurrentMonth()
        let firstweek = firstDayOfMonth!.firstWeekOfMonth()

        let prevMonthDate = nowDate.prevMonth()
        let prevMonthDays = prevMonthDate.numberOfDayInCurrentMonth()

        var index = 1
        var inIndex = 1
        for i in 0..<42{
            let btn = UIButton()
            btn.titleLabel?.font = UIFont.systemFontOfSize(17)
            let y = (CGFloat(i / 7) + 1)*(btnWidth - 19)
            btn.frame = CGRect(x: CGFloat(i % 7) * btnWidth, y: y, width: btnWidth - 20, height: btnWidth - 20)
            //上一个月的日历
            if i < firstweek - 1{
                let tmpIndex = prevMonthDays - (firstweek - 1 - (i + 1))
                btn.setTitle("\(tmpIndex)", forState: .Normal)
                btn.setTitleColor(UIColor.grayColor(), forState: .Normal)
                btn.tag = tmpIndex
                addSubview(btn)
                continue
            }

            let sum = (dayOfMonth + firstweek - 1)
            if i >= sum{
                //下一个月的日历
                btn.setTitle("\(inIndex)", forState: .Normal)
                btn.setTitleColor(UIColor.grayColor(), forState: .Normal)
                btn.tag = inIndex
                inIndex = inIndex + 1
            }else{
                btn.setTitle("\(index)", forState: .Normal)
                btn.setTitleColor(UIColor.blackColor(), forState: .Normal)
                btn.addTarget(self, action: Selector("dateBtnClick:"), forControlEvents: .TouchUpInside)
                btn.tag = index
            }
            if currentDay == index && date.currentYear == currentYear && date.currentMonth == currentMonth{
                btn.layer.cornerRadius = (btnWidth - 20)/2
                btn.layer.masksToBounds = true
                btn.backgroundColor = UIColor.orangeColor()
                btn.setTitleColor(UIColor.whiteColor(), forState: .Normal)
                btn.addTarget(self, action: Selector("dateBtnClick:"), forControlEvents: .TouchUpInside)
                btn.tag = index
            }

            addSubview(btn)
            index = index + 1
        }

//        changeSelectedDateBtn(selectedDate)
    }

    @objc private func dateBtnClick(btn: UIButton){
        resetAllBtn()
        btn.layer.borderColor = UIColor.orangeColor().CGColor
        btn.layer.borderWidth = 1
        btn.layer.cornerRadius = (btnWidth - 20)/2
        btn.layer.masksToBounds = true
        let selectedDate = "\(nowDate.formatterData("yyyy-MM"))-\(btn.tag)"
        NSNotificationCenter.defaultCenter().postNotificationName(ECalendarScrollSelectedDate, object: selectedDate)
    }
    private func resetAllBtn(){
        for i in subviews{
            let btn = i as! UIButton
            if (currentDay == btn.tag && nowDate.currentYear == currentYear && nowDate.currentMonth == currentMonth){
                continue
            }
            btn.layer.cornerRadius = 0
            btn.layer.masksToBounds = false
            btn.layer.borderWidth = 0
        }
    }
    private func changeSelectedDateBtn(selectedDate: NSDate){
        let _sdate = selectedDate
        if nowDate == _sdate{
            return
        }
        //当前月的第一个星期有几天
        let firstDayOfMonth = nowDate.firstDayOfCurrentMonth()
        let firstweek = firstDayOfMonth!.firstWeekOfMonth()
        //当前月一个用多少天
        let dayOfMonth = nowDate.numberOfDayInCurrentMonth()
        let tmp = nowDate.currentMonth - _sdate.currentMonth
        if tmp == 1{
            //上一个月
            for i in 6..<firstweek + 6{
                let btn = subviews[i] as! UIButton
                if btn.tag == _sdate.currentDay{
                    btn.layer.borderColor = UIColor.orangeColor().CGColor
                    btn.layer.borderWidth = 1
                    btn.layer.cornerRadius = (btnWidth - 20)/2
                    btn.layer.masksToBounds = true
                }
            }
        }else if tmp == -1{
            let sum = (dayOfMonth + firstweek - 1 + 6)
            //下一个月
            for i in sum..<subviews.count{
                let btn = subviews[i] as! UIButton
                if btn.tag == _sdate.currentDay{
                    btn.layer.borderColor = UIColor.orangeColor().CGColor
                    btn.layer.borderWidth = 1
                    btn.layer.cornerRadius = (btnWidth - 20)/2
                    btn.layer.masksToBounds = true
                }
            }
        }else if tmp == 0{
            let sum = (dayOfMonth + firstweek - 1 + 6)
            for i in (firstweek + 6)...sum{
                let btn = subviews[i] as! UIButton
                if btn.tag == _sdate.currentDay{
                    btn.layer.borderColor = UIColor.orangeColor().CGColor
                    btn.layer.borderWidth = 1
                    btn.layer.cornerRadius = (btnWidth - 20)/2
                    btn.layer.masksToBounds = true
                }
            }
        }
    }
}
