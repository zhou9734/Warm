//
//  UIView+Extension.swift
//  Warm
//
//  Created by zhoucj on 16/1/12.
//  Copyright © 2016年 zhoucj. All rights reserved.


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