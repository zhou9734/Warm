//
//  NavigationController.swift
//  Warm
//
//  Created by zhoucj on 16/9/12.
//  Copyright © 2016年 zhoucj. All rights reserved.
//

import UIKit

class NavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let appearance = UINavigationBar.appearance()
        var textAttrs: [String : AnyObject] = Dictionary()
        textAttrs[NSForegroundColorAttributeName] = UIColor.blackColor()
        textAttrs[NSFontAttributeName] = UIFont.boldSystemFontOfSize(20) //字体加粗
        appearance.titleTextAttributes = textAttrs
        //解决自定义返回按键的时候,滑动返回的手势经常会失效
        interactivePopGestureRecognizer?.delegate = self
    }

    lazy var backBtn: UIButton = UIButton(backTarget: self, action: "backBtnAction")

    @objc private func backBtnAction() {
        popViewControllerAnimated(true)
    }

    override func pushViewController(viewController: UIViewController, animated: Bool) {
        if childViewControllers.count > 0 {
            viewController.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backBtn)
            viewController.hidesBottomBarWhenPushed = true
        }
        super.pushViewController(viewController, animated: animated)
        //解决自定义返回按键的时候,滑动返回的手势经常会失效
        interactivePopGestureRecognizer?.enabled = true
    }
}
extension NavigationController: UIGestureRecognizerDelegate,UINavigationControllerDelegate{

}
