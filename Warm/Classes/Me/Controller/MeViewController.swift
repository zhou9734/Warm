//
//  MeViewController.swift
//  Warm
//
//  Created by zhoucj on 16/9/12.
//  Copyright © 2016年 zhoucj. All rights reserved.
//

import UIKit
let MeTableCellReuseIdentifier = "MeTableCellReuseIdentifier"
let SettingClickNotication = "settingClickNotication"
class MeViewController: UIViewController {
    let meViewModel = MeViewModel()
    var wmenus =  [WMenu]()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("openSetting"), name: SettingClickNotication, object: nil)
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        //隐藏navigationBar
        navigationController?.navigationBarHidden = true
        tableHeadView.token = Token.loadAccount()
    }

    private func setupUI(){
        wmenus = meViewModel.loadData()
        tableFooterView.menu = wmenus.last!.menus!.first
        view.addSubview(tableView)
        tableView.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(view.snp_top).offset(-20)
            make.left.right.bottom.equalTo(view)
        }
    }

    private lazy var tableView: UITableView = {
        let tv = UITableView(frame: CGRectZero,style: .Plain)
        tv.registerClass(UITableViewCell.self, forCellReuseIdentifier: MeTableCellReuseIdentifier)
        tv.dataSource = self
        tv.delegate = self
        tv.backgroundColor = UIColor.whiteColor()
        tv.tableHeaderView = self.tableHeadView
        tv.tableFooterView = self.tableFooterView
        return tv
    }()

    private lazy var tableHeadView: MeTableHeadView = MeTableHeadView(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: ScreenHeight*0.3))
    private lazy var tableFooterView: MeTableFooterView = MeTableFooterView(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: 76))

    @objc private func openSetting(){
        navigationController?.pushViewController(SettingViewController(), animated: true)
    }
    private func detail(index: Int){
        let detailVC = DetailViewController()
        if let menu = wmenus[0].menus?[index] {
            detailVC.titleName = menu.name
        }
        navigationController?.pushViewController(detailVC, animated: true)
    }
    deinit{
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
}
//MARK: - UITableViewDataSource代理
extension MeViewController: UITableViewDataSource{
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return wmenus[0].menus?.count ?? 0
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(MeTableCellReuseIdentifier, forIndexPath: indexPath)
        if let menu = wmenus[0].menus?[indexPath.row] {
            cell.imageView?.image = UIImage(named: menu.image!)
            cell.textLabel?.text = menu.name
        }
        cell.imageView?.frame.size = CGSize(width: 24.0, height: 24.0)
        cell.textLabel?.font = UIFont.systemFontOfSize(15)
        cell.textLabel?.textColor = UIColor.lightGrayColor()
        //设置cell后面箭头样式
        cell.accessoryType = .DisclosureIndicator;
        //设置选中cell样式
        cell.selectionStyle = .Gray;
        return cell
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 55
    }
}
//MARK: - UITableViewDelegate代理
extension MeViewController: UITableViewDelegate{

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath){
        //释放选中效果
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        detail(indexPath.row)
    }
}
