//
//  TableHeaderView.swift
//  Warm
//
//  Created by zhoucj on 16/9/13.
//  Copyright © 2016年 zhoucj. All rights reserved.
//

import UIKit

class HomeTableHeaderView: UIView {
    var rounds: [WRound]?{
        didSet{
            pageScrollView.rounds = rounds!
        }
    }
    var recommends: [WRecommend]?{
        didSet{
            recommendView.recommends = recommends!
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
        addSubview(recommendView)
    }
    private lazy var pageScrollView = PageScrollView(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: 160))
    private lazy var textLbl: UILabel = {
        let lbl = UILabel(frame: CGRect(x: 10, y: 170, width: 100, height: 20))
        lbl.text = "取暖精选"
        lbl.textColor = UIColor.grayColor()
        lbl.font = UIFont.systemFontOfSize(15)
        lbl.hidden = true
        return lbl
    }()
    private lazy var recommendView = RecommendView(frame: CGRect(x: 0, y: 195, width: ScreenWidth, height: 120))

}
