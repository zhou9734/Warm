//
//  ExperienceTableHeadView.swift
//  Warm
//
//  Created by zhoucj on 16/9/14.
//  Copyright © 2016年 zhoucj. All rights reserved.
//

import UIKit

class ExperienceTableHeadView: UIView {
    var tags: [WTags]?{
        didSet{
            pageScrollView.tags = tags!
            textLbl.hidden = false
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
        addSubview(pageScrollView)
        addSubview(textLbl)
    }
    private lazy var pageScrollView: EPageScrollView = {
        let pageScroll = EPageScrollView(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: self.frame.size.height*0.7))
        return pageScroll
    }()
    private lazy var textLbl: UILabel = {
        let lbl = UILabel(frame: CGRect(x: 0, y: self.frame.size.height*0.7 + 15, width: ScreenWidth, height: 30))
        lbl.text = "小编精选"
        lbl.textColor = UIColor.blackColor()
        lbl.textAlignment = .Center
        lbl.font = UIFont.systemFontOfSize(20)
        lbl.hidden = true
        return lbl
    }()
}
