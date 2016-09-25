//
//  EFilterHeadView.swift
//  Warm
//
//  Created by zhoucj on 16/9/22.
//  Copyright © 2016年 zhoucj. All rights reserved.
//

import UIKit

let EFilterCellReuseIdentifier = "EFilterCellReuseIdentifier"

class EFilterHeadView: UIView {
    var experienceViewModel: ExperienceViewModel?
    var data: [WDict] = [WDict](){
        didSet{
            showInView()
        }
    }
    var cityCode: String?
    var areaCode: String = "999"
    var page = 1
    var sortType = 1
    var tagid = "999"
    var selectedKey: Int64?
    var filterType: Int?
    var tableHeight: CGFloat = 0.0
    var typeSelectedKey: Int64 = 999
    var areaSelectedKey: Int64 = 999
    var sortSelectedKey: Int64 = 1
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func setupUI(){
        addSubview(typeBtn)
        addSubview(leftSpliteView)
        addSubview(areaBtn)
        addSubview(rightSpliteView)
        addSubview(sortBtn)
        insertSubview(containerBtn, atIndex: 0)
        insertSubview(tableView, atIndex: 1)
    }

    let btnWidth: CGFloat =  (ScreenWidth - 2) / 3
    private lazy var typeBtn: CustomButton = {
        let btn = CustomButton()
        btn.setTitle("所有类别", forState: .Normal)
        btn.titleLabel?.textAlignment = .Center
        btn.frame = CGRect(x: 0 , y: 0, width: self.btnWidth, height: 45.0)
        btn.tag = 1
        btn.addTarget(self, action: Selector("openPopoverView:"), forControlEvents: .TouchUpInside)
        btn.backgroundColor = Color_GlobalBackground
        return btn
    }()
    private lazy var leftSpliteView : UIView = {
        let v = UIView(frame: CGRect(x: self.btnWidth, y: 0, width: 1.0, height: 45.0))
        v.backgroundColor = UIColor(red: 241.0/255.0, green: 241.0/255.0, blue: 241.0/255.0, alpha: 1)
        return v
    }()

    private lazy var areaBtn: CustomButton = {
        let btn = CustomButton()
        btn.setTitle("所有地区", forState: .Normal)
        btn.frame = CGRect(x: self.btnWidth + 1 , y: 0, width: self.btnWidth, height: 45.0)
        btn.titleLabel?.textAlignment = .Center
        btn.tag = 2
        btn.addTarget(self, action: Selector("openPopoverView:"), forControlEvents: .TouchUpInside)
        btn.backgroundColor = Color_GlobalBackground
        return btn
    }()
    private lazy var rightSpliteView : UIView = {
        let v = UIView(frame: CGRect(x: self.btnWidth * 2 + 1, y: 0, width: 1.0, height: 45.0))
        v.backgroundColor = UIColor(red: 241.0/255.0, green: 241.0/255.0, blue: 241.0/255.0, alpha: 1)
        return v
    }()
    private lazy var sortBtn: CustomButton = {
        let btn = CustomButton()
        btn.setTitle("最新", forState: .Normal)
        btn.frame = CGRect(x: (self.btnWidth + 1) * 2 , y: 0, width: self.btnWidth, height: 45.0)
        btn.titleLabel?.textAlignment = .Center
        btn.tag = 3
        btn.addTarget(self, action: Selector("openPopoverView:"), forControlEvents: .TouchUpInside)
        btn.backgroundColor = Color_GlobalBackground
        return btn
    }()
    //MARK: - tableView
    private lazy var tableView: UITableView = {
        let tbv = UITableView(frame: CGRectZero, style: .Plain)
        tbv.registerClass(EPopoverTableCell.self, forCellReuseIdentifier: EFilterCellReuseIdentifier)
        tbv.dataSource = self
        tbv.delegate = self
        tbv.hidden = true
        return tbv
    }()
    private lazy var containerBtn: UIButton = {
        let btn = UIButton()
        btn.backgroundColor = UIColor(white: 0.2, alpha: 0.3)
        btn.addTarget(self, action: Selector("dismissViewClick"), forControlEvents: .TouchUpInside)
        btn.alpha = 1
        btn.frame = CGRect(origin: CGPoint(x: 0, y: 45), size: ScreenBounds.size)
        btn.hidden = true
        return btn
    }()
    //展示
    func showInView(){
        tableHeight = CGFloat(data.count * 45)
        if data.count >= 5{
            tableHeight = CGFloat(5 * 45)
        }
        containerBtn.hidden = false
        tableView.hidden = false
        let _width = ScreenWidth
        tableView.frame = CGRectMake(0, -tableHeight + 45, _width, tableHeight)
        unowned let tmpSelf = self
        UIView.animateWithDuration(0.5) { () -> Void in
             tmpSelf.tableView.frame = CGRectMake(0, 45, _width, tmpSelf.tableHeight)
             tmpSelf.layoutIfNeeded()
        }

        tableView.reloadData()
        NSNotificationCenter.defaultCenter().postNotificationName(ChageHeadView, object: true)
    }

