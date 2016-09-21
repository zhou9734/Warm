//
//  BaseViewController.swift
//  Warm
//
//  Created by zhoucj on 16/9/13.
//  Copyright © 2016年 zhoucj. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    //默认城市代码 
    var citycode: String = NSUserDefaults.standardUserDefaults().valueForKey(cityCodeKey) as! String
    //默认页数
    var page: Int = 1
    //每页数量
    let count: Int = 10

}
