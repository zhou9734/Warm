//
//  SalonScrollView.swift
//  Warm
//
//  Created by zhoucj on 16/9/24.
//  Copyright © 2016年 zhoucj. All rights reserved.
//

import UIKit

class SalonScrollView: UIScrollView {
    var offsetY: CGFloat = 15
    var salon: WSalon?{
        didSet{
            guard let _salon = salon else{
                return
            }
            tableHeadView.user = _salon.user
            let width = ScreenWidth - 30
            titleLbl.text = _salon.title
            let titleHeight = titleLbl.getHeightByWidth(width, title: titleLbl.text!, font: titleLbl.font)
            titleLbl.frame = CGRect(x: 15, y: offsetY + 10, width: width, height: titleHeight)
            offsetY = offsetY + titleHeight + 10
            addSubview(titleLbl)
            timeLbl.text = "\(NSDate.formatterData(_salon.created_at, formatterStr: "MM-dd"))"
            timeLbl.frame = CGRect(x: 15, y: offsetY + 8, width: 120, height: 10)
            offsetY = offsetY + 20
            addSubview(timeLbl)
            for i in _salon.content{
                if i.hasPrefix("<p>"){
                    let txt = i.substring(3, (i.characters.count - 4))
                    let lbl = createLbl()
                    let height = lbl.getHeightByWidthOfAttributedString(width, title: txt, font: lbl.font)
                    lbl.frame = CGRect(x: 15.0, y: offsetY + 15, width: width, height: height)
                    let attrStr = NSMutableAttributedString(string: txt)
                    let paragraphStyle = NSMutableParagraphStyle()
                    paragraphStyle.lineSpacing = 5
                    attrStr.addAttribute(NSParagraphStyleAttributeName, value: paragraphStyle, range: NSMakeRange(0, txt.characters.count))
                    lbl.attributedText = attrStr

                    offsetY = offsetY + height + 15
                    addSubview(lbl)
                }else if i.hasPrefix("<img"){
                    let iv = createImg(i)
                    iv.frame = CGRect(x: 0, y: offsetY + 15.0, width: ScreenWidth, height: 220.0)
                    offsetY = offsetY + 220.0 + 15
                    addSubview(iv)
                }
            }
            followAndCommentLbl.text = "收藏 \(_salon.follow_count)      参与 \(_salon.comment_count)"
            followAndCommentLbl.frame = CGRect(x: 15.0, y: offsetY + 15, width: ScreenWidth * 0.5, height: 22)
            offsetY = offsetY + 30
            addSubview(followAndCommentLbl)
            contentSize = CGSize(width: ScreenWidth, height: offsetY)
            layoutIfNeeded()
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
        backgroundColor = Color_GlobalBackground
        showsHorizontalScrollIndicator = false
        showsVerticalScrollIndicator = false
        scrollsToTop = false
        addSubview(tableHeadView)
        addSubview(spliteView)
        offsetY = offsetY + 90
    }
    private lazy var tableHeadView = SalonHeadView(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: 80.0))

    private lazy var spliteView : UIView = {
        let v = UIView()
        v.backgroundColor = SpliteColor
        v.frame = CGRect(x: 0, y: 80, width: ScreenWidth, height: 10)
        return v
    }()
    private lazy var titleLbl: UILabel = {
        let lbl = UILabel()
        lbl.textColor = UIColor.blackColor()
        lbl.textAlignment = .Left
        lbl.font = UIFont.systemFontOfSize(25)
        lbl.numberOfLines = 0
        return lbl
    }()
    private lazy var timeLbl: UILabel = {
        let lbl = UILabel()
        lbl.textColor = UIColor.grayColor()
        lbl.textAlignment = .Left
        lbl.font = UIFont.systemFontOfSize(14)
        return lbl
    }()

    private lazy var followAndCommentLbl: UILabel = {
        let lbl = UILabel()
        lbl.textColor = UIColor.grayColor()
        lbl.textAlignment = .Left
        lbl.font = UIFont.systemFontOfSize(14)
        return lbl

    }()

    private func createLbl() -> UILabel{
        let lbl = UILabel()
        lbl.textColor = UIColor.grayColor()
        lbl.textAlignment = .Left
        lbl.font = UIFont.systemFontOfSize(16)
        lbl.numberOfLines = 0
        return lbl
    }

    private func createImg(imgTag: String) -> UIImageView{
        let failIv = UIImageView(image: UIImage(named: "CoursePlaceholder_375x240_")!)
        let pattern = "src=\".*?\""
        do{
            let regex = try NSRegularExpression(pattern: pattern, options: NSRegularExpressionOptions.CaseInsensitive)
            let results =  regex.matchesInString(imgTag, options: NSMatchingOptions(rawValue: 0), range: NSMakeRange(0, imgTag.characters.count))
            if results.count > 0{
                let range = results.first!.range
                let str = (imgTag as NSString).substringWithRange(range)
                let url = str.substring(5, str.characters.count - 1)
                let iv = UIImageView()
                iv.sd_setImageWithURL(NSURL(string: url)!, placeholderImage: placeholderImage)

                return iv
            }else{
                return failIv
            }
        }catch{
            CJLog(error)
            return failIv
        }
    }


    func caluHeight(salon: WSalon) -> CGFloat{
        self.salon = salon
        return offsetY
    }
}
