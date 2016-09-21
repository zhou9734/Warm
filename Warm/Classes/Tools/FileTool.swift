//
//  FileTool.swift
//  Warm
//
//  Created by zhoucj on 16/9/19.
//  Copyright © 2016年 zhoucj. All rights reserved.
//管理沙盒文件的工具

import UIKit
import SVProgressHUD
class FileTool: NSObject {
    static let fileManager = NSFileManager.defaultManager()

    /// 计算单个文件的大小
    class func fileSize(path: String) -> Double {

        if fileManager.fileExistsAtPath(path) {
            var dict = try? fileManager.attributesOfItemAtPath(path)
            if let fileSize = dict![NSFileSize] as? Int{
                return Double(fileSize) / 1024.0 / 1024.0
            }
        }

        return 0.0
    }

    /// 计算整个文件夹的大小
    class func folderSize(path: String) -> Double {
        var folderSize: Double = 0
        if fileManager.fileExistsAtPath(path) {
            let childernFiles = fileManager.subpathsAtPath(path)
            for fileName in childernFiles! {
                let tmpPath = path as NSString
                let fileFullPathName = tmpPath.stringByAppendingPathComponent(fileName)
                folderSize += FileTool.fileSize(fileFullPathName)
            }
            return folderSize
        }
        return 0
    }

    /// 彻底清除文件夹,异步
    class func cleanFolderAsync(path: String, complete:() -> ()) {
        SVProgressHUD.setDefaultMaskType(.Black)
        SVProgressHUD.showWithStatus("正在清理中...")
        let queue = dispatch_queue_create("cleanQueue", nil)
        dispatch_async(queue) { () -> Void in
            let chilerFiles = self.fileManager.subpathsAtPath(path)
            for fileName in chilerFiles! {
                let tmpPath = path as NSString
                let fileFullPathName = tmpPath.stringByAppendingPathComponent(fileName)
                if self.fileManager.fileExistsAtPath(fileFullPathName) {
                    do {
                        try self.fileManager.removeItemAtPath(fileFullPathName)
                    } catch _ {
                    }
                }
            }
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                SVProgressHUD.dismiss()
                complete()
            })
        }
    }

    /// 清除文件 同步
    class func cleanFolder(path: String, complete:() -> ()) {
        SVProgressHUD.setDefaultMaskType(.Black)
        SVProgressHUD.showWithStatus("正在清理中...")
        let chilerFiles = self.fileManager.subpathsAtPath(path)
        for fileName in chilerFiles! {
            let tmpPath = path as NSString
            let fileFullPathName = tmpPath.stringByAppendingPathComponent(fileName)
            if self.fileManager.fileExistsAtPath(fileFullPathName) {
                do {
                    try self.fileManager.removeItemAtPath(fileFullPathName)
                } catch _ {

                }
            }
        }
        SVProgressHUD.dismiss()
        complete()
    }


}
