//
//  CUserCell.swift
//  Warm
//
//  Created by zhoucj on 16/9/25.
//  Copyright © 2016年 zhoucj. All rights reserved.
//

import UIKit

class CUserCell: UITableViewCell {
    var offsetY: CGFloat = 10
    var teacher: WTeacher?{
        didSet{
            guard let _teacher = teacher else{
                return
            }
            setupUI(_teacher)
        }
    }

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI(teacher: WTeacher){
        let _width = ScreenWidth - 30
        userLbl.frame = CGRect(x: 15.0, y: offsetY, width: _width, height: 30)
        contentView.addSubview(userLbl)
        offsetY = offsetY + 45
        spliteLine.frame = CGRect(x: 15, y: offsetY, width: _width, height: 1)
        offsetY = offsetY + 15
        contentView.addSubview(spliteLine)

        //头像
        iconImageView.frame = CGRect(x: (ScreenWidth - 50) / 2, y: offsetY, width: 50, height: 50)
        iconImageView.sd_setImageWithURL(NSURL(string: teacher.avatar!)!, placeholderImage: placeholderImage)
        contentView.addSubview(iconImageView)
        offsetY = offsetY + 50
        //昵称
        nicknameLbl.frame = CGRect(x: (ScreenWidth - 200) / 2, y: offsetY, width: 200, height: 15)
        nicknameLbl.text = teacher.nickname
        contentView.addSubview(nicknameLbl)
        offsetY = offsetY + 30
        //个性签名
        let txt = teacher.signature
        let height = signatureLbl.getHeightByWidthOfAttributedString(_width, title: txt, font: signatureLbl.font)
        signatureLbl.frame = CGRect(x: 15.0, y: offsetY, width: _width, height: height)
        let attrStr = NSMutableAttributedString(string: txt)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 5
        attrStr.addAttribute(NSParagraphStyleAttributeName, value: paragraphStyle, range: NSMakeRange(0, txt.characters.count))
        signatureLbl.attributedText = attrStr

        contentView.addSubview(signatureLbl)
        offsetY = offsetY + height + 10
        contentView.layoutIfNeeded()

    }
    private lazy var userLbl: UILabel = {
        let lbl = UILabel()
        lbl.textColor = UIColor.blackColor()
        lbl.textAlignment = .Left
        lbl.font = UIFont.systemFontOfSize(20)
        lbl.text = "手艺人"
        return lbl
    }()

    private lazy var spliteLine: UIView = {
        let v = UIView()
        v.backgroundColor = SpliteColor
        return v
    }()

    private lazy var iconImageView: UIImageView = {
        let iv = UIImageView()
        iv.layer.cornerRadius = 25
        iv.layer.masksToBounds = true
        return iv
    }()
    private lazy var nicknameLbl: UILabel = {
        let lbl = UILabel()
        lbl.textColor = UIColor.grayColor()
        lbl.textAlignment = .Center
        lbl.font = UIFont.systemFontOfSize(14)
        return lbl
    }()
    private lazy var signatureLbl: UILabel = {
        let lbl = UILabel()
        lbl.textColor = UIColor.grayColor()
        lbl.textAlignment = .Left
        lbl.font = UIFont.systemFontOfSize(16)
        lbl.numberOfLines = 0
        return lbl
    }()

    func calucateHeight(_teacher: WTeacher) -> CGFloat{
        self.teacher = _teacher
        return offsetY
    }

}
