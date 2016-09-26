//
//  ClassesViewController.swift
//  Warm
//
//  Created by zhoucj on 16/9/24.
//  Copyright © 2016年 zhoucj. All rights reserved.
//

import UIKit
import SVProgressHUD

let SectionForSectionIndex = "SectionForSectionIndex"
class ClassesViewController: UIViewController {
    let homeViewModel = HomeViewModel()
    var rowHeightCaches = [String: CGFloat]()
    var cellRefreshCount = 1
    var classes: WClass?
    var classesId: Int64?{
        didSet{
            guard let id = classesId else{
                return
            }
            SVProgressHUD.setDefaultMaskType(.Black)
            SVProgressHUD.show()
            unowned let tmpSelf = self
            homeViewModel.loadClassesDetail(id) { (data, error) -> () in
                guard let _classes = data as? WClass else {
                    return
                }
                tmpSelf.classes = _classes
                if let detail = _classes.info?.detail {
                    tmpSelf.tmpWebView.loadHTMLString(detail, baseURL: nil)
                }
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
        navigationController?.navigationBarHidden = true
    }
    private func setupUI(){
        view.backgroundColor = UIColor.whiteColor()
        view.addSubview(tableView)
        view.addSubview(navibackView)
        view.addSubview(customBar)
        view.addSubview(joinView)
        tableView.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(view.snp_top).offset(-20)
            make.left.right.equalTo(view)
            make.bottom.equalTo(view.snp_bottom)
        }
        view.addSubview(tmpWebView)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("sectionForSectionIndex:"), name: SectionForSectionIndex, object: nil)
    }

    private lazy var navibackView: UIView  = {
        let v = UIView(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: 64.0))
        v.backgroundColor = UIColor.clearColor()
        return v
    }()
    //自定义导航栏
    private lazy var customBar: UIView = {
        let v = UIView(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: 64.0))
        v.backgroundColor = UIColor.clearColor()
        v.addSubview(self.backBtn)
        v.addSubview(self.loveBtn)
        v.addSubview(self.shareBtn)
        return v
    }()
    private lazy var backBtn: UIButton = {
        let btn = UIButton(frame: CGRectMake(17, 30, 30, 30))
        btn.addTarget(self, action: Selector("backBtnClick"), forControlEvents: .TouchUpInside)
        btn.setImage(UIImage(named: "navigationBackDefault_30x30_"), forState: .Normal)
        return btn
    }()
    private lazy var loveBtn: UIButton  = {
        let btn = UIButton(frame: CGRectMake(ScreenWidth - 80, 30, 30, 30))
        btn.setBackgroundImage(UIImage(named: "navigationLoveNormalDefault_30x30_"), forState: .Normal)
        btn.setBackgroundImage(UIImage(named: "navigationLoveOnDefault_30x30_"), forState: .Selected)
        btn.addTarget(self, action: Selector("loveBtnClick:"), forControlEvents: .TouchUpInside)
        btn.sizeToFit()
        return btn
    }()
    private lazy var shareBtn: UIButton = {
        let btn = UIButton(frame: CGRectMake(ScreenWidth - 40, 30, 30, 30))
        btn.setBackgroundImage(UIImage(named: "navigationShareDefault_30x30_"), forState: .Normal)
        btn.addTarget(self, action: Selector("shareBtnClick"), forControlEvents: .TouchUpInside)
        btn.sizeToFit()
        return btn
    }()

    private lazy var tableView: UITableView = {
        let tv = UITableView(frame: CGRectZero, style: .Plain)
        tv.dataSource = self
        tv.separatorStyle = .None
        tv.delegate = self
        return tv
    }()

    private lazy var tableHeadView = ClassesHeadView(frame: CGRectZero)

    private lazy var joinView: UIView = {
        let v = UIView(frame: CGRect(x: 0, y: ScreenHeight - 50.0, width: ScreenWidth, height: 50))
        v.backgroundColor = UIColor.whiteColor()
        let joinBtn = UIButton()
        joinBtn.backgroundColor = WarmBlueColor
        joinBtn.setTitle("我要参加", forState: .Normal)
        joinBtn.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        joinBtn.titleLabel?.textAlignment = .Center
        joinBtn.frame = CGRect(x: 5.0, y: 5.0, width: ScreenWidth - 10, height: 40.0)
        v.addSubview(joinBtn)
        return v
    }()
    private lazy var tmpWebView: UIWebView = {
        let wv = UIWebView(frame: CGRectMake(0, 0, self.view.frame.size.width, 2))
        wv.alpha = 0
        wv.delegate = self
        wv.sizeToFit()
        return wv
    }()
    //按钮容器
    lazy var btnContainer = CBtnContainerView(frame: CGRectZero)

    @objc func loveBtnClick(btn: UIButton){
        btn.selected = !btn.selected
    }
    @objc func shareBtnClick(){
        ShareTools.shareApp(self, shareText: nil)
    }
    @objc private func backBtnClick(){
        navigationController?.popViewControllerAnimated(true)
    }

    @objc func sectionForSectionIndex(notice: NSNotification){
        guard let index = notice.object as? Int else{
            return
        }
        tableView.scrollToRowAtIndexPath(NSIndexPath(forRow: 0, inSection: (index - 1)), atScrollPosition: UITableViewScrollPosition.Top, animated: true)
    }
    private func defaultImage(){
        backBtn.setImage(UIImage(named: "navigationBackDefault_30x30_"), forState: .Normal)
        loveBtn.setBackgroundImage(UIImage(named: "navigationLoveNormalDefault_30x30_"), forState: .Normal)
        loveBtn.setBackgroundImage(UIImage(named: "navigationLoveOnDefault_30x30_"), forState: .Selected)
        shareBtn.setBackgroundImage(UIImage(named: "navigationShareDefault_30x30_"), forState: .Normal)
    }
    private func changeBtnImage(){
        backBtn.setImage(UIImage(named: "NavigationBackAnother_24x24_"), forState: .Normal)
        loveBtn.setBackgroundImage(UIImage(named: "navigationLoveNormal_22x20_"), forState: .Normal)
        loveBtn.setBackgroundImage(UIImage(named: "navigation_liked_22x22_"), forState: .Selected)
        shareBtn.setBackgroundImage(UIImage(named: "navigationShare_20x20_"), forState: .Normal)
    }
    deinit{
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }

}
//MARK: - UITableViewDataSource代理
extension ClassesViewController: UITableViewDataSource{
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 3
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.section == 0{
            let cell = CExperienceDetailCell()
            cell.contentStr = classes?.info?.detail
            return cell
        }
        if indexPath.section == 1{
            let cell = CUserCell()
            cell.teacher = classes?.teacher
            return cell
        }
        if indexPath.section == 2{
            let cell = CContactCell()
            cell.info = classes?.info
            return cell
        }
        return UITableViewCell()
    }
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat{
        if section == 0{
            return 0
        }
        return 10
    }
}
extension ClassesViewController: UITableViewDelegate {
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if let height = rowHeightCaches["\(indexPath.section)"]{
            return height
        }
        return 230
    }
}

