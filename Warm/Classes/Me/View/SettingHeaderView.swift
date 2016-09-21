//
//  SettingHeaderView.swift
//  Warm
//
//  Created by zhoucj on 16/9/18.
//  Copyright © 2016年 zhoucj. All rights reserved.
//

import UIKit

class SettingHeaderView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func setupUI(){
        backgroundColor = UIColor.whiteColor()
        addSubview(iconImage)
        addSubview(nicknameLbl)
        addSubview(descLbl)
        addSubview(rightArrow)
        if let token = Token.loadAccount() {
            iconImage.sd_setImageWithURL(NSURL(string: token.avatar!), placeholderImage: placeholderImage)
            nicknameLbl.text = token.nickname
        }
    }

    private lazy var iconImage: UIImageView = {
        let iv = UIImageView()
        iv.frame = CGRect(x: 20.0, y: 20.0, width: 50.0, height: 50.0)
        iv.layer.cornerRadius = 25
        iv.layer.masksToBounds = true
        return iv
    }()

    private lazy var nicknameLbl: UILabel = {
        let lbl = UILabel()
        lbl.frame = CGRect(x: 85.0, y: 20.0, width: 160.0, height: 20.0)
        lbl.textColor = UIColor.blackColor()
        lbl.font = UIFont.systemFontOfSize(16)
        lbl.textAlignment = .Left
        return lbl
    }()

    private lazy var descLbl: UILabel = {
        let lbl = UILabel()
        lbl.frame = CGRect(x: 85.0, y: 50.0, width: 160.0, height: 20.0)
        lbl.textColor = UIColor.grayColor()
        lbl.font = UIFont.systemFontOfSize(14)
        lbl.textAlignment = .Left
        lbl.text = "简介: 暂无"
        return lbl
    }()
    private lazy var rightArrow: UIButton = {
        let btn = UIButton()
        btn.setBackgroundImage(UIImage(named: "common_icon_arrow"), forState: .Normal)
        btn.frame = CGRect(x: ScreenWidth - 28, y: 40.0, width: 17.0, height: 17.0)
        return btn
    }()
    


}
