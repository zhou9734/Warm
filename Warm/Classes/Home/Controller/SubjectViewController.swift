//
//  SubjectViewController.swift
//  Warm
//
//  Created by zhoucj on 16/9/22.
//  Copyright © 2016年 zhoucj. All rights reserved.
//

import UIKit
import SVProgressHUD

let SubjectSalonTableReuseIdentifier = "SubjectSalonTableReuseIdentifier"
let SubjectClassesTableReuseIdentifier = "SubjectClassesTableReuseIdentifier"
class SubjectViewController: UIViewController {
    let homeViewModel = HomeViewModel()
    var rdata: WRdata?
    var subid: Int64?{
        didSet{
            guard let _subid = subid else{
                SVProgressHUD.showErrorWithStatus("参数传递错误")
                return
            }
            SVProgressHUD.show()
            unowned let tmpSelf = self
            homeViewModel.loadSubjectDetail(_subid) { (data, error) -> () in
                guard let _rdata = data as? WRdata else {
                    return
                }
                tmpSelf.rdata = _rdata
                tmpSelf.tmpWebView.loadRequest(NSURLRequest(URL: NSURL(string: _rdata.content!)!))
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        //隐藏navigationBar
        navigationController?.navigationBarHidden = false
    }
    private func setupUI(){
        view.backgroundColor = UIColor.whiteColor()
        navigationItem.rightBarButtonItems = [UIBarButtonItem(customView: shareBtn), UIBarButtonItem(customView: loveBtn)]
        view.addSubview(tableView)
    }
    private lazy var loveBtn: UIButton  = {
        let btn = UIButton()
        btn.setBackgroundImage(UIImage(named: "navigationLoveNormal_22x20_"), forState: .Normal)
        btn.addTarget(self, action: Selector("loveBtnClick:"), forControlEvents: .TouchUpInside)
        btn.setBackgroundImage(UIImage(named: "navigation_liked_22x22_"), forState: .Selected)
        btn.sizeToFit()
        return btn
    }()
    private lazy var shareBtn: UIButton = UIButton(target: self, backgroundImage: "navigationShare_20x20_", action: Selector("shareBtnClick"))

    private lazy var tableView: UITableView = {
        let tv = UITableView(frame: ScreenBounds, style: .Plain)
        tv.registerClass(SubjectSalonTableViewCell.self, forCellReuseIdentifier: SubjectSalonTableReuseIdentifier)
        tv.registerClass(SubjectClassesTableViewCell.self, forCellReuseIdentifier: SubjectClassesTableReuseIdentifier)
        tv.dataSource = self
        tv.delegate = self
//        tv.tableHeaderView = self.tableHeadView
        tv.separatorStyle = .None
        return tv
    }()

    private lazy var tableHeadView: SubjectHeadView = SubjectHeadView(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: 2))

    private lazy var tmpWebView: UIWebView = {
        let wv = UIWebView(frame: CGRectMake(0, 0, self.view.frame.size.width, 2))
        wv.alpha = 0
        wv.delegate = self
        wv.sizeToFit()
        return wv
    }()
    @objc func loveBtnClick(btn: UIButton){
        btn.selected = !btn.selected
    }
    @objc func shareBtnClick(){
        ShareTools.shareApp(self, shareText: nil)
    }
    deinit{
        tmpWebView.delegate = nil
        tmpWebView.stopLoading()
    }
}
//MARK: - UITableViewDataSource代理
extension SubjectViewController: UITableViewDataSource{
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rdata?.itmes?.count ?? 0
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let item = rdata?.itmes![indexPath.row]
        if  item?.type == 1 {
            let cell = tableView.dequeueReusableCellWithIdentifier(SubjectClassesTableReuseIdentifier, forIndexPath: indexPath) as! SubjectClassesTableViewCell
            cell.item = item
            return cell
        }
        let cell = tableView.dequeueReusableCellWithIdentifier(SubjectSalonTableReuseIdentifier, forIndexPath: indexPath) as! SubjectSalonTableViewCell
        cell.item = item
        return cell
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 140
    }
}
//MARK: - UITableViewDelegate代理
extension SubjectViewController: UITableViewDelegate{
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath){
        //释放选中效果
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        let item = rdata?.itmes![indexPath.row]
        if item?.type == 1{
            guard let id = item?.classes?.id else{
                alert("数据错误!")
                return
            }
            let classesVC = ClassesViewController()
            classesVC.classesId = id
            navigationController?.pushViewController(classesVC, animated: true)
        }else if item?.type == 2{
            guard let id = item?.salon?.id else{
                alert("数据错误!")
                return
            }
            let salonVC = SalonViewController()
            salonVC.salonId = id
            navigationController?.pushViewController(salonVC, animated: true)
        }
    }
}
extension SubjectViewController: UIWebViewDelegate{
    func webViewDidFinishLoad(webView: UIWebView) {
        //客户端高度
        let str = "document.body.offsetHeight"
        let clientheightStr = webView.stringByEvaluatingJavaScriptFromString(str)
        let height = CGFloat((clientheightStr! as NSString).floatValue) + 80
        //移除多余的webView
        tmpWebView.removeFromSuperview()

        tableHeadView.frame = CGRect(x: 0, y: 0,  width: ScreenWidth, height: height)
        guard let data = rdata else{
            SVProgressHUD.dismiss()
            alert("获取数据失败")
            return
        }
        tableHeadView.titleStrng = data.title
        tableHeadView.urlString = data.content
        tableView.tableHeaderView = tableHeadView
        tableView.reloadData()
        SVProgressHUD.dismiss()
    }
}
