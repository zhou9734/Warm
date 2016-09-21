//
//  MessageViewController.swift
//  Warm
//
//  Created by zhoucj on 16/9/19.
//  Copyright © 2016年 zhoucj. All rights reserved.
//

import UIKit
let MessageTableCellReuseIdentifier = "MessageTableCellReuseIdentifier"
class MessageViewController: UIViewController {
    var data: [Menu] = [Menu](){
        didSet{
            tableView.reloadData()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "消息"
        view.backgroundColor = Color_GlobalBackground
        view.addSubview(tableView)
        loadData()
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        var textAttrs: [String : AnyObject] = Dictionary()
        textAttrs[NSForegroundColorAttributeName] = UIColor.blackColor()
        textAttrs[NSFontAttributeName] = UIFont.systemFontOfSize(17)
        navigationController?.navigationBar.titleTextAttributes = textAttrs
    }
    private lazy var tableView: UITableView = {
        let tv = UITableView(frame: self.view.bounds, style: .Plain)
        tv.registerClass(UITableViewCell.self, forCellReuseIdentifier: MessageTableCellReuseIdentifier)
        tv.dataSource = self
        tv.delegate = self
        tv.backgroundColor = Color_GlobalBackground
        return tv
    }()

    private func loadData(){
        let dict: [[String: String]] = [["image": "shalonMessage_40x41_", "name": "话题消息"],["image": "officialMessage_40x40_", "name": "官方消息"],["image": "courseMessage_40x40_", "name": "体验消息"]]
        var _menus = [Menu]()
        for i in dict {
            let menu = Menu(dict: i)
            _menus.append(menu)
        }
        data = _menus
    }

}
extension MessageViewController: UITableViewDataSource{
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(MessageTableCellReuseIdentifier, forIndexPath: indexPath) as UITableViewCell
        let menu = data[indexPath.row]
        cell.imageView?.image = UIImage(named: menu.image!)
        cell.textLabel?.text = menu.name
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
        return 60
    }

}
extension MessageViewController: UITableViewDelegate{
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath){
        //释放选中效果
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        let msgDetailViewController = MsgDetailViewController()
        msgDetailViewController.titleName = data[indexPath.row].name
        navigationController?.pushViewController(msgDetailViewController, animated: true)
    }
}
