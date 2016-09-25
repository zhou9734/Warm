//
//  ClassesHeadView.swift
//  Warm
//
//  Created by zhoucj on 16/9/24.
//  Copyright © 2016年 zhoucj. All rights reserved.
//

import UIKit

class ClassesHeadView: UIView {
    var offsetY: CGFloat = 0
    let _width = ScreenWidth - 30
    var classes: WClass?{
        didSet{
            guard let _classes = classes else{
                return
            }
            setupUI(_classes)
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.whiteColor()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI(_classes: WClass){
        postImageView.sd_setImageWithURL(NSURL(string: _classes.images!)!, placeholderImage: placeholderImage)
        postImageView.frame = CGRect(x: 0, y: self.offsetY, width: ScreenWidth, height: 230)
        offsetY = offsetY + 250
        addSubview(postImageView)
        //标题
        let titleHieght = titleLbl.getHeightByWidth(_width, title: _classes.name!, font: titleLbl.font)
        titleLbl.text = _classes.name
        titleLbl.frame = CGRect(x: 15.0, y: offsetY, width: _width, height: titleHieght)
        offsetY = offsetY + titleHieght + 5
        addSubview(titleLbl)
        //标签
        var offsetX: CGFloat = 15
        for i in 0..<_classes.tags!.count{
            let tag = _classes.tags![i]
            let tagLbl = createTagLbl()
            tagLbl.text = tag.name
            let tagLblWidth = tagLbl.getWidthWithTitle(tag.name!, font: tagLbl.font)
            tagLbl.frame = CGRect(x: offsetX, y: offsetY , width: tagLblWidth, height: 15)
            offsetX = offsetX + tagLblWidth + 5
            addSubview(tagLbl)
        }
        offsetY = offsetY + 25
        spliteLine.frame = CGRect(x: 15.0, y: offsetY, width: _width, height: 1.0)
        offsetY = offsetY + 20
        addSubview(spliteLine)
        //描述
        let descLblHeight = descLbl.getHeightByWidth(_width, title: _classes.desc!, font: descLbl.font)
        descLbl.text = _classes.desc
        descLbl.frame = CGRect(x: 15.0, y: offsetY, width: _width, height: descLblHeight)
        offsetY = offsetY + descLblHeight + 10
        addSubview(descLbl)

        spliteView.frame = CGRect(x: 0, y: offsetY, width: ScreenWidth, height: 10.0)
        addSubview(spliteView)
        offsetY = offsetY + 10
        layoutIfNeeded()
    }

    func calculate(_classes: WClass) -> CGFloat{
        self.classes = _classes
        return  offsetY
    }
    lazy var postImageView = UIImageView()

    private lazy var titleLbl: UILabel = {
        let lbl = UILabel()
        lbl.numberOfLines = 0
        lbl.textColor = UIColor.blackColor()
        lbl.font = UIFont.systemFontOfSize(25)
        lbl.textAlignment = .Left
        return lbl
    }()

    private lazy var spliteLine: UIView = {
        let v = UIView()
        v.backgroundColor = SpliteColor
        return v
    }()
    private func createTagLbl() -> UILabel{
        let lbl = UILabel()
        lbl.textColor = UIColor.grayColor()
        lbl.textAlignment = .Center
        lbl.font = UIFont.systemFontOfSize(14)
        lbl.layer.borderWidth = 1
        lbl.layer.borderColor = UIColor.grayColor().CGColor
        return lbl
    }
    private lazy var descLbl: UILabel = {
        let lbl = UILabel()
        lbl.numberOfLines = 0
        lbl.textColor = UIColor.grayColor()
        lbl.font = UIFont.systemFontOfSize(16)
        lbl.textAlignment = .Left
        return lbl
    }()
    private lazy var spliteView: UIView = {
        let v = UIView()
        v.backgroundColor = SpliteColor
        return v
    }()
}
