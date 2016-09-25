//
//  String+Extension.swift
//  ZCJWB
//
//  Created by zhoucj on 16/8/10.
//  Copyright © 2016年 zhoucj. All rights reserved.
//

import UIKit

extension String {
    func cachesDir() -> String{
        let path = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.CachesDirectory, NSSearchPathDomainMask.UserDomainMask, true).last!
        //生成缓存路径
        let name = (self as NSString).lastPathComponent
        let filePath = (path as NSString).stringByAppendingPathComponent(name)
        return filePath
    }

    func docDir() -> String{
        let path = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory , NSSearchPathDomainMask.UserDomainMask, true).last!
        //生成缓存路径
        let name = (self as NSString).lastPathComponent
        let filePath = (path as NSString).stringByAppendingPathComponent(name)
        return filePath

    }

    func tmpDir() -> String{
        let path = NSTemporaryDirectory()
        //生成缓存路径
        let name = (self as NSString).lastPathComponent
        let filePath = (path as NSString).stringByAppendingPathComponent(name)
        return filePath
    }
    //截取字符串
    func substring(s: Int, _ e: Int? = nil) -> String {
        let start = s >= 0 ? self.startIndex : self.endIndex
        let startIndex = start.advancedBy(s)

        var end: String.Index
        var endIndex: String.Index
        if(e == nil){
            end = self.endIndex
            endIndex = self.endIndex
        } else {
            end = e >= 0 ? self.startIndex : self.endIndex
            endIndex = end.advancedBy(e!)
        }

        let range = Range<String.Index>(startIndex..<endIndex)
        return self.substringWithRange(range)
    }
}
