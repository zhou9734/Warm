//
//  CBtnContainerView.swift
//  Warm
//
//  Created by zhoucj on 16/9/25.
//  Copyright © 2016年 zhoucj. All rights reserved.
//

import UIKit

class CBtnContainerView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.whiteColor()
        setupUI()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func setupUI(){
        //三个按钮
        let btnWidth = (ScreenWidth - 2) / 3
        experiDetailBtn.frame = CGRect(x: 0 , y: 0, width: btnWidth, height: 45.0)
        addSubview(experiDetailBtn)
        experiDetailBtn.selected = true
        leftSpliteView.frame = CGRect(x: btnWidth, y: 7, width: 1.0, height: 30.0)
        addSubview(leftSpliteView)
        userBtn.frame = CGRect(x: btnWidth + 1, y: 0, width: btnWidth, height: 45.0)
        addSubview(userBtn)
        rightSpliteView.frame = CGRect(x: 2*btnWidth + 1, y: 7, width: 1.0, height: 30.0)
        addSubview(rightSpliteView)
        contactBtn.frame = CGRect(x: 2*btnWidth + 2, y: 0, width: btnWidth, height: 45.0)
        addSubview(contactBtn)
    }
    private lazy var experiDetailBtn: UIButton = {
        let btn = UIButton()
        btn.setTitle("体验详情", forState: .Normal)
        btn.setTitleColor(UIColor.blackColor(), forState: .Selected)
        btn.setTitleColor(UIColor.grayColor(), forState: .Normal)
        btn.titleLabel?.textAlignment = .Center
        btn.tag = 1
        btn.addTarget(self, action: Selector("experiDetailBtnClick:"), forControlEvents: .TouchUpInside)
        btn.backgroundColor = Color_GlobalBackground
        return btn
    }()
    private lazy var leftSpliteView : UIView = {
        let v = UIView()
        v.backgroundColor = SpliteColor
        return v
    }()

    private lazy var userBtn: UIButton = {
        let btn = UIButton()
        btn.setTitle("手艺人", forState: .Normal)
        btn.setTitleColor(UIColor.blackColor(), forState: .Selected)
        btn.setTitleColor(UIColor.grayColor(), forState: .Normal)
        btn.titleLabel?.textAlignment = .Center
        btn.tag = 2
        btn.addTarget(self, action: Selector("experiDetailBtnClick:"), forControlEvents: .TouchUpInside)
        btn.backgroundColor = Color_GlobalBackground
        return btn
    }()
    private lazy var rightSpliteView : UIView = {
        let v = UIView()
        v.backgroundColor = SpliteColor
        return v
    }()
    private lazy var contactBtn: UIButton = {
        let btn = UIButton()
        btn.setTitle("如何体验", forState: .Normal)
        btn.setTitleColor(UIColor.blackColor(), forState: .Selected)
        btn.setTitleColor(UIColor.grayColor(), forState: .Normal)
        btn.titleLabel?.textAlignment = .Center
        btn.tag = 3
        btn.addTarget(self, action: Selector("experiDetailBtnClick:"), forControlEvents: .TouchUpInside)
        btn.backgroundColor = Color_GlobalBackground
        return btn
    }()
    @objc private func experiDetailBtnClick(btn: UIButton){
        NSNotificationCenter.defaultCenter().postNotificationName(SectionForSectionIndex, object: btn.tag)
    }
}
