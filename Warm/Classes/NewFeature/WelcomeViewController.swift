//
//  WelcomeViewController.swift
//  Warm
//
//  Created by zhoucj on 16/9/16.
//  Copyright © 2016年 zhoucj. All rights reserved.
//

import UIKit

class WelcomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.whiteColor()
        view.addSubview(imageView)
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        unowned let tmpSelf = self
        //延时进入主ViewController
        let time = dispatch_time(DISPATCH_TIME_NOW,Int64(1.0 * Double(NSEC_PER_SEC)))
        dispatch_after(time, dispatch_get_main_queue(), { () -> Void in

            UIApplication.sharedApplication().setStatusBarHidden(false, withAnimation: UIStatusBarAnimation.Fade)

            let time1 = dispatch_time(DISPATCH_TIME_NOW,Int64(0.5 * Double(NSEC_PER_SEC)))
            dispatch_after(time1, dispatch_get_main_queue(), { () -> Void in
                //跳转到主页面
                NSNotificationCenter.defaultCenter().postNotificationName(SwitchRootViewController, object: true, userInfo: ["image" : tmpSelf.imageView.image!])
            })
        })
    }

    private lazy var imageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "PicSignIn&Up_375x667_")
        iv.frame = ScreenBounds
        return iv
    }()

}
