//
//  SubjectHeadView.swift
//  Warm
//
//  Created by zhoucj on 16/9/23.
//  Copyright © 2016年 zhoucj. All rights reserved.
//

import UIKit

class SubjectHeadView: UIView {
    var urlString: String?{
        didSet{
            guard let url = urlString else{
                return
            }
            contentWebView.loadRequest(NSURLRequest(URL: NSURL(string: url)!))
            layoutIfNeeded()
        }
    }
    var titleStrng: String?{
        didSet{
            titleLbl.text = titleStrng
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func setupUI(){
        addSubview(titleLbl)
        addSubview(spliteView)
        addSubview(contentWebView)

        titleLbl.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(self.snp_top).offset(15)
            make.left.equalTo(self.snp_left).offset(10)
            make.right.equalTo(self.snp_right).offset(-10)
        }
        spliteView.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(titleLbl.snp_top).offset(10)
            make.left.equalTo(self.snp_left).offset(10)
            make.height.equalTo(1)
            make.width.equalTo(70)
        }
        contentWebView.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(spliteView.snp_top).offset(40)
            make.left.equalTo(self.snp_left)
            make.right.equalTo(self.snp_right)
            make.bottom.equalTo(self.snp_bottom)
        }

    }
    private lazy var titleLbl: UILabel = {
        let lbl = UILabel()
        lbl.textColor = UIColor.blackColor()
        lbl.numberOfLines = 0
        lbl.font = UIFont.boldSystemFontOfSize(20)
        return lbl
    }()
    private lazy var spliteView: UIView = {
        let v = UIView()
        v.backgroundColor = SpliteColor
        return v
    }()

    private lazy var contentWebView: UIWebView = {
        let wv = UIWebView()
        wv.scrollView.bounces = false
        wv.scrollView.scrollEnabled = false
        return wv
    }()
    deinit{
        contentWebView.delegate = nil
        contentWebView.stopLoading()
    }
}
