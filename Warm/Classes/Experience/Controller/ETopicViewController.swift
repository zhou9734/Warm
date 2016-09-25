//
//  ETopicViewController.swift
//  Warm
//
//  Created by zhoucj on 16/9/24.
//  Copyright © 2016年 zhoucj. All rights reserved.
//

import UIKit

let ETopicBaseCellReuseIdentifier = "ETopicBaseCellReuseIdentifier"
let ETopicBaseTagCellReuseIdentifier = "ETopicBaseTagCellReuseIdentifier"
class ETopicViewController: UIViewController {
    let experienceViewModel = ExperienceViewModel()
    var tagName: String?{
        didSet{
            title = tagName
        }
    }
    var tagid: Int64?{
        didSet{

        }
    }
    var page = 1
    var citycode: String?
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupRefresh()
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
    }

    private func setupRefresh(){
        tableView.header = MJRefreshNormalHeader(refreshingTarget: self, refreshingAction: Selector("loadExpData"))
        tableView.header.beginRefreshing()
        tableView.footer = MJRefreshAutoNormalFooter(refreshingTarget: self, refreshingAction: Selector("loadMoreData"))
        tableView.footer.hidden = true
    }

    lazy var tableView: UITableView = {
        let tv = UITableView(frame: self.view.bounds, style: .Plain)
        tv.registerClass(ETableViewNoTagCell.self, forCellReuseIdentifier: ETopicBaseCellReuseIdentifier)
        tv.registerClass(ETableViewTagCell.self, forCellReuseIdentifier: ETopicBaseTagCellReuseIdentifier)
        tv.dataSource = self
        tv.delegate = self
        tv.backgroundColor = UIColor.whiteColor()
        return tv
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
        experienceViewModel.filterExperienceData(nil, citycode: citycode!, page: page, count: pageSize, sort: 1, tagid: tagid) { (data, error) -> () in
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

}
//MARK: - UITableViewDataSource代理
extension ETopicViewController: UITableViewDataSource{
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
            let cell = tableView.dequeueReusableCellWithIdentifier(ETopicBaseTagCellReuseIdentifier, forIndexPath: indexPath) as! ETableViewTagCell
            cell.classes = _class
            return cell
        }
        let cell = tableView.dequeueReusableCellWithIdentifier(ETopicBaseCellReuseIdentifier, forIndexPath: indexPath) as! ETableViewNoTagCell
        cell.classes = _class
        return cell
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 305
    }
}
//MARK: - UITableViewDelegate代理
extension ETopicViewController: UITableViewDelegate{
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        //释放选中效果
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        let _class = experienceViewModel.classes[indexPath.row]
        let classesVC = ClassesViewController()
        classesVC.classesId = _class.id
        navigationController?.pushViewController(classesVC, animated: true)
    }
}
