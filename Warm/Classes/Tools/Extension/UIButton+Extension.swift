//
//  UIButton+Extension.swift
//  ZCJWB
//
//  Created by zhoucj on 16/8/4.
//  Copyright © 2016年 zhoucj. All rights reserved.
//

import UIKit

extension UIButton{
    // 导航栏返回按钮
    convenience init(backTarget: AnyObject?, action: Selector) {
        self.init()
//        setTitle("返回", forState: .Normal)
        setImage(UIImage(named: "navigationBack_13x22_"), forState: .Normal)
        contentHorizontalAlignment = .Left
        addTarget(backTarget, action: action, forControlEvents: .TouchUpInside)
        sizeToFit()
    }

    convenience init(target: AnyObject?,backgroundImage: String, action: Selector){
        self.init()
        setBackgroundImage(UIImage(named: backgroundImage), forState: .Normal)
        addTarget(target, action: action, forControlEvents: .TouchUpInside)
        sizeToFit()
    }

    convenience init(target: AnyObject?,image: String, action: Selector,title: String){
        self.init()
        setTitle("  " + title, forState: .Normal)
        setTitleColor(UIColor.blackColor(), forState: .Normal)
        setImage(UIImage(named: image), forState: .Normal)
        addTarget(target, action: action, forControlEvents: .TouchUpInside)
        sizeToFit()
    }
}
