////////////////////////////////////////////////////////////////////
//                          _ooOoo_                               //
//                         o8888888o                              //
//                         88" . "88                              //
//                         (| ^_^ |)                              //
//                         O\  =  /O                              //
//                      ____/`---'\____                           //
//                    .'  \\|     |//  `.                         //
//                   /  \\|||  :  |||//  \                        //
//                  /  _||||| -:- |||||-  \                       //
//                  |   | \\\  -  /// |   |                       //
//                  | \_|  ''\---/''  |   |                       //
//                  \  .-\__  `-`  ___/-. /                       //
//                ___`. .'  /--.--\  `. . ___                     //
//              ."" '<  `.___\_<|>_/___.'  >'"".                  //
//            | | :  `- \`.;`\ _ /`;.`/ - ` : | |                 //
//            \  \ `-.   \_ __\ /__ _/   .-` /  /                 //
//      ========`-.____`-.___\_____/___.-`____.-'========         //
//                           `=---='                              //
//      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^        //
//         佛祖保佑            永无BUG              永不修改         //
////////////////////////////////////////////////////////////////////
//
//  AppDelegate.swift
//  Warm
//
//  Created by zhoucj on 16/9/12.
//  Copyright © 2016年 zhoucj. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        //一般情况下全局性的东西要在AppDelegate设置
        UINavigationBar.appearance().tintColor =  Color_GlobalBackground
        UITabBar.appearance().tintColor = WarmBlueColor
        //注册监听
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("switchRootViewController:"), name: SwitchRootViewController, object: nil)
        // 创建窗口
        window = UIWindow(frame: UIScreen.mainScreen().bounds)
        window?.rootViewController = defaultsVC()
        window?.makeKeyAndVisible()
        let defaults = NSUserDefaults.standardUserDefaults()
        if let _ = defaults.valueForKey(cityCodeKey) as? String {

        }else{
            defaults.setObject("440100", forKey: cityCodeKey)
        }
        return true
    }
    deinit{
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
}
extension AppDelegate{
    //切换视图
    func switchRootViewController(notice: NSNotification){
        if notice.object as! Bool{
            let mainViewController = MainViewController()
            if let adImage = notice.userInfo!["image"] as? UIImage{
                mainViewController.adImage = adImage
            }
            //切换到首页
            window?.rootViewController = mainViewController
        }else{
            //写换到欢迎界面
            window?.rootViewController = WelcomeViewController()
        }
    }

    private func defaultsVC() -> UIViewController{
        //判断是否登录
        if Token.isLogin() {
            //已经登录判断是否有新版本
            return isNewVersion() ? NewFeatureViewController() : WelcomeViewController()
        }
        //没有登录就去登录
        return MainViewController()
    }
    //判断是否有新版本
    private func isNewVersion() -> Bool{
        //加载info.plist
        //获取当前版本号
        let currentVersion = NSBundle.mainBundle().infoDictionary!["CFBundleShortVersionString"] as! String
        //获取上一版本号
        let defaults = NSUserDefaults.standardUserDefaults()
        let sandboxVersion = (defaults.objectForKey("nversion") as? String) ?? "0.0"
        //比较
        if currentVersion.compare(sandboxVersion) == NSComparisonResult.OrderedDescending{
            CJLog("有新版本")
            defaults.setObject(currentVersion, forKey: "nversion")
            return true
        }
        return false
    }
}

