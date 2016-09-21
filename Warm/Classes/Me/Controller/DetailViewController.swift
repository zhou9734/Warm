//
//  DetailViewController.swift
//  Warm
//
//  Created by zhoucj on 16/9/19.
//  Copyright © 2016年 zhoucj. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    var titleName: String?{
        didSet{
            title = titleName
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Color_GlobalBackground
        view.addSubview(imageView)
        view.addSubview(msgLbl)
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBarHidden = false
        var textAttrs: [String : AnyObject] = Dictionary()
        textAttrs[NSForegroundColorAttributeName] = UIColor.blackColor()
        textAttrs[NSFontAttributeName] = UIFont.systemFontOfSize(17)
        navigationController?.navigationBar.titleTextAttributes = textAttrs
    }
    private lazy var imageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "nocontent_133x76_")
        iv.frame = CGRect(x: (ScreenWidth - 133.0)/2, y: (ScreenHeight - 76.0)/2, width: 133.0, height: 76.0)
        return iv
    }()
    private lazy var msgLbl: UILabel = {
        let lbl = UILabel()
        lbl.text = "没有数据"
        lbl.textAlignment = .Center
        lbl.textColor = UIColor.grayColor()
        lbl.font = UIFont.systemFontOfSize(15)
        lbl.frame = CGRect(x: (ScreenWidth - 100.0)/2, y: (ScreenHeight - 76.0)/2 + 86, width: 100.0, height: 20.0)
        return lbl
    }()
}
