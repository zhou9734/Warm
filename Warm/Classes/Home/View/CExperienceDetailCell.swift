//
//  CExperienceDetailCell.swift
//  Warm
//
//  Created by zhoucj on 16/9/25.
//  Copyright © 2016年 zhoucj. All rights reserved.
//

import UIKit
class CExperienceDetailCell: UITableViewCell {
    var offsetY: CGFloat = 0
    var contentStr: String?{
        didSet{
            guard let content = contentStr else{
                return
            }
            webView.loadHTMLString(content, baseURL: nil)
        }
    }
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(webView)
        webView.snp_makeConstraints { (make) -> Void in
            make.top.bottom.left.right.equalTo(contentView)
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    lazy var webView: UIWebView = {
        let wv = UIWebView()
        wv.scrollView.bounces = false
        wv.scrollView.showsHorizontalScrollIndicator = false
        wv.scrollView.scrollEnabled = false
        wv.sizeToFit()
        return wv
    }()
}