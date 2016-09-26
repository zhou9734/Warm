//
//  SalonHeadView.swift
//  Warm
//
//  Created by zhoucj on 16/9/23.
//  Copyright © 2016年 zhoucj. All rights reserved.
//

import UIKit

class SalonHeadView: UIView {
    var user: WUser?{
        didSet{
            guard let _user = user else{
                return
            }
            iconImage.sd_setImageWithURL(NSURL(string: _user.avatar!), placeholderImage: placeholderImage)
            let nicknameLblWidth = nicknameLbl.getWidthWithTitle(_user.nickname!, font: nicknameLbl.font)
            nicknameLbl.text = _user.nickname
            nicknameLbl.frame = CGRect(x: 85.0, y: 20.0, width: nicknameLblWidth, height: 20.0)
            tagImageView.frame = CGRect(x: 85.0 + nicknameLblWidth, y: 20.0, width: 67.0, height: 18.0)
            descLbl.text = _user.signature ?? "简介: 暂无"
            tagImageView.hidden = false
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
        backgroundColor = UIColor.whiteColor()
        addSubview(iconImage)
        addSubview(nicknameLbl)
        addSubview(tagImageView)
        addSubview(descLbl)
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
        lbl.frame = CGRect(x: 85.0, y: 20.0, width: 120.0, height: 20.0)
        lbl.textColor = UIColor.blackColor()
        lbl.font = UIFont.systemFontOfSize(16)
        lbl.textAlignment = .Left
        lbl.preferredMaxLayoutWidth = 160
        return lbl
    }()
    private lazy var tagImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "topicowner_66x18_")
        iv.frame = CGRect(x: 151.0, y: 20.0, width: 67.0, height: 18.0)
        iv.hidden = true
        return iv
    }()

    private lazy var descLbl: UILabel = {
        let lbl = UILabel()
        lbl.frame = CGRect(x: 85.0, y: 50.0, width: 260.0, height: 20.0)
        lbl.textColor = UIColor.grayColor()
        lbl.font = UIFont.systemFontOfSize(14)
        lbl.textAlignment = .Left
        return lbl
    }()

}
