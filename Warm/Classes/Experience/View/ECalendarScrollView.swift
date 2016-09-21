//
//  CalendarScrollView.swift
//  Calendar
//
//  Created by zhoucj on 16/9/20.
//  Copyright © 2016年 zhoucj. All rights reserved.
//

import UIKit
let ECalendarScrollSelectedDate = "ECalendarScrollSelectedDate"
class ECalendarScrollView: UIScrollView {
    private let pageWidth = UIScreen.mainScreen().bounds.width
    private let calendarView0: ECalendarView = ECalendarView()
    private let calendarView1: ECalendarView = ECalendarView()
    private let calendarView2: ECalendarView = ECalendarView()
    var nowDate: NSDate = NSDate()
    var doChangeDate: ((nowDate: NSDate)->())?
    var selectedDate = NSDate()
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(scrollView)
        updateImageData()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("doSelectedDate:"), name: ECalendarScrollSelectedDate, object: nil)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private lazy var scrollView: UIScrollView = {
        //scrollView的初始化
        let scrollView = UIScrollView()
        scrollView.frame = self.frame
        let pageHeight = self.frame.height
        //为了让内容横向滚动，设置横向内容宽度为3个页面的宽度总和
        scrollView.contentSize=CGSizeMake(CGFloat(self.pageWidth*3),
            pageHeight)
        scrollView.pagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.scrollsToTop = false
        scrollView.delegate = self
        self.calendarView0.frame = CGRect(x: 0, y: 0, width: self.pageWidth, height: pageHeight)
        self.calendarView1.frame = CGRect(x: self.pageWidth, y: 0, width: self.pageWidth, height: pageHeight)
        self.calendarView2.frame = CGRect(x: self.pageWidth * 2, y: 0, width: self.pageWidth, height: pageHeight)
        scrollView.addSubview(self.calendarView0)
        scrollView.addSubview(self.calendarView1)
        scrollView.addSubview(self.calendarView2)
        return scrollView
    }()
    @objc private func doSelectedDate(notice: NSNotification){
        if let dateStr = notice.object as? String {
            selectedDate = NSDate.createDate(dateStr, formatterStr: "yyyy-MM-dd")
            NSNotificationCenter.defaultCenter().postNotificationName(SeletedDateChageNotication, object: dateStr)
            calendarView0.selectedDate = selectedDate
            calendarView1.selectedDate = selectedDate
            calendarView2.selectedDate = selectedDate
        }
    }

    deinit{
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
}
extension ECalendarScrollView: UIScrollViewDelegate{
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        let ratio = scrollView.contentOffset.x/scrollView.frame.size.width
        self.endScrollMethod(ratio)
    }
    func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if !decelerate{
            let ratio = scrollView.contentOffset.x/scrollView.frame.size.width
            endScrollMethod(ratio)
        }
    }
    private func endScrollMethod(ratio:CGFloat){
        if ratio <= 0.7{
            nowDate = nowDate.prevMonth()
        }
        if ratio >= 1.3{
            nowDate = nowDate.nextMonth()
        }
        doChangeDate?(nowDate: nowDate)
        updateImageData()
    }
    //MARK: - reload data
    private func updateImageData(){
        calendarView0.nowDate = nowDate.prevMonth()
        calendarView1.nowDate = nowDate
        calendarView2.nowDate = nowDate.nextMonth()
        calendarView0.selectedDate = selectedDate
        calendarView1.selectedDate = selectedDate
        calendarView2.selectedDate = selectedDate
        scrollView.contentOffset = CGPoint(x: scrollView.frame.size.width, y: 0)
    }
}