    @objc private func openPopoverView(btn: UIButton){
        if btn.selected {
            btn.selected = false
            dismissViewClick()
            NSNotificationCenter.defaultCenter().postNotificationName(ChageHeadView, object: false)
            return
        }
        if btn.tag == 1 {

            filterType = btn.tag
            areaBtn.selected = false
            sortBtn.selected = false
            data = experienceViewModel!.loadDictDataByFile("TagType")
        }else if btn.tag == 2{
            unowned let tmpSelf = self
            experienceViewModel!.loadAreasByCityCode(cityCode!, finished: { (data, error) -> () in
                tmpSelf.filterType = btn.tag
                tmpSelf.typeBtn.selected = false
                tmpSelf.sortBtn.selected = false
                tmpSelf.data = tmpSelf.experienceViewModel!.areas
            })
        }else if btn.tag == 3{
            filterType = btn.tag
            typeBtn.selected = false
            areaBtn.selected = false
            data = experienceViewModel!.loadDictDataByFile("SortType")
        }
        btn.selected = true
    }
    @objc private func dismissViewClick(){
        unowned let tmpSelf = self
        UIView.animateWithDuration(0.5, animations: {
            tmpSelf.tableView.frame = CGRectMake(0, -tmpSelf.tableHeight + 45, ScreenWidth, self.tableHeight)
            tmpSelf.layoutIfNeeded()
            }, completion: { (Bool) -> Void in
                tmpSelf.containerBtn.hidden = true
                tmpSelf.tableView.hidden = true
                if tmpSelf.filterType == 1{
                    tmpSelf.typeBtn.selected = false
                }else if tmpSelf.filterType == 2{
                    tmpSelf.areaBtn.selected = false
                }else if tmpSelf.filterType == 3{
                    tmpSelf.sortBtn.selected = false
                }
               NSNotificationCenter.defaultCenter().postNotificationName(ChageHeadView, object: false)
        })

    }

}
//MARK: - UITableViewDataSource代理
extension EFilterHeadView: UITableViewDataSource{
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(EFilterCellReuseIdentifier, forIndexPath: indexPath) as! EPopoverTableCell
        cell.resetLbl()
        if filterType == 1{
            cell.selectedKey = typeSelectedKey
        }else if filterType == 2{
            cell.selectedKey = areaSelectedKey
        }else if filterType == 3{
            cell.selectedKey = sortSelectedKey
        }
        cell.selectedKey = selectedKey
        cell.dict = data[indexPath.row]
        return cell
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 45
    }
}
//MARK: - UITableViewDelegate代理
extension EFilterHeadView: UITableViewDelegate{
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let code = data[indexPath.row].code
        let name = data[indexPath.row].name
        if filterType == 1{
            typeBtn.setTitle(name, forState: .Normal)
            typeSelectedKey = code
        }else if filterType == 2{
            areaBtn.setTitle(name, forState: .Normal)
            areaSelectedKey = code
        }else if filterType == 3{
            sortBtn.setTitle(name, forState: .Normal)
            sortSelectedKey = code
        }
        selectedKey = code
        dismissViewClick()
        NSNotificationCenter.defaultCenter().postNotificationName(FilterExprienceData, object: self, userInfo: ["code": "\(code)" , "type": "\(filterType!)"])
    }
}
