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
let FilterExprienceData = "FilterExprienceData"
let ChageHeadView = "ChageHeadView"
class FilterViewController: UIViewController {
    var experienceViewModel = ExperienceViewModel()
    var cityCode: String?
    var areaCode: Int64 = 999
    var page = 1
    var sortType: Int64 = 1
    var tagid: Int64 = 999
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "体验"
        setupUI()
        setupRefresh()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("filterExprienceData:"), name: FilterExprienceData, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("chageHeadView:"), name: ChageHeadView, object: nil)
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
        view.addSubview(tableView)
        headerView.cityCode = cityCode
        headerView.experienceViewModel = experienceViewModel
        noDataView.hidden = true
        view.addSubview(noDataView)
        view.addSubview(headerView)
    }

    private lazy var tableView: UITableView = {
        let tv = UITableView(frame: CGRect(origin: CGPoint(x: 0, y: 50), size: ScreenBounds.size), style: .Plain)
        tv.registerClass(ETableViewNoTagCell.self, forCellReuseIdentifier: EFilterTableBaseCellReuseIdentifier)
        tv.registerClass(ETableViewTagCell.self, forCellReuseIdentifier: EFilterTableBaseTagCellReuseIdentifier)
        tv.dataSource = self
        tv.delegate = self
        tv.backgroundColor = UIColor.whiteColor()
        return tv
    }()
    //顶部条件视图
    private lazy var headerView = EFilterHeadView(frame: CGRect(x: 0 , y: 64, width: ScreenWidth, height: 45.0))
    //没有找到数据视图
    private lazy var noDataView = EFindDataView(frame: CGRect(origin: CGPoint(x: 0, y: 98), size: ScreenBounds.size))
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
            if tmpSelf.experienceViewModel.classes.count == 0{
                tmpSelf.noDataView.hidden = false
            }else{
                tmpSelf.noDataView.hidden = true
            }
        }
    }

    @objc private func chageHeadView(notice: NSNotification){
        guard let isShow = notice.object as? Bool else{
            return
        }
        var rect = CGRect(x: 0 , y: 64, width: ScreenWidth, height: 45.0)
        if isShow {
            rect = CGRect(origin: CGPoint(x: 0, y: 64), size: ScreenBounds.size)
        }
        headerView.frame = rect
    }

    @objc private func filterExprienceData(notice: NSNotification){
        //刷新
        guard let codeStr = notice.userInfo!["code"] as? String else{
            return
        }
        guard let typeStr = notice.userInfo!["type"] as? String else{
            return
        }
        let type = Int64(typeStr)!
        let code = Int64(codeStr)!
        if type == 1{
            tagid = code
        }else if type == 2{
            areaCode = code
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
        let _class = experienceViewModel.classes[indexPath.row]
        let classesVC = ClassesViewController()
        classesVC.classesId = _class.id
        navigationController?.pushViewController(classesVC, animated: true)
    }
}
