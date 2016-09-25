//
//  EFindDataView.swift
//  Warm
//
//  Created by zhoucj on 16/9/22.
//  Copyright © 2016年 zhoucj. All rights reserved.
//

import UIKit

class EFindDataView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func setupUI(){
        backgroundColor = Color_GlobalBackground
        addSubview(imageView)
        addSubview(msgLbl)
    }
    private lazy var imageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "nocontent_133x76_")
        iv.frame = CGRect(x: (ScreenWidth - 133.0)/2, y: (ScreenHeight - 76.0)/2, width: 133.0, height: 76.0)
        return iv
    }()
    private lazy var msgLbl: UILabel = {
        let lbl = UILabel()
        lbl.text = "没有消息"
        lbl.textAlignment = .Center
        lbl.textColor = UIColor.grayColor()
        lbl.font = UIFont.systemFontOfSize(16)
        lbl.numberOfLines = 0
        lbl.frame = CGRect(x: (ScreenWidth - 100.0)/2, y: (ScreenHeight - 76.0)/2 + 86, width: 100.0, height: 45.0)
        return lbl
    }()


}
