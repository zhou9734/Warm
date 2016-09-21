//
//  HomeViewController.swift
//  Warm
//
//  Created by zhoucj on 16/9/12.
//  Copyright © 2016年 zhoucj. All rights reserved.
//

import UIKit

let RoundImageClick = "RoundImageClick"
let RecommendImageClick = "RecommendImageClick"
let HomeTableReuseIdentifier = "HomeTableReuseIdentifier"

class HomeViewController: BaseViewController {
    let homeViewModel = HomeViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupRefresh()
    }
    //设置组件
    private func setupUI(){
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: leftBtn)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: rightBtn)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("roundImageClick:"), name: RoundImageClick, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("recommendImageClick:"), name: RecommendImageClick, object: nil)
        view.addSubview(tableView)
    }
    private func setupRefresh(){
        tableView.header = MJRefreshNormalHeader(refreshingTarget: self, refreshingAction: Selector("loadHomeData"))
        tableView.header.beginRefreshing()
        tableView.footer = MJRefreshAutoNormalFooter(refreshingTarget: self, refreshingAction: Selector("loadMoreData"))
        tableView.footer.hidden = true
    }
    @objc private func loadHomeData(){
        page = 1
        homeViewModel.resetData()
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
    private func loadData(finished:()->()){
        unowned let tmpSelf = self
        homeViewModel.loadHomeData(citycode, page: page) { (data, error) -> () in
            // 安全校验
            if error != nil{
                alert("获取数据失败")
                return
            }
            finished()
            tmpSelf.page = tmpSelf.page + 1
            tmpSelf.tableView.reloadData()
            tmpSelf.tableHeadView.rounds = tmpSelf.homeViewModel.rounds
            tmpSelf.tableHeadView.recommends = tmpSelf.homeViewModel.recommends
        }
    }
    //MARK: - 懒加载
    //左边按钮
    private lazy var leftBtn: UIButton = UIButton(target: self, backgroundImage: "navigationMessageNormal_21x22_", action: Selector("leftBtnClick"))
    //右边按钮
    private lazy var rightBtn: UIButton = UIButton(target: self, backgroundImage: "icnavwrite_g_23x24_", action: Selector("rightBtnClick"))
    lazy var tableView: UITableView = {
        let tv = UITableView(frame: self.view.bounds, style: .Plain)
        tv.registerClass(HomeTableViewCell.self, forCellReuseIdentifier: HomeTableReuseIdentifier)
        tv.dataSource = self
        tv.delegate = self
        tv.backgroundColor = UIColor.whiteColor()
        tv.tableHeaderView = self.tableHeadView
        return tv
    }()
    private lazy var tableHeadView = HomeTableHeaderView(frame: CGRect(origin: CGPointZero, size: CGSize(width: ScreenWidth, height: 325)))
    //左边按钮点击事件
    @objc private func leftBtnClick(){
        if isLogin() {
            return
        }
        navigationController?.pushViewController(MessageViewController(), animated: true)
    }
    //右边按钮点击事件
    @objc private func rightBtnClick(){
        if isLogin() {
            return
        }
        navigationController?.pushViewController(TopicViewController(), animated: true)
    }
    @objc private func roundImageClick(notice: NSNotification){
        guard let index = notice.userInfo!["index"] as? Int else{
            return
        }
        CJLog(index)
    }
    @objc private func recommendImageClick(notice: NSNotification){
        guard let index = notice.userInfo!["index"] as? Int else{
            return
        }
        CJLog(index)
    }

    private func isLogin() -> Bool{
        if !Token.isLogin() {
            NSNotificationCenter.defaultCenter().postNotificationName(LoginNotication, object: self)
            return true
        }
        return false
    }
    deinit{
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
}
extension HomeViewController: UITableViewDataSource{
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let footer = tableView.footer{
            footer.hidden = homeViewModel.salons.count == 0
        }
        return homeViewModel.salons.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(HomeTableReuseIdentifier, forIndexPath: indexPath) as! HomeTableViewCell
        cell.salon = homeViewModel.salons[indexPath.row]
        return cell
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 245
    }
}
extension HomeViewController: UITableViewDelegate{
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        CJLog("didSelectRowAtIndexPath")
    }
}
