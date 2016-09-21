//
//  Token.swift
//  Warm
//
//  Created by zhoucj on 16/9/16.
//  Copyright © 2016年 zhoucj. All rights reserved.
//

import UIKit

class Token: NSObject {
    var id: Int64 = -1
    var type: Int64 = -1
    var mobile: String?
    var nickname: String?
    var signature: String?
    var avatar: String?
    var background: String?
    var token: String?
    var chat_token: String?

    init(dict: [String: AnyObject]) {
        super.init()
        setValuesForKeysWithDictionary(dict)
    }

    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
    }

    //MARK: - 外部控制方法
    //归档
    func saveAccount() -> Bool{
        //归档对象
        return NSKeyedArchiver.archiveRootObject(self, toFile: Token.filePath)
    }
    /// 定义属性保存授权模型
    static var account: Token?
    //解归档
    class func loadAccount() -> Token? {
        if Token.account != nil{
            return Token.account
        }
        CJLog(Token.filePath)
        guard let _account = NSKeyedUnarchiver.unarchiveObjectWithFile(Token.filePath) as? Token else{
            return nil
        }
        Token.account = _account
        return Token.account
    }

    class func isLogin() -> Bool {
        return Token.loadAccount() != nil
    }

    static let filePath = "useraccount.plist".cachesDir()
    //MARK: - NSCoding
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeInt64(id, forKey: "id")
        aCoder.encodeInt64(type, forKey: "type")
        aCoder.encodeObject(mobile, forKey: "mobile")
        aCoder.encodeObject(nickname, forKey: "nickname")
        aCoder.encodeObject(signature, forKey: "signature")
        aCoder.encodeObject(avatar, forKey: "avatar")
        aCoder.encodeObject(background, forKey: "background")
        aCoder.encodeObject(token, forKey: "token")
        aCoder.encodeObject(chat_token, forKey: "chat_token")
    }

    required init?(coder aDecoder: NSCoder){
        id = aDecoder.decodeInt64ForKey("id") as Int64
        type = aDecoder.decodeInt64ForKey("type") as Int64
        mobile = aDecoder.decodeObjectForKey("mobile") as? String
        nickname = aDecoder.decodeObjectForKey("nickname") as? String
        signature = aDecoder.decodeObjectForKey("signature") as? String
        avatar = aDecoder.decodeObjectForKey("avatar") as? String
        background = aDecoder.decodeObjectForKey("background") as? String
        token = aDecoder.decodeObjectForKey("token") as? String
        chat_token = aDecoder.decodeObjectForKey("chat_token") as? String
    }
}