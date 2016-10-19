//
//  MainViewController.swift
//  Warm
//
//  Created by zhoucj on 16/9/12.
//  Copyright © 2016年 zhoucj. All rights reserved.
//

import UIKit
let LoginSuccessNotication = "LoginSuccessNotication"
class MainViewController: UITabBarController {
    var lastSelectedIndex = 0
    private var adImageView: UIImageView?
    var adImage: UIImage?{
        didSet{
            //进入主界面时图片放到消失动画
            unowned let tmpSelf = self
            adImageView = UIImageView(frame: UIScreen.mainScreen().bounds)
            adImageView!.image = adImage!
            self.view.addSubview(adImageView!)
            UIImageView.animateWithDuration(2.0, animations: { () -> Void in
                tmpSelf.adImageView!.transform = CGAffineTransformMakeScale(1.3, 1.3)
                tmpSelf.adImageView!.alpha = 0
                }) { (finsch) -> Void in
                    tmpSelf.adImageView!.removeFromSuperview()
                    tmpSelf.adImageView = nil
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
        addChildViewControllers()
        //注册登录通知
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("doLogin"), name: LoginNotication, object: nil)
        //登录成功通知
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("loginSuccess"), name: LoginSuccessNotication, object: nil)
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)

    }
    private func addChildViewControllers(){
        addChildViewController("HomeViewController", title: "取暖", imageName: "tabbar_home_20x23_", selectedImage: "tabHomeOn_20x23_")
        addChildViewController("ExperienceViewController", title: "体验", imageName: "tabbar_discover_24x24_", selectedImage: "tabExperienceOn_22x21_")
        addChildViewController("MeViewController", title: "我", imageName: "tabbar_user_24x24_", selectedImage: "tabMineOn_22x21_")
    }
    //MARK: - 添加子视图控制器
    private func addChildViewController(childControllerName: String?, title: String?, imageName: String?, selectedImage: String?) {
        //获取命名空间
        guard let name = NSBundle.mainBundle().infoDictionary!["CFBundleExecutable"] as? String else {
            CJLog("命名空间获取失败!")
            return
        }
        //获取类型
        var cls: AnyClass? = nil
        if let vcName = childControllerName {
            cls = NSClassFromString(name + "." + vcName)
        }
        guard let typeCls = cls as? UIViewController.Type else{
            CJLog("类型转换错误")
            return
        }
        let childController = typeCls.init()
        childController.title = title
        if let imName = imageName where imName != ""{
            childController.tabBarItem.image = UIImage(named: imName)
            if let selectedIv = selectedImage where selectedIv != ""{
                childController.tabBarItem.selectedImage = UIImage(named: selectedIv)
            }
        }
        childController.view.backgroundColor = Color_GlobalBackground

        let nav = NavigationController()
        nav.addChildViewController(childController)
        addChildViewController(nav)
    }

    @objc private func doLogin(){
        presentViewController(UINavigationController(rootViewController: LoginViewController()), animated: true, completion: nil)
    }

    @objc private func loginSuccess(){
        selectedIndex = 2
        lastSelectedIndex = selectedIndex
    }

    deinit{
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
}
extension MainViewController: UITabBarControllerDelegate{
    func tabBarController(tabBarController: UITabBarController, shouldSelectViewController viewController: UIViewController) -> Bool {
        if !Token.isLogin() && (viewController.childViewControllers[0]).isKindOfClass(MeViewController){
            presentViewController(UINavigationController(rootViewController: LoginViewController()), animated: true, completion: nil)
            return false
        }
        return true
    }
    func tabBarController(tabBarController: UITabBarController, didSelectViewController viewController: UIViewController) {
        //如果上一次点击的item和本次点击的item相同就刷新页面
        if lastSelectedIndex == selectedIndex{
            let viewCtl = viewController.childViewControllers[0]
            if viewCtl.isKindOfClass(HomeViewController){
                let homeViewController = viewCtl as! HomeViewController
                homeViewController.tableView.header.beginRefreshing()
            }
            if viewCtl.isKindOfClass(ExperienceViewController){
                let experienceViewController = viewCtl as! ExperienceViewController
                experienceViewController.tableView.header.beginRefreshing()
            }
        }else{
            lastSelectedIndex = selectedIndex
        }
    }
}
