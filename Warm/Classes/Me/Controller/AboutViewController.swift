//
//  AboutViewController.swift
//  Warm
//
//  Created by zhoucj on 16/9/19.
//  Copyright © 2016年 zhoucj. All rights reserved.
//

import UIKit

class AboutViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    private func setupUI(){
        view.addSubview(bgImageView)
        view.addSubview(closeBtn)
        view.addSubview(iconImageView)
        view.addSubview(warmLbl)
        view.addSubview(warmEnglishLbl)
        view.addSubview(versionLbl)
        view.addSubview(titleLbl)
        view.addSubview(subTitleLbl)
        view.addSubview(descLbl)
        view.addSubview(contactLbl)
        view.addSubview(wechatLbl)
    }
    //背景
    private lazy var bgImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "PicSignIn&Up_375x667_")!.applyLightEffect()
        iv.frame = ScreenBounds
        return iv
    }()
    //关闭按钮
    private lazy var closeBtn: UIButton = {
        let btn = UIButton()
        btn.setBackgroundImage(UIImage(named: "aboutwarmupCancle_20x21_"), forState: .Normal)
        btn.frame = CGRect(x: 25, y: 35, width: 20, height: 21)
        btn.addTarget(self, action: Selector("closeBtnClick"), forControlEvents: .TouchUpInside)
        return btn
    }()
    //图标logo
    private lazy var iconImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "about_logo_94x94_")
        iv.frame = CGRect(x: ScreenWidth * 0.3, y: ScreenWidth * 0.4, width: 45, height: 45)
        iv.layer.cornerRadius = 6
        iv.layer.masksToBounds = true
        return iv
    }()
    private lazy var warmLbl: UILabel = {
        let lbl = UILabel()
        lbl.text = "取暖"
        lbl.textColor = WarmBlueColor
        lbl.textAlignment = .Center
        lbl.font = UIFont.boldSystemFontOfSize(24)
        lbl.frame = CGRect(x: ScreenWidth * 0.3 + 50, y: ScreenWidth * 0.4, width: 85, height: 30)
        return lbl
    }()
    private lazy var warmEnglishLbl: UILabel = {
        let lbl = UILabel()
        lbl.text = "WarmUP"
        lbl.textColor = SpliteColor
        lbl.textAlignment = .Center
        lbl.frame = CGRect(x: ScreenWidth * 0.3 + 50, y: ScreenWidth * 0.4 + 30, width: 85, height: 15)
        return lbl
    }()
    private lazy var versionLbl: UILabel = {
        let currentVersion = NSBundle.mainBundle().infoDictionary!["CFBundleShortVersionString"] as! String
        let lbl = UILabel()
        lbl.text = "v" + currentVersion ?? "1.0.0"
        lbl.textColor = UIColor.grayColor()
        lbl.textAlignment = .Center
        lbl.frame = CGRect(x: (ScreenWidth - 60)/2, y: ScreenWidth * 0.4 + 50, width: 60, height: 20)
        return lbl
    }()
    private lazy var titleLbl: UILabel = {
        let lbl = UILabel()
        lbl.text = "八小时外的生活入口"
        lbl.textColor = UIColor.grayColor()
        lbl.textAlignment = .Center
        lbl.font = UIFont.systemFontOfSize(15)
        lbl.frame = CGRect(x: 50, y: ScreenWidth * 0.4 + 75, width: (ScreenWidth - 100), height: 20)
        return lbl
    }()

    private lazy var subTitleLbl: UILabel = {
        let lbl = UILabel()
        lbl.text = "有腔调的生活家们每天发起话题和活动"
        lbl.textColor = UIColor.grayColor()
        lbl.textAlignment = .Center
        lbl.font = UIFont.systemFontOfSize(15)
        lbl.frame = CGRect(x: 30, y: ScreenWidth * 0.4 + 105, width: (ScreenWidth - 60), height: 20)
        return lbl
    }()

    private lazy var descLbl: UILabel = {
        let str = "旗下有\"取暖\"App不间断提供生活美学体验,生活家们也在\"取暖生活美学\"微信公众号,取暖电台以及我们的线下空间和你分享新知,态度和好货."
        let lbl = UILabel()
        lbl.frame = CGRect(origin: CGPoint(x: 20, y: ScreenWidth * 0.4 + 160), size: CGSize(width: ScreenWidth - 40, height: 160))
        lbl.textColor = UIColor.grayColor()
        lbl.numberOfLines = 0
        lbl.font = UIFont.systemFontOfSize(16)
        lbl.textAlignment = .Left
        var attributeStr = NSMutableAttributedString(string: str)
        var paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 8.0
        paragraphStyle.headIndent = 30
        attributeStr.addAttribute(NSParagraphStyleAttributeName, value: paragraphStyle, range: NSMakeRange(0, str.characters.count))
        lbl.attributedText = attributeStr
        lbl.sizeToFit()
        return lbl
    }()

    private lazy var contactLbl: UILabel = {
        let lbl = UILabel()
        lbl.text = "微信公众号: "
        lbl.textColor = UIColor.grayColor()
        lbl.numberOfLines = 0
        lbl.textAlignment = .Right
        lbl.frame = CGRect(x: (ScreenWidth - 260)/2, y: ScreenHeight - 120, width: 120, height: 20)
        return lbl
    }()

    private lazy var wechatLbl: UILabel = {
        let lbl = UILabel()
        lbl.text = "zhouzhoucj "
        lbl.textColor = WarmBlueColor
        lbl.numberOfLines = 0
        lbl.textAlignment = .Left
        lbl.frame = CGRect(x: (ScreenWidth - 250)/2 + 120, y: ScreenHeight - 120, width: 100, height: 20)
        return lbl
    }()
    @objc private func closeBtnClick(){
        dismissViewControllerAnimated(true, completion: nil)
    }
}
