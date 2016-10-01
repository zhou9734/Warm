//
//  RecommendView.swift
//  Warm
//
//  Created by zhoucj on 16/9/13.
//  Copyright © 2016年 zhoucj. All rights reserved.
//

import UIKit

class RecommendView: UIView {
    let marginRight: CGFloat = 10
    private var imageClick:((index: Int) -> ())?
    var recommends: [WRecommend] = [WRecommend](){
        didSet{
            setupUI()
            updateData()
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = Color_GlobalBackground
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI(){
        let width: CGFloat = ScreenWidth - marginRight - 20
        let imageW = width / CGFloat(recommends.count)
        for i in 0..<recommends.count{
            let imageView = UIImageView()
            imageView.userInteractionEnabled = true
            imageView.tag = Int((recommends[i].rdata?.id)!)
            let tap = UITapGestureRecognizer(target: self, action: "imageViewClick:")
            imageView.addGestureRecognizer(tap)
            imageView.frame = CGRect(x: marginRight + CGFloat(i) * imageW + CGFloat(i) * marginRight, y: 0, width: imageW, height: frame.height)
            addSubview(imageView)
        }
    }
    // MARK: - 点击图片调转
    @objc private func imageViewClick(tap: UITapGestureRecognizer) {
        NSNotificationCenter.defaultCenter().postNotificationName(RecommendImageClick, object: nil, userInfo: [ "index" : tap.view!.tag])
    }
    private func updateData(){
        for i in 0..<recommends.count{
            let iv = subviews[i] as! UIImageView
            guard let url = recommends[i].data?.avatar else{
                continue
            }
            iv.sd_setImageWithURL(NSURL(string: url), placeholderImage: placeholderImage)
        }
    }
}
