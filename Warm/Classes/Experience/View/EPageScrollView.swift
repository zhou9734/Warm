//
//  EPageScrollView.swift
//  Warm
//
//  Created by zhoucj on 16/9/14.
//  Copyright © 2016年 zhoucj. All rights reserved.
//

import UIKit
import SDWebImage

class EPageScrollView: UIView {
    let pageWidth: CGFloat = UIScreen.mainScreen().bounds.width
//    let pageHeight: CGFloat = self.frame.size.height
    let imageView0: UIImageView = UIImageView()
    let imageView1: UIImageView = UIImageView()
    let imageView2: UIImageView = UIImageView()
    /// 图片数组
    private var currentPage = 0{
        didSet{
            if tags.count > 0{
                unowned let tmpSelf = self
                imageView.sd_setImageWithURL(NSURL(string: tags[currentPage].avatar!), placeholderImage: placeholderImage, completed: { (image, error, _, _) -> Void in
                    tmpSelf.imageView.image = image.applyLightEffect()
                })
            }
        }
    }
    var tags: [WTags] = [WTags](){
        didSet{
            updateImageData()
            currentPage = 0
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
        addSubview(imageView)
        addSubview(scrollView)

    }
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.frame = self.bounds
        //为了让内容横向滚动，设置横向内容宽度为3个页面的宽度总和
        let pageHeight: CGFloat = self.frame.size.height
        scrollView.contentSize=CGSizeMake(CGFloat(self.pageWidth*3),
            CGFloat(pageHeight))
        scrollView.pagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.scrollsToTop = false
        scrollView.delegate = self

        let imageW = self.pageWidth - (self.pageWidth*0.5)
        let imageH = pageHeight - (pageHeight*0.3)
        let offsetY = pageHeight*0.15

        self.imageView0.frame = CGRect(x: (self.pageWidth - imageW)/2, y: offsetY, width: imageW, height: imageH)
        self.imageView1.frame = CGRect(x: self.pageWidth + (self.pageWidth - imageW)/2, y: offsetY, width: imageW, height: imageH)
        self.imageView2.frame = CGRect(x: self.pageWidth * 2 + (self.pageWidth - imageW)/2, y: offsetY, width: imageW, height: imageH)

        scrollView.addSubview(self.imageView0)
        scrollView.addSubview(self.imageView1)
        scrollView.addSubview(self.imageView2)

        let tap = UITapGestureRecognizer(target: self, action: "imageViewClick:")
        scrollView.addGestureRecognizer(tap)
        return scrollView
    }()
    private lazy var imageView: UIImageView = {
        let iv = UIImageView()
        iv.frame = CGRect(x: 0.0, y: 0.0, width: self.pageWidth, height: self.frame.size.height)
        return iv
    }()
    // MARK: - 点击图片调转
    @objc private func imageViewClick(tap: UITapGestureRecognizer) {
        NSNotificationCenter.defaultCenter().postNotificationName(TagsImageClick, object: self, userInfo: [ "index" : currentPage])
    }
}
extension EPageScrollView: UIScrollViewDelegate{
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        let ratio = scrollView.contentOffset.x/scrollView.frame.size.width
        self.endScrollMethod(ratio)
    }
    func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if !decelerate{
            let ratio = scrollView.contentOffset.x/scrollView.frame.size.width
            endScrollMethod(ratio)
        }
    }
    private func endScrollMethod(ratio:CGFloat){
        if ratio <= 0.7{
            if currentPage - 1 < 0{
                currentPage = tags.count - 1
            }else{
                currentPage -= 1
            }
        }
        if ratio >= 1.3{
            if currentPage == tags.count - 1{
                currentPage = 0
            }else{
                currentPage += 1
            }
        }
        updateImageData()
    }
    //MARK: - reload data
    private func updateImageData(){
        if currentPage == 0{
            imageView0.sd_setImageWithURL(NSURL(string: tags.last!.avatar!), placeholderImage: placeholderImage)
            imageView1.sd_setImageWithURL(NSURL(string: tags[currentPage].avatar!), placeholderImage: placeholderImage)
            imageView2.sd_setImageWithURL(NSURL(string: tags[currentPage + 1].avatar!), placeholderImage: placeholderImage)
        }else if currentPage == tags.count - 1{
            imageView0.sd_setImageWithURL(NSURL(string: tags[currentPage - 1 ].avatar!), placeholderImage: placeholderImage)
            imageView1.sd_setImageWithURL(NSURL(string: tags[currentPage].avatar!), placeholderImage: placeholderImage)
            imageView2.sd_setImageWithURL(NSURL(string: tags.first!.avatar!), placeholderImage: placeholderImage)
        }else{
            imageView0.sd_setImageWithURL(NSURL(string: tags[currentPage - 1 ].avatar!), placeholderImage: placeholderImage)
            imageView1.sd_setImageWithURL(NSURL(string: tags[currentPage].avatar!), placeholderImage: placeholderImage)
            imageView2.sd_setImageWithURL(NSURL(string: tags[currentPage + 1].avatar!), placeholderImage: placeholderImage)
        }
        scrollView.contentOffset = CGPoint(x: scrollView.frame.size.width, y: 0)
    }
}
