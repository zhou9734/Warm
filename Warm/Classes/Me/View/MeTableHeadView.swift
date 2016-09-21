//
//  MeTableHeadView.swift
//  Warm
//
//  Created by zhoucj on 16/9/17.
//  Copyright © 2016年 zhoucj. All rights reserved.
//

import UIKit
import SDWebImage
class MeTableHeadView: UIView {
    var token: Token?{
        didSet{
            guard let _token = token else{
                return
            }
            unowned let tmpSelf = self
            bgImageView.sd_setImageWithURL(NSURL(string: _token.avatar!), placeholderImage: placeholderImage, completed: { (image, error, _, _) -> Void in
                tmpSelf.iconImageView.image = image
                tmpSelf.bgImageView.image = image.applyLightEffect()
            })
            nicknameLbl.text = _token.nickname!
            if let signature = _token.signature where signature != ""{
                signatureLbl.text = signature
            }else{
                signatureLbl.text = "一段美好的简介,总需要时间的推敲"
            }

        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupConstraint()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func setupUI(){
        addSubview(bgImageView)
        addSubview(iconImageView)
        addSubview(nicknameLbl)
        addSubview(signatureLbl)
    }
    private func setupConstraint(){
        iconImageView.snp_makeConstraints { (make) -> Void in
            make.centerY.equalTo(self.snp_centerY).offset(-30)
            make.centerX.equalTo(self.snp_centerX)
            make.size.equalTo(CGSize(width: 50.0, height: 50.0))
        }
        nicknameLbl.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(iconImageView.snp_bottom).offset(10)
            make.centerX.equalTo(self.snp_centerX)
            make.size.equalTo(CGSize(width: 120.0, height: 25))
        }
        signatureLbl.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(nicknameLbl.snp_bottom).offset(10)
            make.centerX.equalTo(self.snp_centerX)
            make.size.equalTo(CGSize(width: ScreenWidth - 80, height: 25))
        }
    }

    //背景
    private lazy var bgImageView: UIImageView = {
        let iv = UIImageView()
        iv.frame = CGRect(x: 0.0, y: 0.0, width: self.frame.size.width, height: self.frame.size.height)
        return iv
    }()
    //头像
    private lazy var iconImageView: UIImageView = {
        let iv = UIImageView()
        iv.layer.cornerRadius = 25
        iv.layer.masksToBounds = true
        return iv
    }()
    //昵称
    private lazy var nicknameLbl: UILabel = {
        let lbl = UILabel()
        lbl.textAlignment = .Center
        lbl.textColor = UIColor.whiteColor()
        lbl.font = UIFont.systemFontOfSize(17)
        return lbl
    }()
    //个性签名
    private lazy var signatureLbl: UILabel = {
        let lbl = UILabel()
        lbl.textAlignment = .Center
        lbl.textColor = UIColor.whiteColor()
        lbl.font = UIFont.systemFontOfSize(15)
        return lbl
    }()

}
