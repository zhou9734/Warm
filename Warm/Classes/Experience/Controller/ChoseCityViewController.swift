//
//  ChoseCityViewController.swift
//  Warm
//
//  Created by zhoucj on 16/9/19.
//  Copyright © 2016年 zhoucj. All rights reserved.
//

import UIKit

let ChoseTableCellReuseIdentifier = "ChoseTableCellReuseIdentifier"
class ChoseCityViewController: UIViewController {
    var experienceViewModel = ExperienceViewModel()
    var postalCode: String = "000000"
    var citys: [WCity] = [WCity](){
        didSet{
            tableView.reloadData()
        }
    }
    var doSelectCity: ((cityCode: String, cityName: String)->())?
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "所在城市"
        view.addSubview(tableView)
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBarHidden = false
        var textAttrs: [String : AnyObject] = Dictionary()
        textAttrs[NSForegroundColorAttributeName] = UIColor.blackColor()
        textAttrs[NSFontAttributeName] = UIFont.systemFontOfSize(17)
        navigationController?.navigationBar.titleTextAttributes = textAttrs
    }
    private lazy var tableView: UITableView = {
        let tv = UITableView(frame: self.view.bounds,style: .Plain)
        tv.registerClass(UITableViewCell.self, forCellReuseIdentifier: ChoseTableCellReuseIdentifier)
        tv.dataSource = self
        tv.delegate = self
        tv.backgroundColor = UIColor(red: 241.0/255.0, green: 241.0/255.0, blue: 241.0/255.0, alpha: 1)
        return tv
    }()   

}
//MARK: - UITableViewDataSource代理
extension ChoseCityViewController: UITableViewDataSource{
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return citys.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(ChoseTableCellReuseIdentifier, forIndexPath: indexPath)

        if indexPath.row == 0 || indexPath.row == (citys.count - 1){
            cell.textLabel?.textColor = UIColor.lightGrayColor()
        }
        cell.textLabel?.font = UIFont.systemFontOfSize(15)
        cell.textLabel?.text = citys[indexPath.row].cityName
        if postalCode == citys[indexPath.row].cityCode{
            cell.accessoryType = .Checkmark
        }
        return cell
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 50
    }
}
//MARK: - UITableViewDelegate代理
extension ChoseCityViewController: UITableViewDelegate{

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath){
        //释放选中效果
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        if indexPath.row != 0 && indexPath.row != (citys.count - 1){
            if doSelectCity != nil{
                let city = citys[indexPath.row]
                doSelectCity!(cityCode: city.cityCode!, cityName: city.cityName!)
                navigationController?.popViewControllerAnimated(true)
            }
        }

    }
}