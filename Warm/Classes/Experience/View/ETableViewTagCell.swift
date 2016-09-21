//
//  ETableViewTagCell.swift
//  Warm
//
//  Created by zhoucj on 16/9/17.
//  Copyright © 2016年 zhoucj. All rights reserved.
//

import UIKit

class ETableViewTagCell: ETableViewBaseCell {
    override var classes: WClass?{
        didSet{
            if let tags_bds = classes!.tags_bd{
                var tags_bdsStr = ""
                for t in tags_bds{
                    tags_bdsStr = tags_bdsStr + t.name!
                }
                if tags_bdsStr != ""{
                    imgTag.hidden = false
                    imgTag.setTitle(tags_bdsStr, forState: .Normal)
                }
            }
        }
    }
    override func addImgTag() {
        contentView.addSubview(imgTag)
        imgTag.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(contentView.snp_top).offset(-3)
            make.left.equalTo(contentView.snp_left).offset(15)
            make.width.equalTo(60)
            make.height.equalTo(30)
        }
    }

    let titleColor = UIColor.whiteColor()
    let imgTagBgImager = UIImage.imageWithColor(UIColor.orangeColor())
    private lazy var imgTag: UIButton = {
        let btn = UIButton()
        btn.setTitleColor(self.titleColor, forState: .Normal)
        btn.titleLabel?.font = UIFont.systemFontOfSize(15)
        btn.layer.cornerRadius = 6
        btn.layer.masksToBounds = true
        btn.setBackgroundImage(self.imgTagBgImager, forState: .Normal)
        btn.hidden = true
        return btn
    }()

}
