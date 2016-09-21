//
//  ForgetPwdViewController.swift
//  Warm
//
//  Created by zhoucj on 16/9/16.
//  Copyright © 2016年 zhoucj. All rights reserved.
//

import UIKit

class ForgetPwdViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        usernameTxtField.becomeFirstResponder()
    }
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        usernameTxtField.resignFirstResponder()
        pwdTxtField.resignFirstResponder()
    }
    private func setupUI(){
        title = "找回密码"
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backBtn)
        view.backgroundColor = UIColor.whiteColor()
        view.addSubview(usernameTxtField)
        view.addSubview(separatLineU)
        view.addSubview(pwdTxtField)
        view.addSubview(separatLineP)
        view.addSubview(visiableBtn)
        view.addSubview(loginBtn)
    }
    private lazy var backBtn: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "navigationBack_13x22_"), forState: .Normal)
        btn.contentHorizontalAlignment = .Left
        btn.addTarget(self, action: Selector("backBtnClick"), forControlEvents: .TouchUpInside)
        btn.sizeToFit()
        return btn
    }()
    let marginLeft: CGFloat = ScreenWidth * 0.15
    let _width: CGFloat = ScreenWidth - ScreenWidth * 0.3
    private lazy var usernameTxtField: UITextField = {
        let txt = UITextField()
        txt.placeholder = "请输入手机号"
        txt.borderStyle = .None
        txt.textColor = UIColor.blackColor()
        txt.clearButtonMode = .WhileEditing
        txt.frame = CGRect(x: self.marginLeft, y: 100, width: self._width, height: 44)
        txt.keyboardType = .NumbersAndPunctuation
        txt.addTarget(self, action: Selector("hasText"), forControlEvents: .EditingChanged)
        return txt
    }()

    private lazy var separatLineU: UIView = {
        let v = UIView()
        v.backgroundColor = UIColor.grayColor()
        v.frame = CGRect(x: self.marginLeft, y: 154, width: self._width, height: 1)
        return v
    }()

    private lazy var pwdTxtField: UITextField = {
        let txt = UITextField()
        txt.borderStyle = .None
        txt.textColor = UIColor.blackColor()
        txt.placeholder = "请输入验证码"
        txt.keyboardType = .NumbersAndPunctuation
        txt.frame = CGRect(x: self.marginLeft, y: 165, width: ScreenWidth - (ScreenWidth * 0.4), height: 44)
        txt.addTarget(self, action: Selector("hasText"), forControlEvents: .EditingChanged)
        return txt
    }()
    private lazy var separatLineP: UIView = {
        let v = UIView()
        v.backgroundColor = UIColor.grayColor()
        v.frame = CGRect(x: self.marginLeft, y: 210, width: self._width, height: 1)
        return v
    }()
    private lazy var visiableBtn: UIButton = {
        let btn = UIButton()
        btn.frame = CGRect(x: ScreenWidth - self.marginLeft - 80 , y: 175, width: 80, height: 20)
        btn.setTitle("免费获取", forState: .Normal)
        btn.setTitleColor(UIColor.grayColor(), forState: .Normal)
        btn.titleLabel?.font = UIFont.systemFontOfSize(14)
        btn.layer.borderWidth = 1
        btn.layer.cornerRadius = 10
        btn.layer.borderColor = UIColor.grayColor().CGColor
        return btn
    }()

    private lazy var loginBtn: UIButton = {
        let btn = UIButton()
        btn.setTitle("提交", forState: .Normal)
        btn.setBackgroundImage(UIImage.imageWithColor(UIColor.grayColor()), forState: .Disabled)
        btn.setBackgroundImage(UIImage.imageWithColor(WarmBlueColor), forState: .Normal)
        btn.layer.cornerRadius = 20
        btn.layer.masksToBounds = true
        btn.frame = CGRect(x: self.marginLeft, y: 255, width: self._width, height: 40)
        btn.enabled = false
        return btn
    }()
    @objc private func hasText(){
        if usernameTxtField.hasText() && pwdTxtField.hasText() {
            loginBtn.enabled = true
        }else{
            loginBtn.enabled = false
        }
    }
    @objc private func backBtnClick(){
        navigationController?.popViewControllerAnimated(true)
    }


}
