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
        setImage(UIImage(named: "common_icon_arrow"), forState: .Normal)
        setTitleColor(UIColor.grayColor(), forState: .Normal)
//        sizeToFit()
    }
    override func setTitle(title: String?, forState state: UIControlState) {
        super.setTitle((title ?? "") + "   ", forState: state)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        titleLabel?.frame = CGRect(x: 0, y: 0, width: frame.width - 50, height: frame.height)
        imageView?.frame = CGRect(x: frame.width - 50, y: 10, width: 17, height: 17)
    }
}
