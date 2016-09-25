//
//  Common.swift
//  Warm
//
//  Created by zhoucj on 16/9/12.
//  Copyright © 2016年 zhoucj. All rights reserved.
//
import UIKit

/// 友盟分享的APP key
let UMSharedAPPKey = "57e7e25767e58e33190022db"
//新浪App Key
let SinaAppKey = "1168605738"
let SinaAppSecret = "968fb67661aa1e811e171a6937a699c0"
//重定向url
let RedirectURL = "https://www.baidu.com/"
// 全局背景
let Color_GlobalBackground = UIColor.whiteColor()
let placeholderImage: UIImage = UIImage(named: "CoursePlaceholder_375x240_")!
let WarmBlueColor = UIColor(red: 87.0/255.0, green: 192.0/255.0, blue: 255.0/255.0, alpha: 1)
let SpliteColor = UIColor(red: 250.0/255.0, green: 250.0/255.0, blue: 250.0/255.0, alpha: 1)
let ScreenWidth = UIScreen.mainScreen().bounds.width
let ScreenHeight = UIScreen.mainScreen().bounds.height
let ScreenBounds = UIScreen.mainScreen().bounds
let cityCodeKey = "cityCodeKey"
//每页加载数量
let pageSize = 10
//登录通知
let LoginNotication = "LoginNotication"
//切换视图
let SwitchRootViewController = "SwitchRootViewController"
//日志输出
func CJLog<T>(message: T, fileName: String = __FILE__, methodName: String = __FUNCTION__, lineNumber: Int = __LINE__){

    //只有在DEBUG模式下才会打印. 需要在Build Settig中设置
    #if DEBUG
        var _fileName = (fileName as NSString).pathComponents.last!
        _fileName = _fileName.substringToIndex((_fileName.rangeOfString(".swift")?.startIndex)!)
        print("\(_fileName).\(methodName).[\(lineNumber)]: \(message)")
    #endif
}
//提示框
func alert(msg: String){
    let alertView = UIAlertView(title: nil, message: msg, delegate: nil, cancelButtonTitle: "确定")
    alertView.show()
}

