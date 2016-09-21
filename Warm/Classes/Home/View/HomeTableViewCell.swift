//
//  HomeTableViewCell.swift
//  Warm
//
//  Created by zhoucj on 16/9/13.
//  Copyright © 2016年 zhoucj. All rights reserved.
//

import UIKit
import SDWebImage

class HomeTableViewCell: UITableViewCell {
    //placeholderImage
    var salon: WSalon?{
        didSet{
            guard let _salon = salon else{
                return
            }
            bgImageView.sd_setImageWithURL(NSURL(string: _salon.avatar!), placeholderImage: placeholderImage)
            titleLbl.text = _salon.title
            iconImageView.sd_setImageWithURL(NSURL(string: _salon.user!.avatar!))
            nicknameLbl.text = _salon.user!.nickname
            likeCountLbl.text = "\(_salon.follow_count)"
            commentCountLbl.text = "\(_salon.comment_count)"
        }
    }
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI(){
        contentView.addSubview(bgImageView)
        contentView.addSubview(titleLbl)
        contentView.addSubview(iconImageView)
        contentView.addSubview(nicknameLbl)
        contentView.addSubview(likeCountLbl)
        contentView.addSubview(likeImageView)
        contentView.addSubview(commentCountLbl)
        contentView.addSubview(commentImageView)
        contentView.addSubview(splieLine)
    }
    //背景图片
    private lazy var bgImageView: UIImageView = {
        let iv = UIImageView()
        iv.frame = CGRect(x: 0, y: 0, width: ScreenWidth, height: 170)
        return iv
    }()
    //标题
    private lazy var titleLbl: UILabel = {
        let width = ScreenWidth - 40
        let lbl = UILabel(frame: CGRect(x: 20, y: 55, width: width, height: 50))
        lbl.numberOfLines = 0
        lbl.textColor = UIColor.whiteColor()
        lbl.textAlignment = .Center
        return lbl
    }()
    //头像
    private lazy var iconImageView: UIImageView = {
        let iv = UIImageView()
        iv.frame = CGRect(x: 15, y: 175, width: 50 , height: 50)
        iv.layer.cornerRadius = 25
        iv.layer.masksToBounds = true
        return iv
    }()
    private lazy var nicknameLbl: UILabel = {
        let lbl = UILabel(frame: CGRect(x: 75, y: 185, width: 120, height: 35))
        lbl.textColor = UIColor.blackColor()
        lbl.font = UIFont.systemFontOfSize(14)
        lbl.textAlignment = .Left
        return lbl

    }()
    //喜欢的数量
    private lazy var likeCountLbl: UILabel = {
        let lbl = UILabel(frame: CGRect(x: ScreenWidth - 130, y: 185, width: 30, height: 30))
        lbl.textColor = UIColor.grayColor()
        lbl.textAlignment = .Right
        lbl.font = UIFont.systemFontOfSize(15)
        return lbl
    }()
    //心
    private lazy var likeImageView: UIImageView = {
        let iv = UIImageView()
        iv.frame = CGRect(x: ScreenWidth - 90, y: 185, width: 25 , height: 25)
        iv.image = UIImage(named: "myshalonLoved_13x11_")
        return iv
    }()
    //评论数量
    private lazy var commentCountLbl: UILabel = {
        let lbl = UILabel(frame: CGRect(x: ScreenWidth - 75, y: 185, width: 30, height: 30))
        lbl.textColor = UIColor.grayColor()
        lbl.textAlignment = .Right
        lbl.font = UIFont.systemFontOfSize(15)
        return lbl
    }()
    //评论图片
    private lazy var commentImageView: UIImageView = {
        let iv = UIImageView()
        iv.frame = CGRect(x: ScreenWidth - 40, y: 185, width: 25 , height: 25)
        iv.image = UIImage(named: "myshalonComment_13x12_")
        return iv
    }()
    //分割线
    private lazy var splieLine: UIView = {
        let _view = UIView(frame: CGRect(x: 15, y: 230, width: ScreenWidth - 30, height: 1))
        _view.backgroundColor = SpliteColor
        return _view
    }()

}
