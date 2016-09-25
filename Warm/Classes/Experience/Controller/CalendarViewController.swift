//
//  CalendarViewController.swift
//  Warm
//
//  Created by zhoucj on 16/9/20.
//  Copyright © 2016年 zhoucj. All rights reserved.
//

import UIKit

let currentYear: Int = NSDate().currentYear
let currentMonth: Int = NSDate().currentMonth
let currentDay: Int = NSDate().currentDay
let SeletedDateChageNotication = "SeletedDateChageNotication"
let ECalendarTableBaseCellReuseIdentifier = "ECalendarTableBaseCellReuseIdentifier"
let ECalendarTableBaseTagCellReuseIdentifier = "ECalendarTableBaseTagCellReuseIdentifier"
class CalendarViewController: UIViewController {
    let experienceViewModel = ExperienceViewModel()
    var cityCode: String?
    var page = 1
    let months = ["一月", "二月", "三月", "四月", "五月", "六月", "七月", "八月", "九月", "十月", "十一月", "十二月"]
    var selectedDate: NSDate = NSDate()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupRefresh()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("doSelectedDate:"), name: SeletedDateChageNotication, object: nil)
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBarHidden = false
        var textAttrs: [String : AnyObject] = Dictionary()
        textAttrs[NSForegroundColorAttributeName] = UIColor.blackColor()
        textAttrs[NSFontAttributeName] = UIFont.systemFontOfSize(17)
        navigationController?.navigationBar.titleTextAttributes = textAttrs
    }

    private func setupUI(){
        view.backgroundColor = UIColor.whiteColor()
        title = "体验 | \(months[NSDate().currentMonth-1])"
        view.addSubview(tableView)
        dateLbl.text = NSDate().formatterData("MM月dd日")
        unowned let tmpSelf = self
        calendarScrollView.doChangeDate = {(nowDate) in
            tmpSelf.title = "体验 | \(tmpSelf.months[nowDate.currentMonth-1])"
        }
    }

    private func setupRefresh(){
        tableView.header = MJRefreshNormalHeader(refreshingTarget: self, refreshingAction: Selector("loadExpData"))
        tableView.header.beginRefreshing()
        tableView.footer = MJRefreshAutoNormalFooter(refreshingTarget: self, refreshingAction: Selector("loadMoreData"))
        tableView.footer.hidden = true
    }

    private lazy var tableView: UITableView = {
        let tv = UITableView(frame: self.view.bounds, style: .Plain)
        tv.registerClass(ETableViewNoTagCell.self, forCellReuseIdentifier: ECalendarTableBaseCellReuseIdentifier)
        tv.registerClass(ETableViewTagCell.self, forCellReuseIdentifier: ECalendarTableBaseTagCellReuseIdentifier)
        tv.dataSource = self
        tv.delegate = self
        tv.backgroundColor = UIColor.whiteColor()
        let _headView = UIView(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: ScreenHeight * 0.42))
        _headView.backgroundColor = UIColor(red: 241.0/255.0, green: 241.0/255.0, blue: 241.0/255.0, alpha: 1)
        _headView.addSubview(self.calendarScrollView)
        _headView.addSubview(self.dateLbl)
        tv.tableHeaderView = _headView
        return tv
    }()
    
    private lazy var calendarScrollView: ECalendarScrollView = ECalendarScrollView(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: ScreenHeight * 0.38))

    private lazy var dateLbl: UILabel = {
        let lbl = UILabel()
        lbl.textColor = UIColor.darkGrayColor()
        lbl.textAlignment = .Left
        lbl.font = UIFont.systemFontOfSize(15)
        lbl.frame = CGRect(x: 20, y: ScreenHeight * 0.38 + 5, width: 200, height: 20)
        return lbl
    }()

    @objc private func loadExpData(){
        page = 1
        experienceViewModel.resetData()
        unowned let tmpSelf = self
        loadData { () -> () in
            tmpSelf.tableView.header.endRefreshing()
        }
    }

    @objc private func loadMoreData(){
        unowned let tmpSelf = self
        loadData { () -> () in
            tmpSelf.tableView.footer.endRefreshing()
        }
    }
    //MARK: - 获取体验数据
    private func loadData(finished:()->()){
        unowned let tmpSelf = self
        experienceViewModel.loadECalendarData(cityCode!, page: page, count: pageSize, date: selectedDate.formatterData("yy-MM-dd")) { (data, error) -> () in
            // 安全校验
            if error != nil{
                alert("获取数据失败")
                return
            }
            finished()
            tmpSelf.page = tmpSelf.page + 1
            tmpSelf.tableView.reloadData()
        }
    }

    @objc private func doSelectedDate(notice: NSNotification){
        if let dateStr = notice.object as? String {
            selectedDate = NSDate.createDate(dateStr, formatterStr: "yyyy-MM-dd")
            dateLbl.text = selectedDate.formatterData("MM月dd日")
            tableView.header.beginRefreshing()
        }
    }

    deinit{
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
}
extension CalendarViewController: UITableViewDataSource{
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let footer = tableView.footer{
            footer.hidden = experienceViewModel.classes.count == 0
        }
        return experienceViewModel.classes.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let _class = experienceViewModel.classes[indexPath.row]
        if let tags_hd = _class.tags_bd where tags_hd.count > 0{
            let cell = tableView.dequeueReusableCellWithIdentifier(ECalendarTableBaseTagCellReuseIdentifier, forIndexPath: indexPath) as! ETableViewTagCell
            cell.classes = _class
            return cell
        }
        let cell = tableView.dequeueReusableCellWithIdentifier(ECalendarTableBaseCellReuseIdentifier, forIndexPath: indexPath) as! ETableViewNoTagCell
        cell.classes = _class
        return cell
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 305
    }
}
extension CalendarViewController: UITableViewDelegate{
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        //释放选中效果
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        let _class = experienceViewModel.classes[indexPath.row]
        let classesVC = ClassesViewController()
        classesVC.classesId = _class.id
        navigationController?.pushViewController(classesVC, animated: true)
    }
}

