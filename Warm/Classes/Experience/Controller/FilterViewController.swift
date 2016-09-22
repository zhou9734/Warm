//
//  FilterViewController.swift
//  Warm
//
//  Created by zhoucj on 16/9/21.
//  Copyright © 2016年 zhoucj. All rights reserved.
//

import UIKit

let EFilterTableBaseCellReuseIdentifier = "EFilterTableBaseCellReuseIdentifier"
let EFilterTableBaseTagCellReuseIdentifier = "EFilterTableBaseTagCellReuseIdentifier"
let ClosePopoverView = "ClosePopoverView"
let FilterExprienceData = "FilterExprienceData"

class FilterViewController: UIViewController {
    var experienceViewModel = ExperienceViewModel()
    var cityCode: String?
    var areaCode: String = "999"
    var page = 1
    var sortType = 1
    var tagid: Int = 999
    var popoverView = EPopoverView()
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "体验"
        setupUI()
        setupRefresh()
        NSNotificationCenter.defaultCenter().addObserver(self, selector:    Selector("closePopover:"), name: ClosePopoverView, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("filterExprienceData:"), name: FilterExprienceData, object: nil)
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
        view.addSubview(typeBtn)
        view.addSubview(leftSpliteView)
        view.addSubview(areaBtn)
        view.addSubview(rightSpliteView)
        view.addSubview(sortBtn)
        view.addSubview(tableView)
    }

    private lazy var tableView: UITableView = {
        let tv = UITableView(frame: CGRect(origin: CGPoint(x: 0, y: 109), size: ScreenBounds.size), style: .Plain)
        tv.registerClass(ETableViewNoTagCell.self, forCellReuseIdentifier: EFilterTableBaseCellReuseIdentifier)
        tv.registerClass(ETableViewTagCell.self, forCellReuseIdentifier: EFilterTableBaseTagCellReuseIdentifier)
        tv.dataSource = self
        tv.delegate = self
        tv.backgroundColor = UIColor.whiteColor()
        return tv
    }()
    let btnWidth: CGFloat =  (ScreenWidth - 2) / 3
    private lazy var typeBtn: CustomButton = {
        let btn = CustomButton()
        btn.setTitle("所有类别", forState: .Normal)
        btn.titleLabel?.textAlignment = .Center
        btn.frame = CGRect(x: 0 , y: 64, width: self.btnWidth, height: 45.0)
        btn.tag = 1
        btn.addTarget(self, action: Selector("openPopoverView:"), forControlEvents: .TouchUpInside)
        return btn
    }()
    private lazy var leftSpliteView : UIView = {
        let v = UIView(frame: CGRect(x: self.btnWidth, y: 64, width: 1.0, height: 45.0))
        v.backgroundColor = UIColor(red: 241.0/255.0, green: 241.0/255.0, blue: 241.0/255.0, alpha: 1)
        return v
    }()

    private lazy var areaBtn: CustomButton = {
        let btn = CustomButton()
        btn.setTitle("所有地区", forState: .Normal)
        btn.frame = CGRect(x: self.btnWidth + 1 , y: 64, width: self.btnWidth, height: 45.0)
        btn.titleLabel?.textAlignment = .Center
        btn.tag = 2
        btn.addTarget(self, action: Selector("openPopoverView:"), forControlEvents: .TouchUpInside)
        return btn
    }()
    private lazy var rightSpliteView : UIView = {
        let v = UIView(frame: CGRect(x: self.btnWidth * 2 + 1, y: 64, width: 1.0, height: 45.0))
        v.backgroundColor = UIColor(red: 241.0/255.0, green: 241.0/255.0, blue: 241.0/255.0, alpha: 1)
        return v
    }()
    private lazy var sortBtn: CustomButton = {
        let btn = CustomButton()
        btn.setTitle("最新", forState: .Normal)
        btn.frame = CGRect(x: (self.btnWidth + 1) * 2 , y: 64, width: self.btnWidth, height: 45.0)
        btn.titleLabel?.textAlignment = .Center
        btn.tag = 3
        btn.addTarget(self, action: Selector("openPopoverView:"), forControlEvents: .TouchUpInside)
        return btn
    }()
    private func setupRefresh(){
        tableView.header = MJRefreshNormalHeader(refreshingTarget: self, refreshingAction: Selector("loadExpData"))
        tableView.header.beginRefreshing()
        tableView.footer = MJRefreshAutoNormalFooter(refreshingTarget: self, refreshingAction: Selector("loadMoreData"))
        tableView.footer.hidden = true
    }
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
        experienceViewModel.filterExperienceData(areaCode, citycode: cityCode!, page: page, count: pageSize, sort: sortType, tagid: tagid) { (data, error) -> () in
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

    @objc private func openPopoverView(btn: UIButton){
        if btn.selected {
            popoverView.hide()
            btn.selected = false
            return
        }
        if btn.tag == 1 {
            popoverView.filterType = btn.tag
            popoverView.selectedKey = "\(tagid)"
            popoverView.data = experienceViewModel.loadDictDataByFile("TagType")
            popoverView.showInView(view)
        }else if btn.tag == 2{
            unowned let tmpSelf = self
            experienceViewModel.loadAreasByCityCode(cityCode!, finished: { (data, error) -> () in
                tmpSelf.popoverView.selectedKey = tmpSelf.areaCode
                tmpSelf.popoverView.filterType = btn.tag
                tmpSelf.popoverView.data = tmpSelf.experienceViewModel.areas
                tmpSelf.popoverView.showInView(tmpSelf.view)
            })
        }else if btn.tag == 3{
            popoverView.selectedKey = "\(sortType)"
            popoverView.filterType = btn.tag
            popoverView.data = experienceViewModel.loadDictDataByFile("SortType")
            popoverView.showInView(view)
        }
        btn.selected = true
    }

    @objc private func closePopover(notice: NSNotification){
        if let filterType = notice.object as? Int {
            if filterType == 1{
                typeBtn.selected = false
            }else if filterType == 2{
                areaBtn.selected = false
            }else if filterType == 3{
                sortBtn.selected = false
            }
        }
    }
    @objc private func filterExprienceData(notice: NSNotification){
        //刷新
        guard let code = notice.userInfo!["code"] as? Int else{
            return
        }
        guard let type = notice.userInfo!["type"] as? Int else{
            return
        }
        if type == 1{
            if code != 999{
                tagid = code
            }
        }else if type == 2{
            if code != 999{
                areaCode = "\(code)"
            }
        }else if type == 3{
            sortType = code
        }
        tableView.header.beginRefreshing()

    }
    deinit{
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
}
//MARK: - UITableViewDataSource代理
extension FilterViewController: UITableViewDataSource{
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
            let cell = tableView.dequeueReusableCellWithIdentifier(EFilterTableBaseTagCellReuseIdentifier, forIndexPath: indexPath) as! ETableViewTagCell
            cell.classes = _class
            return cell
        }
        let cell = tableView.dequeueReusableCellWithIdentifier(EFilterTableBaseCellReuseIdentifier, forIndexPath: indexPath) as! ETableViewNoTagCell
        cell.classes = _class
        return cell
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 305
    }
}
//MARK: - UITableViewDelegate代理
extension FilterViewController: UITableViewDelegate{
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        //释放选中效果
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        CJLog("didSelectRowAtIndexPath")
    }
}
