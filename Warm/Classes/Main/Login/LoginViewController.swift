//
//  LoginViewController.swift
//  Warm
//
//  Created by zhoucj on 16/9/15.
//  Copyright © 2016年 zhoucj. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        //隐藏navigationBar
        navigationController?.navigationBarHidden = true
        let appearance = UINavigationBar.appearance()
        var textAttrs: [String : AnyObject] = Dictionary()
        textAttrs[NSFontAttributeName] = UIFont.systemFontOfSize(17)
        appearance.titleTextAttributes = textAttrs
    }

    private func setupUI(){
        view.addSubview(bgImageView)
        view.addSubview(closeBtn)
        view.addSubview(loginBtn)
        view.addSubview(registerBtn)
        view.addSubview(descLbl)
        view.addSubview(wechatBtn)
        view.addSubview(qqBtn)
        view.addSubview(sinaBtn)
    }

    //背景
    private lazy var bgImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "PicSignIn&Up_375x667_")
        iv.frame = ScreenBounds
        return iv
    }()

    private lazy var closeBtn: UIButton = {
        let btn = UIButton()
        btn.setBackgroundImage(UIImage(named: "signInUpJump_63x23_"), forState: .Normal)
        btn.setBackgroundImage(UIImage(named: "SignInUpJumpOn_63x23_"), forState: .Highlighted)
        btn.frame = CGRect(x: (ScreenWidth - 93), y: 35, width: 63, height: 23)
        btn.addTarget(self, action: Selector("closeBtnClick"), forControlEvents: .TouchUpInside)
        return btn
    }()
    let loginBtnW: CGFloat = (ScreenWidth - 50)/2
    private lazy var loginBtn: UIButton = {
        let btn = UIButton()
        btn.setBackgroundImage(UIImage.imageWithColor(WarmBlueColor), forState: .Normal)
        btn.setTitle("登录", forState: .Normal)
        btn.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        btn.layer.cornerRadius = 5
        btn.layer.masksToBounds = true
        btn.frame = CGRect(x: 15, y: ScreenHeight - 175, width: self.loginBtnW, height: 40)
        btn.addTarget(self, action: Selector("doLogin"), forControlEvents: .TouchUpInside)
        return btn
    }()

    private lazy var registerBtn: UIButton = {
        let btn = UIButton()
        btn.setTitle("注册", forState: .Normal)
        btn.setTitleColor(WarmBlueColor, forState: .Normal)
        btn.layer.cornerRadius = 5
        btn.layer.borderWidth = 1
        btn.layer.borderColor = WarmBlueColor.CGColor
        btn.frame = CGRect(x: 30 + self.loginBtnW, y: ScreenHeight - 175, width: self.loginBtnW, height: 40)
        return btn
    }()

    private lazy var descLbl: UILabel = {
        let lbl = UILabel()
        lbl.text = "使用第三方登录"
        lbl.textColor = UIColor.grayColor()
        lbl.textAlignment = .Center
        lbl.font = UIFont.systemFontOfSize(13)
        lbl.frame = CGRect(x: (ScreenWidth - 200)/2, y: ScreenHeight - 123, width: 200, height: 20)

        return lbl
    }()
    let shareBtnWidth: CGFloat = (ScreenWidth - 30)/9
    private lazy var wechatBtn: UIButton = {
        let btn = UIButton(target: self, backgroundImage: "signInUpWechat_30x30_", action: Selector("wechatBtnClick"))
        btn.layer.cornerRadius = self.shareBtnWidth / 2
        btn.layer.masksToBounds = true
        btn.frame = CGRect(x: ScreenWidth/2 - self.shareBtnWidth - 60, y: ScreenHeight - 75, width: self.shareBtnWidth, height: self.shareBtnWidth)
        return btn
    }()
    private lazy var qqBtn: UIButton = {
        let btn = UIButton(target: self, backgroundImage: "signInUpQQ_30x30_", action: Selector("qqBtnClick"))
        btn.layer.cornerRadius = self.shareBtnWidth / 2
        btn.layer.masksToBounds = true
        btn.frame = CGRect(x: (ScreenWidth - self.shareBtnWidth)/2, y: ScreenHeight - 75, width: self.shareBtnWidth, height: self.shareBtnWidth)
        return btn
    }()
    private lazy var sinaBtn: UIButton = {
        let btn = UIButton(target: self, backgroundImage: "signInUpWeibo_30x30_", action: Selector("sinaBtnClick"))
        btn.layer.cornerRadius = self.shareBtnWidth / 2
        btn.layer.masksToBounds = true
        btn.frame = CGRect(x: (ScreenWidth + self.shareBtnWidth)/2 + 40, y: ScreenHeight - 75, width: self.shareBtnWidth, height: self.shareBtnWidth)
        return btn
    }()
    @objc private func closeBtnClick(){
        dismissViewControllerAnimated(true, completion: nil)
    }

    @objc private func doLogin(){
        navigationController?.pushViewController(LoginInViewController(), animated: true)
    }
    @objc private func wechatBtnClick(){
        CJLog("wechatBtnClick")
    }
    @objc private func qqBtnClick(){
        CJLog("qqBtnClick")
    }
    @objc private func sinaBtnClick(){
        CJLog("sinaBtnClick")
    }
    deinit{
        CJLog("LoginViewController")
    }
}
