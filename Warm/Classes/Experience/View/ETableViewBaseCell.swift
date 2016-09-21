//
//  ExperienceTableViewCell.swift
//  Warm
//
//  Created by zhoucj on 16/9/14.
//  Copyright © 2016年 zhoucj. All rights reserved.
//

import UIKit
import SDWebImage

class ETableViewBaseCell: UITableViewCell {
    var classes: WClass?{
        didSet{
            guard let _class = classes else{
                return
            }
            imgView.sd_setImageWithURL(NSURL(string: _class.images!), placeholderImage: placeholderImage)
            titleLbl.text = _class.name
            areaTimelbl.text = _class.areatimeStr
            if let tags = _class.tags{
                var tagsStr = ""
                for t in tags{
                    tagsStr = tagsStr + t.name!
                }
                if tagsStr != ""{
                    taglbl.hidden = false
                    taglbl.text = tagsStr
                }
            }
        }
    }
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        setupUI()
    }

    func setupUI(){
        contentView.addSubview(imgView)
        contentView.addSubview(titleLbl)
        contentView.addSubview(taglbl)
        contentView.addSubview(areaTimelbl)
        contentView.addSubview(splieLine)
        imgView.snp_makeConstraints { (make) -> Void in
            make.left.right.top.equalTo(contentView)
            make.height.equalTo(210)
        }
        titleLbl.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(imgView.snp_bottom).offset(10)
            make.left.equalTo(contentView.snp_left).offset(15)
            make.right.equalTo(taglbl.snp_left).offset(-6)
            make.height.equalTo(20)
        }
        taglbl.preferredMaxLayoutWidth = 160
        taglbl.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(imgView.snp_bottom).offset(15)
            make.height.equalTo(15)
        }
        areaTimelbl.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(titleLbl.snp_bottom).offset(10)
            make.left.equalTo(contentView.snp_left).offset(15)
            make.width.equalTo(ScreenWidth - 30)
        }
        splieLine.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(areaTimelbl.snp_bottom).offset(10)
            make.left.equalTo(contentView.snp_left).offset(15)
            make.width.equalTo(ScreenWidth - 30)
            make.height.equalTo(1.5)
        }
        addImgTag()
    }
    func addImgTag(){

    }
    //图片
    lazy var imgView: UIImageView = {
        let iv = UIImageView()
        return iv
    }()
    //标题
    lazy var titleLbl: UILabel = {
        let lbl = UILabel()
        lbl.textColor = UIColor.blackColor()
        lbl.textAlignment = .Left
        return lbl
    }()
    //标签
    lazy var taglbl: UILabel = {
        let lbl = UILabel()
        lbl.textColor = UIColor.grayColor()
        lbl.textAlignment = .Center
        lbl.font = UIFont.systemFontOfSize(14)
        lbl.layer.borderWidth = 1
        lbl.layer.borderColor = UIColor.grayColor().CGColor
        lbl.hidden = true
        return lbl
    }()
    //区域和时间
    lazy var areaTimelbl: UILabel = {
        let lbl = UILabel()
        lbl.textColor = UIColor.grayColor()
        lbl.textAlignment = .Left
        lbl.font = UIFont.systemFontOfSize(14)
        return lbl
    }()
    //分割线
    lazy var splieLine: UIView = {
        let _view = UIView()
        _view.backgroundColor = SpliteColor
        return _view
    }()
}
