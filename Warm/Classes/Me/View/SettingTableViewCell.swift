//
//  SettingTableViewCell.swift
//  Warm
//
//  Created by zhoucj on 16/9/19.
//  Copyright © 2016年 zhoucj. All rights reserved.
//

import UIKit

class SettingTableViewCell: UITableViewCell {
    var setting: WSetting?{
        didSet{
            leftLbl.text = setting?.leftTitle
            rightLbl.text = setting?.rightTitle
            if let t = setting?.leftTitle where t == "清理缓存"{
                rightLbl.text = String().stringByAppendingFormat("%.2f M", FileTool.folderSize("".cachesDir()))
            }
        }
    }
    var type: Int = -1{
        didSet{
            if type == 0{
                pushSwitch.hidden = true
                pushSwitchBg.hidden = true
            }else if type == 1{
                pushSwitch.hidden = false
                pushSwitchBg.hidden = false
                rightArrow.hidden = true
            }else if type == 2{
                pushSwitch.hidden = true
                pushSwitchBg.hidden = true
                rightLbl.hidden = true
            }

        }
    }
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func setupUI(){
        contentView.addSubview(leftLbl)
        contentView.addSubview(rightLbl)
        contentView.addSubview(rightArrow)
        contentView.addSubview(pushSwitch)
        contentView.addSubview(pushSwitchBg)
    }
    private lazy var leftLbl: UILabel = {
        let lbl = UILabel()
        lbl.textColor = UIColor.lightGrayColor()
        lbl.textAlignment = .Left
        lbl.font = UIFont.systemFontOfSize(15)
        lbl.frame = CGRect(x: 20.0, y: 10, width: 120.0, height: 20.0)
        return lbl
    }()
    private lazy var rightLbl: UILabel = {
        let lbl = UILabel()
        lbl.textColor = UIColor.lightGrayColor()
        lbl.textAlignment = .Right
        lbl.font = UIFont.systemFontOfSize(15)
        lbl.frame = CGRect(x: ScreenWidth - 218, y: 10, width: 180.0, height: 20.0)
        return lbl
    }()
    private lazy var rightArrow: UIButton = {
        let btn = UIButton()
        btn.setBackgroundImage(UIImage(named: "common_icon_arrow"), forState: .Normal)
        btn.frame = CGRect(x: ScreenWidth - 28, y: 10, width: 17.0, height: 17.0)
        return btn
    }()
    private lazy var pushSwitch: UISwitch = {
        let ps = UISwitch()
        ps.frame = CGRect(x: ScreenWidth - 70, y: 10.0, width: 65.0, height: 38.0)
        ps.hidden = true
        return ps
    }()
    
    private lazy var pushSwitchBg: UILabel = {
        let lbl = UILabel()
        lbl.frame = CGRect(x: ScreenWidth - 70, y: 10.0, width: 53.0, height: 33.0)
        lbl.layer.borderWidth = 2
        lbl.layer.borderColor = WarmBlueColor.CGColor
        lbl.layer.masksToBounds = true
        lbl.layer.cornerRadius = 16
        lbl.hidden = true
        return lbl
    }()

}
