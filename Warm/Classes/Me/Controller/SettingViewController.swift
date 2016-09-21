//
//  SettingViewController.swift
//  Warm
//
//  Created by zhoucj on 16/9/18.
//  Copyright © 2016年 zhoucj. All rights reserved.
//

import UIKit

let SettingTableCellReuseIdentifie = "SettingTableCellReuseIdentifie"
class SettingViewController: UIViewController {
    let marginLeft: CGFloat = 20
    let token = Token.loadAccount()
    let meViewModel = MeViewModel()
    var settings =  [WSetting]()
    override func viewDidLoad() {
        super.viewDidLoad()
        settings = meViewModel.loadSetting()
        setupUI()
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
        navigationItem.title = "设置与帮助"
        view.backgroundColor = UIColor(red: 241.0/255.0, green: 241.0/255.0, blue: 241.0/255.0, alpha: 1)
        view.addSubview(tableView)
        view.addSubview(exitBtn)
    }
    private lazy var tableView: UITableView = {
        let tv = UITableView(frame: CGRect(x: 0, y: 15, width: ScreenWidth, height: ScreenHeight - 50),style: .Plain)
        tv.registerClass(SettingTableViewCell.self, forCellReuseIdentifier: SettingTableCellReuseIdentifie)
        tv.dataSource = self
        tv.delegate = self
        tv.backgroundColor = UIColor(red: 241.0/255.0, green: 241.0/255.0, blue: 241.0/255.0, alpha: 1)
        tv.tableHeaderView = self.tableHeadView        
        return tv
    }()
    private lazy var tableHeadView: SettingHeaderView = SettingHeaderView(frame: CGRect(x: 0, y: 20, width: ScreenWidth, height: 80.0))
    private lazy var exitBtn: UIButton = {
        let btn = UIButton()
        btn.frame = CGRect(x: 0, y: ScreenHeight - 50, width: ScreenWidth, height: 50.0)
        btn.setTitle("退出登录", forState: .Normal)
        btn.setTitleColor(UIColor.redColor(), forState: .Normal)
        btn.backgroundColor = UIColor.whiteColor()
        return btn
    }()
    private func cleanViewController(){
        unowned let tmpSelf = self
        FileTool.cleanFolderAsync("".cachesDir()) { () -> () in
            tmpSelf.tableView.reloadData()
        }
    }

    private func openAbout(){
        presentViewController(AboutViewController(), animated: true, completion: nil)
    }

}
//MARK: - UITableViewDataSource代理
extension SettingViewController: UITableViewDataSource{
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 3
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if 0 == section {
            return 2
        } else if (1 == section) {
            return 2
        } else {
            return 3
        }
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var _index = 0
        if indexPath.section == 0{
            _index = indexPath.row
        }else if indexPath.section == 1{
            _index = indexPath.row + 2
        }else if indexPath.section == 2{
            _index = indexPath.row + 4
        }
        let cell = tableView.dequeueReusableCellWithIdentifier(SettingTableCellReuseIdentifie, forIndexPath: indexPath) as! SettingTableViewCell
        cell.setting = settings[_index]
        if _index == 0 || _index == 1 || _index == 3{
            cell.type = 0
        }else if _index == 2{
            cell.type = 1
        }else {
            cell.type = 2
        }
        //设置选中cell样式
        cell.selectionStyle = .Gray;
        return cell
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 45
    }
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat{
        return 10
    }

    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat{
        return 0.1
    }

}
//MARK: - UITableViewDelegate代理
extension SettingViewController: UITableViewDelegate{

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath){
        //释放选中效果
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        if indexPath.section == 1{
            if indexPath.row == 0{
                alert("请到iPhone的\"设置\"-\"通知\"功能中找到应用程序\"取暖\"更改")
            }
            if indexPath.row == 1{
                cleanViewController()
            }
        }else if indexPath.section == 2{
            if indexPath.row == 0{
                openAbout()
            }
        }
    }
}

