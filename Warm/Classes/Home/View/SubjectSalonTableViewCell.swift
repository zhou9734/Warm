//
//  SubjectSalonTableViewCell.swift
//  Warm
//
//  Created by zhoucj on 16/9/23.
//  Copyright © 2016年 zhoucj. All rights reserved.
//

import UIKit

class SubjectSalonTableViewCell: UITableViewCell {
    //type = 2
    var item: WItem?{
        didSet{
            guard let _item = item else{
                return
            }
            guard let salon = _item.salon else {
                return
            }
            guard let user = salon.user else {
                return
            }
            postImageView.sd_setImageWithURL(NSURL(string: salon.avatar!), placeholderImage: placeholderImage)
            descLbl.text = salon.title
            iconImageView.sd_setImageWithURL(NSURL(string: user.avatar!), placeholderImage: placeholderImage)
            nicknameLbl.text = user.nickname
            contentView.layoutIfNeeded()
        }
    }
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        setupConstaint()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI(){
        contentView.addSubview(bgView)
        contentView.addSubview(postImageView)
        contentView.addSubview(tagImageView)
        contentView.addSubview(descLbl)
        contentView.addSubview(iconImageView)
        contentView.addSubview(nicknameLbl)
    }
    private func setupConstaint(){
        bgView.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(contentView.snp_left).offset(15)
            make.right.equalTo(contentView.snp_right).offset(-15)
            make.top.equalTo(contentView.snp_top).offset(10)
            make.bottom.equalTo(contentView.snp_bottom).offset(-10)
        }
        postImageView.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(bgView.snp_top).offset(10)
            make.left.equalTo(bgView.snp_left).offset(10)
            make.bottom.equalTo(bgView.snp_bottom).offset(-10)
            make.width.equalTo(ScreenWidth * 0.5)
        }
        tagImageView.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(bgView.snp_top).offset(5)
            make.left.equalTo(bgView.snp_left).offset(5)
            make.width.equalTo(50)
            make.height.equalTo(19)
        }
        descLbl.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(bgView.snp_top).offset(10)
            make.left.equalTo(postImageView.snp_right).offset(10)
            make.right.equalTo(bgView.snp_right).offset(-10)
            make.height.equalTo(55)
        }
        iconImageView.snp_makeConstraints { (make) -> Void in
            make.bottom.equalTo(bgView.snp_bottom).offset(-10)
            make.left.equalTo(postImageView.snp_right).offset(10)
            make.size.equalTo(CGSize(width: 24, height: 24))
        }
        nicknameLbl.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(iconImageView.snp_right).offset(3)
            make.bottom.equalTo(bgView.snp_bottom).offset(-15)
            make.right.equalTo(bgView.snp_right).offset(-10)
        }
    }
    private lazy var bgView: UIView = {
        let v = UIView()
        v.backgroundColor = SpliteColor
        v.layer.cornerRadius = 6
        v.layer.masksToBounds = true
        return v
    }()
    private lazy var postImageView : UIImageView = {
        let iv = UIImageView()
        let bgSize = self.bgView.frame.size
        return iv
    }()

    private lazy var tagImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "shalonLabel_35x13_")
        return iv
    }()

    private lazy var descLbl: UILabel = {
        let lbl = UILabel()
        lbl.numberOfLines = 0
        lbl.textColor = UIColor.grayColor()
        lbl.textAlignment = .Left
        lbl.font = UIFont.systemFontOfSize(15)
        return lbl
    }()

    private lazy var iconImageView: UIImageView = {
        let iv = UIImageView()
        iv.layer.cornerRadius = 12
        iv.layer.masksToBounds = true
        return iv
    }()

    private lazy var nicknameLbl: UILabel = {
        let lbl = UILabel()
        lbl.textColor = UIColor.darkGrayColor()
        lbl.textAlignment = .Left
        lbl.font = UIFont.systemFontOfSize(14)
        return lbl
    }()
}
