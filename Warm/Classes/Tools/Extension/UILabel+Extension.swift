//
//  UILabel+Extension.swift
//  Warm
//
//  Created by zhoucj on 16/9/24.
//  Copyright © 2016年 zhoucj. All rights reserved.
//

import UIKit

extension UILabel{
    //获取label的高度(NSMutableAttributedString)
    func getHeightByWidthOfAttributedString(width: CGFloat, title: String, font: UIFont) -> CGFloat{
        let lbl = UILabel(frame: CGRect(x: 0, y: 0, width: width, height: 0))
        lbl.font = font
        lbl.numberOfLines = 0
        let attrStr = NSMutableAttributedString(string: title)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 5
        attrStr.addAttribute(NSParagraphStyleAttributeName, value: paragraphStyle, range: NSMakeRange(0, title.characters.count))
        lbl.attributedText = attrStr
        lbl.sizeToFit()
        let height = lbl.frame.size.height
        return height
    }

    //获取label的高度(普通文本)
    func getHeightByWidth(width: CGFloat, title: String, font: UIFont) -> CGFloat{
        let lbl = UILabel(frame: CGRect(x: 0, y: 0, width: width, height: 0))
        lbl.text = title
        lbl.font = font
        lbl.numberOfLines = 0
        lbl.sizeToFit()
        let height = lbl.frame.size.height
        return height
    }
    //自适应宽度
    func getWidthWithTitle(title: String, font: UIFont) -> CGFloat{
        let lbl = UILabel(frame: CGRect(x: 0, y: 0, width: 1000, height: 0))
        lbl.text = title
        lbl.font = font
        lbl.sizeToFit()
        return lbl.frame.size.width
    }

}
