//
//  UIView+Extension.swift
//  LoveFreshBeen
//
//  Created by 维尼的小熊 on 16/1/12.
//  Copyright © 2016年 tianzhongtao. All rights reserved.
//  GitHub地址:https://github.com/ZhongTaoTian/LoveFreshBeen
//  Blog讲解地址:http://www.jianshu.com/p/879f58fe3542
//  小熊的新浪微博:http://weibo.com/5622363113/profile?topnav=1&wvr=6

import UIKit

/// 对UIView的扩展
extension UIView {
    /// X值
    var x: CGFloat {
        return frame.origin.x
    }
    /// Y值
    var y: CGFloat {
        return frame.origin.y
    }
    /// 宽度
    var width: CGFloat {
        return frame.size.width
    }
    ///高度
    var height: CGFloat {
        return frame.size.height
    }
    var size: CGSize {
        return frame.size
    }
    var point: CGPoint {
        return frame.origin
    }
}