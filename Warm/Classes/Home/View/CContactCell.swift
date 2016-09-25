//
//  CContactCell.swift
//  Warm
//
//  Created by zhoucj on 16/9/25.
//  Copyright © 2016年 zhoucj. All rights reserved.
//

import UIKit

class CContactCell: UITableViewCell {
    var offsetY: CGFloat = 10.0
    var info: WInfo?{
        didSet{
            guard let _info = info else{
                return
            }
            setupUI(_info)
        }
    }

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI(_info: WInfo){
        let _width = ScreenWidth - 30
        //如何参与lbl
        joinTipLbl.frame = CGRect(x: 15.0, y: offsetY, width: 120, height: 30)
        contentView.addSubview(joinTipLbl)
        offsetY = offsetY + 35
        //分割线
        spliteLine.frame = CGRect(x: 15.0, y: offsetY, width: _width, height: 1.0)
        contentView.addSubview(spliteLine)
        offsetY = offsetY + 21

        //购买详细
        let buyTipLbl = createTipsLbl()
        let txt = _info.buy_tips
        let buytipHeight = buyTipLbl.getHeightByWidthOfAttributedString(_width, title: txt, font: buyTipLbl.font)
        buyTipLbl.frame = CGRect(x: 15.0, y: offsetY, width: _width, height: buytipHeight)
        let attrStr = NSMutableAttributedString(string: txt)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 4
        attrStr.addAttribute(NSParagraphStyleAttributeName, value: paragraphStyle, range: NSMakeRange(0, txt.characters.count))
        buyTipLbl.attributedText = attrStr

        offsetY = offsetY + buytipHeight + 10
        contentView.addSubview(buyTipLbl)
        //分割
        spliteView.frame = CGRect(x: 0, y: offsetY, width: ScreenWidth, height: 10)
        offsetY = offsetY + 20
        contentView.addSubview(spliteView)
        //暖提示
        warmLbl.frame = CGRect(x: 15.0, y: offsetY, width: 120, height: 30)
        contentView.addSubview(warmLbl)
        offsetY = offsetY + 35
        //分割线
        spliteLine2.frame = CGRect(x: 15.0, y: offsetY, width: _width, height: 1.0)
        contentView.addSubview(spliteLine2)
        offsetY = offsetY + 11
        //暖提示详情
        let warmTipLbl = createTipsLbl()
        let wtxt = _info.warmup_tips
        let warmtipHeight = buyTipLbl.getHeightByWidthOfAttributedString(_width, title: wtxt, font: warmTipLbl.font)
        warmTipLbl.frame = CGRect(x: 15.0, y: offsetY, width: _width, height: warmtipHeight)

        let wattrStr = NSMutableAttributedString(string: wtxt)
        wattrStr.addAttribute(NSParagraphStyleAttributeName, value: paragraphStyle, range: NSMakeRange(0, wtxt.characters.count))
        warmTipLbl.attributedText = wattrStr
        contentView.addSubview(warmTipLbl)

        offsetY = offsetY + warmtipHeight + 50
        contentView.layoutIfNeeded()
    }
    private lazy var joinTipLbl: UILabel = {
        let lbl = UILabel()
        lbl.textColor = UIColor.blackColor()
        lbl.textAlignment = .Left
        lbl.font = UIFont.systemFontOfSize(20)
        lbl.text = "如何参与"
        return lbl
    }()
    private lazy var spliteLine: UIView = {
        let v = UIView()
        v.backgroundColor = SpliteColor
        return v
    }()

    private func createTipsLbl() -> UILabel{
        let lbl = UILabel()
        lbl.textColor = UIColor.grayColor()
        lbl.textAlignment = .Left
        lbl.font = UIFont.systemFontOfSize(16)
        lbl.numberOfLines = 0
        return lbl
    }

    private lazy var spliteView: UIView = {
        let v = UIView()
        v.backgroundColor = SpliteColor
        return v
    }()
    private lazy var warmLbl: UILabel = {
        let lbl = UILabel()
        lbl.textColor = UIColor.blackColor()
        lbl.textAlignment = .Left
        lbl.font = UIFont.systemFontOfSize(20)
        lbl.text = "暖提示"
        return lbl
    }()
    private lazy var spliteLine2: UIView = {
        let v = UIView()
        v.backgroundColor = SpliteColor
        return v
    }()
    func calcuateHeight(_info: WInfo) -> CGFloat{
        self.info = _info
        return offsetY
    }
}
