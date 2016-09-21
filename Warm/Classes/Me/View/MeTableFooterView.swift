//
//  MeTableFooterView.swift
//  Warm
//
//  Created by zhoucj on 16/9/18.
//  Copyright © 2016年 zhoucj. All rights reserved.
//

import UIKit

class MeTableFooterView: UIView {
    var menu: Menu?{
        didSet{
            guard let _menu = menu else{
                return
            }
            iconImageView.image = UIImage(named: _menu.image!)
            nameLbl.text = _menu.name
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI(){
        backgroundColor = UIColor(white: 0.93, alpha: 1.0)
        contentView.addSubview(iconImageView)
        contentView.addSubview(nameLbl)
        contentView.addSubview(rightArrow)
        addSubview(contentView)
    }

    private lazy var contentView: UIView = {
        let v = UIView(frame: CGRect(x: 0.0, y: 10, width: ScreenWidth, height: 55))
        v.backgroundColor = UIColor.whiteColor()
        let gesture = UITapGestureRecognizer(target: self, action: Selector("settingClick"))
        //scrollView同样要添加事件
        v.userInteractionEnabled = true
        v.addGestureRecognizer(gesture)

        return v
    }()

    private lazy var iconImageView: UIImageView = {
        let iv = UIImageView()
        iv.frame = CGRect(x: 20.0, y: 20.0, width: 24, height: 24)
        return iv
    }()

    private lazy var nameLbl: UILabel = {
        let lbl = UILabel()
        lbl.frame = CGRect(x: 54.0, y: 20.0, width: ScreenWidth - 100, height: 24.0)
        lbl.textColor = UIColor.lightGrayColor()
        lbl.textAlignment = .Left
        lbl.font = UIFont.systemFontOfSize(16)
        return lbl
    }()

    private lazy var rightArrow: UIButton = {
        let btn = UIButton()
        btn.setBackgroundImage(UIImage(named: "common_icon_arrow"), forState: .Normal)
        btn.frame = CGRect(x: ScreenWidth - 33, y: 20.0, width: 17.0, height: 17.0)
        return btn
    }()

    @objc private func settingClick(){
        NSNotificationCenter.defaultCenter().postNotificationName(SettingClickNotication, object: self)
    }
}
