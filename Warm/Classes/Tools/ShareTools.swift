//
//  ShareTools.swift
//  Warm
//
//  Created by zhoucj on 16/9/26.
//  Copyright © 2016年 zhoucj. All rights reserved.
//

import UIKit

class ShareTools: NSObject {
    class func shareApp(viewController: UIViewController, shareText: String?){
        let snsNames = [UMShareToDouban, UMShareToRenren,UMShareToWechatSession, UMShareToWechatTimeline, UMShareToSina]
        UMSocialSnsService.presentSnsIconSheetView(viewController, appKey: UMSharedAPPKey, shareText: shareText ?? "友盟分享测试", shareImage: UIImage(named: "about_logo_94x94_"), shareToSnsNames: snsNames, delegate: nil)
    }
}
