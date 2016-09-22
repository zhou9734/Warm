//
//  EPopoverView.swift
//  Warm
//
//  Created by zhoucj on 16/9/21.
//  Copyright © 2016年 zhoucj. All rights reserved.
//

import UIKit
let EPopoverReuseIdentifier = "EPopoverReuseIdentifier"
class EPopoverView: UIView {
    var data: [WDict] = [WDict](){
        didSet{
            tableView.reloadData()
        }
    }
    var selectedKey: String?
    var containerBtn: UIButton?
    var filterType: Int?
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func setupUI(){
        containerBtn = UIButton()
        containerBtn!.backgroundColor = UIColor(white: 0.2, alpha: 0.3)
        containerBtn!.addTarget(self, action: Selector("dismissViewClick"), forControlEvents: .TouchUpInside)
        containerBtn!.alpha = 1
        containerBtn!.addSubview(tableView)
        //必须把tableView放到最前面不然tableView不会响应点击事件
        containerBtn!.bringSubviewToFront(tableView)
    }
    //MARK: - tableView
    private lazy var tableView: UITableView = {
        let tbv = UITableView(frame: CGRectZero, style: .Plain)
        tbv.registerClass(EPopoverTableCell.self, forCellReuseIdentifier: EPopoverReuseIdentifier)
        tbv.dataSource = self
        tbv.delegate = self
        return tbv
    }()
    //展示
    func showInView(_view: UIView){
        containerBtn!.frame = CGRect(origin: CGPoint(x: 0, y: 0), size: ScreenBounds.size)
        frame = CGRect(origin: CGPoint(x: 0, y: 109), size: ScreenBounds.size)
        addSubview(containerBtn!)
        _view.addSubview(self)
        var _height = CGFloat(data.count * 45)
        if data.count >= 5{
            _height = CGFloat(5 * 45)
        }
        let _width = UIScreen.mainScreen().bounds.width
        tableView.frame = CGRectMake(0, -_height, _width, _height)
        unowned let tmpSelf = self
        UIView.animateWithDuration(0.5) { () -> Void in
            tmpSelf.tableView.transform = CGAffineTransformMakeTranslation(0, _height)
        }
    }
    //隐藏
    func hide(){
        dismissViewClick()
    }

    @objc private func dismissViewClick(){
        unowned let tmpSelf = self
        UIView.animateWithDuration(0.5, animations: {
            tmpSelf.tableView.transform = CGAffineTransformMakeTranslation(0, 0)
            }, completion: { (Bool) -> Void in
                tmpSelf.removeFromSuperview()
                NSNotificationCenter.defaultCenter().postNotificationName(ClosePopoverView, object: tmpSelf.filterType)
        })
    }
}
//MARK: - UITableViewDataSource代理
extension EPopoverView: UITableViewDataSource{
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(EPopoverReuseIdentifier, forIndexPath: indexPath) as! EPopoverTableCell
        cell.selectedKey = selectedKey
        cell.dict = data[indexPath.row]
        return cell
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 45
    }
}
//MARK: - UITableViewDelegate代理
extension EPopoverView: UITableViewDelegate{
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let code = data[indexPath.row].code ?? ""
        hide()
        NSNotificationCenter.defaultCenter().postNotificationName(FilterExprienceData, object: self, userInfo: ["code": code , "type": filterType!])
    }
}
