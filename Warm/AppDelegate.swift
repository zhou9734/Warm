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
        //友盟分享
        shareApp()
        // 创建窗口
        window = UIWindow(frame: UIScreen.mainScreen().bounds)
        window?.rootViewController = defaultsVC()
        window?.makeKeyAndVisible()
        let defaults = NSUserDefaults.standardUserDefaults()
        //出去上一次选中的城市code如果没有就默认一个
        if let _ = defaults.valueForKey(cityCodeKey) as? String {

        }else{
            defaults.setObject("440100", forKey: cityCodeKey)
        }
        return true
    }
    //其它app打开本app时调用的的方法(如要就是用于友盟分享)
    func application(application: UIApplication, openURL url: NSURL, sourceApplication: String?, annotation: AnyObject) -> Bool {
        let result = UMSocialSnsService.handleOpenURL(url)
        if !result {
            //调用其他SDK，例如支付宝SDK等
        }
        return result
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
        //没有登录就去主界面
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

    private func shareApp(){
        // 设置友盟的APPKEY
        UMSocialData.setAppKey(UMSharedAPPKey)
        // 打开新浪微博的SSO开关
        UMSocialSinaHandler.openSSOWithRedirectURL("http://sns.whalecloud.com/sina2/callback")
        //设置微信AppId，设置分享url，默认使用友盟的网址
        UMSocialWechatHandler.setWXAppId(WXAppId, appSecret: WXAppSerect, url: "http://www.umeng.com/social")
    }
}

