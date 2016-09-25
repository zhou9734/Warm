//
//  ExperienceViewController.swift
//  Warm
//
//  Created by zhoucj on 16/9/12.
//  Copyright © 2016年 zhoucj. All rights reserved.
//

import UIKit
import CoreLocation

let TagsImageClick = "TagsImageClick"
let ETableBaseCellReuseIdentifier = "ETableBaseCellReuseIdentifier"
let ETableBaseTagCellReuseIdentifier = "ETableBaseTagCellReuseIdentifier"

class ExperienceViewController: BaseViewController {
    let experienceViewModel = ExperienceViewModel()
    //定位服务管理类
    let locationManager: CLLocationManager = CLLocationManager()
    //定义坐标坐标
    var currLocation: CLLocation?
    var citys: [WCity] = [WCity]()
    var isLocationed = false

    override func viewDidLoad() {
        super.viewDidLoad()
        citys = experienceViewModel.loadCityData()
        citys.append(WCity(cityName: "更多城市敬请期待", cityCode: ""))
        location()
        setupUI()
        setupRefresh()
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        //隐藏navigationBar
        navigationController?.navigationBarHidden = false
    }
    override func viewWillDisappear(animated: Bool) {
        //停止更新定位
        locationManager.stopUpdatingLocation()
        //停止更新方向
        locationManager.stopUpdatingHeading()
        CJLog("定位结束")
    }


    //设置组件
    private func setupUI(){
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: leftBtn)
        navigationItem.rightBarButtonItems = [UIBarButtonItem(customView: filterBtn),UIBarButtonItem(customView: calendarBtn)]
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("tagsImageClick:"), name: TagsImageClick, object: nil)
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
        tv.registerClass(ETableViewNoTagCell.self, forCellReuseIdentifier: ETableBaseCellReuseIdentifier)
        tv.registerClass(ETableViewTagCell.self, forCellReuseIdentifier: ETableBaseTagCellReuseIdentifier)
        tv.dataSource = self
        tv.delegate = self
        tv.backgroundColor = UIColor.whiteColor()
        tv.tableHeaderView = self.tableHeadView
        return tv
    }()
    private lazy var tableHeadView = ExperienceTableHeadView(frame: CGRect(origin: CGPointZero, size: CGSize(width: ScreenWidth, height: ScreenHeight * 0.29)))

    lazy var leftBtn: UIButton = {
        let title = self.isHaveLocationCityCode(self.citycode)
        let btn = UIButton(target: self, image: "navigationLocation_17x21_", action: Selector("switchLocation"), title: title)
        return btn
    }()

    private lazy var calendarBtn: UIButton  =  UIButton(target: self, backgroundImage: "navigationCalendar_22x22_", action: Selector("calendarBtnClick"))
    private lazy var filterBtn: UIButton = UIButton(target: self, backgroundImage: "navgationFilter_20x22_", action: Selector("filterBtnClick"))

    //MARK: - 切换地点
    @objc private func switchLocation(){
        unowned let tmpSelf = self
        let choseCityVC = ChoseCityViewController()
        choseCityVC.doSelectCity = {(cityCode, cityName) in
            tmpSelf.citycode = cityCode
            NSUserDefaults.standardUserDefaults().setObject(cityCode, forKey: cityCodeKey)
            tmpSelf.leftBtn.setTitle("  " + cityName, forState: .Normal)
            tmpSelf.tableView.header.beginRefreshing()
        }
        if isLocationed {
            choseCityVC.citys = citys
            choseCityVC.postalCode = "\(citycode)"
            navigationController?.pushViewController(choseCityVC, animated: true)
            return
        }
        reverseGeocode { () -> () in
            choseCityVC.citys = tmpSelf.citys
            choseCityVC.postalCode = "\(tmpSelf.citycode)"
            tmpSelf.navigationController?.pushViewController(choseCityVC, animated: true)
        }
    }
    //MARK: - 日历
    @objc private func calendarBtnClick(){
        let calendarVC = CalendarViewController()
        calendarVC.cityCode = citycode
        navigationController?.pushViewController(calendarVC, animated: true)
    }
    //MARK: - 过滤
    @objc private func filterBtnClick(){
        let filterVC = FilterViewController()
        filterVC.cityCode = citycode
        navigationController?.pushViewController(filterVC, animated: true)        
    }

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
        experienceViewModel.loadData(citycode, page: page) { (data, error) -> () in
            // 安全校验
            if error != nil{
                alert("获取数据失败")
                return
            }
            finished()
            tmpSelf.page = tmpSelf.page + 1
            tmpSelf.tableView.reloadData()
            tmpSelf.tableHeadView.tags = tmpSelf.experienceViewModel.tags
        }
    }

    @objc private func tagsImageClick(notice: NSNotification){
        guard let index = notice.userInfo!["index"] as? Int else{
            return
        }
        let tag = experienceViewModel.tags[index]
        let etopicVC = ETopicViewController()
        etopicVC.tagid = tag.tagid
        etopicVC.tagName = tag.tag?.name
        etopicVC.citycode = citycode
        navigationController?.pushViewController(etopicVC, animated: true)
    }

