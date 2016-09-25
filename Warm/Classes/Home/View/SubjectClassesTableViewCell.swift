//
//  SubjectClassesTableViewCell.swift
//  Warm
//
//  Created by zhoucj on 16/9/23.
//  Copyright © 2016年 zhoucj. All rights reserved.
//

import UIKit

class SubjectClassesTableViewCell: UITableViewCell {
    //type = 1
    var item: WItem?{
        didSet{
            guard let _item = item else{
                return
            }
            guard let classes = _item.classes else {
                return
            }
            bgImageView.sd_setImageWithURL(NSURL(string: classes.images!), placeholderImage: placeholderImage)
            titleLbl.text = classes.name
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
        contentView.addSubview(bgImageView)
        contentView.addSubview(tagImageView)
        contentView.addSubview(titleLbl)
    }
    private func setupConstaint(){
        bgImageView.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(contentView.snp_top).offset(10)
            make.left.equalTo(contentView.snp_left).offset(15)
            make.right.equalTo(contentView.snp_right).offset(-15)
            make.bottom.equalTo(contentView.snp_bottom).offset(-10)
        }
        tagImageView.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(bgImageView.snp_top).offset(5)
            make.left.equalTo(bgImageView.snp_left).offset(10)
            make.width.equalTo(67)
            make.height.equalTo(19)
        }
        titleLbl.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(bgImageView.snp_left).offset(10)
            make.centerY.equalTo(bgImageView.snp_centerY)
            make.right.equalTo(bgImageView.snp_right).offset(-10)
        }
    }

    private lazy var bgImageView = UIImageView()

    private lazy var tagImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "courseLabel_46x13_")
        return iv
    }()

    private lazy var titleLbl: UILabel = {
        let lbl = UILabel()
        lbl.numberOfLines = 0
        lbl.textColor = UIColor.whiteColor()
        lbl.textAlignment = .Left
        let bgSize = self.bgImageView.frame.size
        return lbl
    }()

}
