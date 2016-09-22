//
//  TitleButton.swift
//  ZCJWB
//
//  Created by zhoucj on 16/8/5.
//  Copyright © 2016年 zhoucj. All rights reserved.
//

import UIKit

class CustomButton: UIButton {
    //通过纯代码调用
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    //通过xib/storyboard调用
    required init?(coder aDecoder: NSCoder) {
        //系统对initWithCoder的默认实现是报一个致命错误
        //        fatalError("init(coder:) has not been implemented")
        super.init(coder: aDecoder)
        setupUI()
    }

    private func setupUI(){
        setImage(UIImage(named: "arrorDown_8x14_"), forState: .Normal)
        setImage(UIImage(named: "arrorUp_8x14_"), forState: .Selected)
        setTitleColor(UIColor(red: 150.0/255.0, green: 150.0/255.0, blue: 150.0/255.0, alpha: 1), forState: .Normal)
        titleLabel?.font = UIFont.systemFontOfSize(15)
        sizeToFit()

    }
    override func setTitle(title: String?, forState state: UIControlState) {
        super.setTitle( (title ?? "") + " ", forState: state)
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        /*
        //offsetInPlace用于控制控件移位(有时候可能不对,系统肯能会调用多次layoutSubviews)
        titleLabel?.frame.offsetInPlace(dx: -imageView!.frame.width, dy: 0)
        imageView?.frame.offsetInPlace(dx: titleLabel!.frame.width, dy: 0)
        */
        titleLabel?.frame.origin.x = frame.size.width * 0.25
        imageView?.frame.origin.x = titleLabel!.frame.width + frame.size.width * 0.25
    }

}

