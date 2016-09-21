//
//  LoginInViewController.swift
//  Warm
//
//  Created by zhoucj on 16/9/16.
//  Copyright © 2016年 zhoucj. All rights reserved.
//

import UIKit
import SVProgressHUD

class LoginInViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        //隐藏navigationBar
        navigationController?.navigationBarHidden = false
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
        title = "登录"
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backBtn)
        view.backgroundColor = UIColor.whiteColor()
        view.addSubview(usernameTxtField)
        view.addSubview(separatLineU)
        view.addSubview(pwdTxtField)
        view.addSubview(separatLineP)
        view.addSubview(visiableBtn)
        view.addSubview(forgetPwdBtn)
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
        txt.placeholder = "请输入密码"
        txt.secureTextEntry = true
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
        btn.setBackgroundImage(UIImage(named: "plaintext_23x17_"), forState: .Normal)
        btn.setBackgroundImage(UIImage(named: "ciphertext_23x19_"), forState: .Selected)
        btn.addTarget(self, action: Selector("visiableBtnClick:"), forControlEvents: .TouchUpInside)
        btn.frame = CGRect(x: ScreenWidth - self.marginLeft - 23 , y: 175, width: 23, height: 17)
        return btn
    }()

    private lazy var forgetPwdBtn: UIButton = {
        let btn = UIButton()
        btn.setTitleColor(WarmBlueColor, forState: .Normal)
        btn.setTitle("忘记密码?", forState: .Normal)
        btn.titleLabel?.font = UIFont.systemFontOfSize(15)
        btn.titleLabel?.textAlignment = .Right
        btn.frame = CGRect(x: ScreenWidth - 80 - self.marginLeft , y: 230, width: 80, height: 25)
        btn.addTarget(self, action: Selector("forgetPwdBtnClick"), forControlEvents: .TouchUpInside)
        return btn
    }()

    private lazy var loginBtn: UIButton = {
        let btn = UIButton()
        btn.setTitle("登录", forState: .Normal)
        btn.setBackgroundImage(UIImage.imageWithColor(UIColor.grayColor()), forState: .Disabled)
        btn.setBackgroundImage(UIImage.imageWithColor(WarmBlueColor), forState: .Normal)
        btn.layer.cornerRadius = 20
        btn.layer.masksToBounds = true
        btn.frame = CGRect(x: self.marginLeft, y: 275, width: self._width, height: 40)
        btn.enabled = false
        btn.addTarget(self, action: Selector("loginBtnClick"), forControlEvents: .TouchUpInside)
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
    @objc private func visiableBtnClick(btn: UIButton){
        btn.selected = !btn.selected
        pwdTxtField.secureTextEntry = !pwdTxtField.secureTextEntry
    }
    @objc private func forgetPwdBtnClick(){
        navigationController?.pushViewController(ForgetPwdViewController(), animated: true)
    }
    @objc private func loginBtnClick(){
        SVProgressHUD.show()
        unowned let tmpSelf = self
        if usernameTxtField.text == "123" && pwdTxtField.text == "123"{
            let path = "v5/users/thirdLogin"
            let params: [String: AnyObject] = ["type": 0,"client": "mobile","accesstoken": "TKakkGhvRNBmBIHBjh2jO4Y41a5vJ8qdRZwt9oK5YdZO9MLmUS5JwHIQrRgYeT3RskfyQaq4aWZUfsuAe_OC305hssmRbq9Y02zY-S7Nn7A","openid": "oT8EJt7bH2aGtBlV7tQfkyPBb3WE"]
            NetworkTools.sharedInstance.POST(path, parameters: params, success: { (task, objc) -> Void in
                    //返回数据给调用者
                    guard let _array = objc["result"] else{
                        alert("登录失败!")
                        return
                    }
                    var token: Token?
                    if let _user = _array!["user"] as? [String: AnyObject]{
                        token = Token(dict: _user)
                    }else{
                        token = tmpSelf.loadToken()
                    }
                    token!.saveAccount()
                    SVProgressHUD.dismiss()
                    tmpSelf.navigationController?.popViewControllerAnimated(true)
                    tmpSelf.navigationController?.presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
                    NSNotificationCenter.defaultCenter().postNotificationName(LoginSuccessNotication, object: nil)
                }, failure: { (task, error) -> Void in
                    alert("登录失败!")
            })

        }else{
            alert("账号或密码错误!")
        }
    }

    private func loadToken() -> Token?{
        do{
            var token: Token?
            let pathStr = NSBundle.mainBundle().pathForResource("Token", ofType: "json")
            let data = NSData(contentsOfFile: pathStr!)
            let dict = try NSJSONSerialization.JSONObjectWithData(data!, options: .AllowFragments) as! NSDictionary
            token = Token(dict: dict["user"] as! [String : AnyObject])
            return token!
        }catch let error as NSError{
            CJLog(error)
            return nil
        }
    }
    deinit{
        CJLog("LoginInViewController")
    }
}