//    @objc private func classesImageClick(notice: NSNotification){
//        guard let index = notice.userInfo!["index"] as? Int else{
//            return
//        }
//        CJLog(index)
//    }
    private func isLogin() -> Bool{
        if !Token.isLogin() {
            NSNotificationCenter.defaultCenter().postNotificationName(LoginNotication, object: self)
            return true
        }
        return false
    }
    //MARK: - 定位
    private func location(){
        //指定代理
        locationManager.delegate = self
        //精确到1000米,距离过滤器，定义了设备移动后获得位置信息的最小距离
        locationManager.distanceFilter = kCLLocationAccuracyBest
        //发出授权申请
        if #available(iOS 8.0, *) {
            locationManager.requestAlwaysAuthorization()
        } else {
            if (CLLocationManager.locationServicesEnabled()){
                //设置定位进度
                locationManager.desiredAccuracy = kCLLocationAccuracyBest
            }else{
                print("定位服务无法使用,请开启手机定位服务")
            }
        }
        //更新位置
        locationManager.startUpdatingLocation()
        //更新方向
        locationManager.startUpdatingHeading()
    }
    //MARK: - 反编码地理信息
    private func reverseGeocode(finished: ()->()){
        unowned let tmpSelf = self
        let geocoder = CLGeocoder()
        var p:CLPlacemark?
        geocoder.reverseGeocodeLocation(currLocation!, completionHandler: { (placemarks, error) -> Void in
            // 强制 成 简体中文
            let array = NSArray(object: "zh-hans")
            NSUserDefaults.standardUserDefaults().setObject(array, forKey: "AppleLanguages")
            // 显示所有信息
            if error != nil {
                print("reverse geodcode fail: \(error!.localizedDescription)")
                return
            }
            var city: WCity?
            let pm = placemarks
            if (pm!.count > 0){
                p = placemarks![0]
                let cityName = (p?.locality)! as String
                let cityCode = p?.postalCode ?? ""
                city = WCity(cityName: "GPS定位: " + cityName, cityCode: cityCode)
                tmpSelf.isHaveLocationCityCode(cityCode)
            }else{
                city = WCity(cityName: "定位错误", cityCode: "000000")
            }
            tmpSelf.citys.insert(city!, atIndex: 0)
            tmpSelf.isLocationed = true
            finished()
        })
        
    }
    private func isHaveLocationCityCode(postCode: String) -> String{
        var cityName = ""
        if postCode == ""{
            return cityName
        }
        for i in citys{
            if postCode == i.cityCode{
                citycode = postCode
                cityName = i.cityName!
                NSUserDefaults.standardUserDefaults().setObject(citycode, forKey: cityCodeKey)
                break
            }
        }
        return cityName
    }
    deinit{
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
}
//MARK: - UITableViewDataSource代理
extension ExperienceViewController: UITableViewDataSource{
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
            let cell = tableView.dequeueReusableCellWithIdentifier(ETableBaseTagCellReuseIdentifier, forIndexPath: indexPath) as! ETableViewTagCell
            cell.classes = _class
            return cell
        }
        let cell = tableView.dequeueReusableCellWithIdentifier(ETableBaseCellReuseIdentifier, forIndexPath: indexPath) as! ETableViewNoTagCell
        cell.classes = _class
        return cell
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 305
    }
}
//MARK: - UITableViewDelegate代理
extension ExperienceViewController: UITableViewDelegate{
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        //释放选中效果
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        let _class = experienceViewModel.classes[indexPath.row]
        let classesVC = ClassesViewController()
        classesVC.classesId = _class.id
        navigationController?.pushViewController(classesVC, animated: true)
    }
}
extension ExperienceViewController: CLLocationManagerDelegate{
    //代理方法--判断是否可以使用定位服务
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus){
        if status == CLAuthorizationStatus.NotDetermined || status == CLAuthorizationStatus.Denied{
            //允许使用定位服务
            //开始启动定位服务更新
            locationManager.startUpdatingLocation()
            //更新方向
            locationManager.startUpdatingHeading()
        }
    }
    //距离改变就会收到该委托方法，获取地理位置信息
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]){
        //获取最新坐标
        currLocation = locations.last
    }
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError){
        if let clErr = CLError(rawValue: error.code){
            switch clErr {
            case .LocationUnknown:
                print("位置不明")
            case .Denied:
                print("允许检索位置被拒绝")
            case .Network:
                print("用于检索位置的网络不可用")
            default:
                print("未知的位置错误")
            }
        } else {
            CJLog("其他错误")
            let alert = UIAlertView(title: "提示信息", message: "定位失败", delegate: nil, cancelButtonTitle: "确定")
            alert.show()
        }
    }
}

