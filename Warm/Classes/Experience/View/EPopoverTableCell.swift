//
//  EPopoverTableCell.swift
//  Warm
//
//  Created by zhoucj on 16/9/21.
//  Copyright © 2016年 zhoucj. All rights reserved.
//

import UIKit

class EPopoverTableCell: UITableViewCell {
    var dict: WDict?{
        didSet{
            guard let _dict = dict else{
                return
            }
            keyLbl.text = _dict.name
            if let key = selectedKey {
                if key == dict?.code{
                    iconImageView.hidden = false
                    return
                }
            }else{
                iconImageView.hidden = true
            }
        }
    }
    var selectedKey: Int64?
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI(){
        contentView.addSubview(keyLbl)
        contentView.addSubview(iconImageView)
    }
    private lazy var keyLbl: UILabel = {
        let btnWidth: CGFloat = 100
        let x = ScreenWidth * 0.5 - btnWidth * 0.60
        let lbl = UILabel()
        lbl.textColor = UIColor(red: 150.0/255.0, green: 150.0/255.0, blue: 150.0/255.0, alpha: 1)
        lbl.font = UIFont.systemFontOfSize(14)
        lbl.textAlignment = .Center
        lbl.frame = CGRect(x: x, y: 10, width: btnWidth, height: 25)
        return lbl
    }()
    private lazy var iconImageView: UIImageView = {
        let btnWidth: CGFloat = 150
        let x = ScreenWidth * 0.5
        let iv = UIImageView()
        iv.image = UIImage(named: "ico_make_42x33")
        iv.frame = CGRect(x: x + 25, y: 15, width: 20, height: 16)
        iv.hidden = true
        return iv
    }()

    func resetLbl(){
        iconImageView.hidden = true
    }
}