extension ClassesViewController: UIWebViewDelegate{
    func webViewDidFinishLoad(webView: UIWebView) {
        //客户端高度
//        let str = "document.body.offsetHeight"
//        let clientheightStr = webView.stringByEvaluatingJavaScriptFromString(str)
//        let height = CGFloat((clientheightStr! as NSString).floatValue)
        var frame = webView.frame
        frame.size.width = ScreenWidth
        frame.size.height = 1  //这步不能少，不然webView.scrollView.contentSize.height为零
        webView.frame = frame
        let height = webView.scrollView.contentSize.height
        //移除多余的webView
        tmpWebView.removeFromSuperview()

        rowHeightCaches = [String: CGFloat]()
        rowHeightCaches["0"] = height
        if let teacher = classes?.teacher {
            let userCell = CUserCell(frame: CGRectZero)
            let userCellHeight = userCell.calucateHeight(teacher)
            rowHeightCaches["1"] = userCellHeight
        }
        if let info = classes?.info{
            let contactCell = CContactCell(frame: CGRectZero)
            let contactCellHeight = contactCell.calcuateHeight(info)
            rowHeightCaches["2"] = contactCellHeight
        }

        let headViewHeight = tableHeadView.calculate(classes!)
        tableHeadView.addSubview(btnContainer)
        btnContainer.frame = CGRect(x: 0, y: headViewHeight, width: ScreenWidth, height: 45)
        tableHeadView.frame = CGRect(x: 0, y: -22, width: ScreenWidth, height: headViewHeight + 45)
        tableView.tableHeaderView = tableHeadView
        tableView.reloadData()
        SVProgressHUD.dismiss()
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        //释放选中效果
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
}
extension ClassesViewController: UIScrollViewDelegate{
    func scrollViewDidScroll(scrollView: UIScrollView) {
        let topImageView = tableHeadView.postImageView
        let imageHeight: CGFloat = 230
        let offsetY = scrollView.contentOffset.y
        let frame = topImageView.frame
        if offsetY < -20 {
            topImageView.frame =  CGRectMake(offsetY/2, offsetY, -offsetY + ScreenWidth, -offsetY + imageHeight)
        } else {
            topImageView.frame = frame
        }
        if offsetY >= tableHeadView.frame.height - 64 - 45 {
            //向上滑动 按钮 漂移到 导航栏下方的时候  将CBtnContainerView 从tableHeadView上移除  添加到 self.view上
            if !view.subviews.contains(btnContainer) {
                //从tableHeadView上移除
                btnContainer.removeFromSuperview()
                btnContainer.frame = CGRectMake(0, 64, ScreenWidth, 45)
                view.addSubview(btnContainer)
                view.bringSubviewToFront(btnContainer)
            }
        }else if offsetY < tableHeadView.frame.height - 64 - 45 {
            if !tableHeadView.subviews.contains(btnContainer) {
                btnContainer.frame = CGRectMake(0, tableHeadView.frame.height - 45, ScreenWidth, 45)
                tableHeadView.addSubview(btnContainer)
            }
        }
        //改变导航栏颜色
        //向上滑动
        if(offsetY > 0 && tableHeadView.frame.origin.y > -tableHeadView.frame.size.height + 64){
            //设定navBackView 的颜色
            if( (offsetY) / 32 < 1.0){
                navibackView.backgroundColor = UIColor.whiteColor()
                changeBtnImage()
            }
        }else if(offsetY < 0 && tableHeadView.frame.origin.y <= 0){
            if(-offsetY/32 < 1.0 ){
                navibackView.backgroundColor = UIColor.clearColor()
                defaultImage()
            }
        }

    }
}
