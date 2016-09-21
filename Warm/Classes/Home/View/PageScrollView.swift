//
//  PageScrollView.swift
//  Warm
//
//  Created by zhoucj on 16/9/13.
//  Copyright © 2016年 zhoucj. All rights reserved.
//

import UIKit
import SDWebImage
class PageScrollView: UIView {
    private var timer:NSTimer?
    let pageWidth = Int(UIScreen.mainScreen().bounds.width)
    let pageHeight = 160
    private var currentPage = 0
    let imageView0:UIImageView = UIImageView()
    let imageView1:UIImageView = UIImageView()
    let imageView2:UIImageView = UIImageView()
    /// 图片数组
    var rounds: [WRound] = [WRound](){
        willSet{
            currentPage = 0
            pageControl.numberOfPages = newValue.count
            stopTimer()
        }
        didSet{
            startTimer()
            updateImageData()
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
        addSubview(scrollView)
        addSubview(pageControl)
    }

    private lazy var scrollView: UIScrollView = {
        //scrollView的初始化
        let scrollView = UIScrollView()
        scrollView.frame = ScreenBounds
        //为了让内容横向滚动，设置横向内容宽度为3个页面的宽度总和
        scrollView.contentSize=CGSizeMake(CGFloat(self.pageWidth*3),
            CGFloat(self.pageHeight))
        scrollView.pagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.scrollsToTop = false
        scrollView.delegate = self
        self.imageView0.frame = CGRect(x: 0, y: 0, width: self.pageWidth, height: self.pageHeight)
        self.imageView1.frame = CGRect(x: self.pageWidth, y: 0, width: self.pageWidth, height: self.pageHeight)
        self.imageView2.frame = CGRect(x: self.pageWidth * 2, y: 0, width: self.pageWidth, height: self.pageHeight)
        let tap = UITapGestureRecognizer(target: self, action: "imageViewClick:")
        scrollView.addGestureRecognizer(tap)

        scrollView.addSubview(self.imageView0)
        scrollView.addSubview(self.imageView1)
        scrollView.addSubview(self.imageView2)

        return scrollView
    }()

    private lazy var pageControl: UIPageControl = {
        let pageCrl = UIPageControl()
        pageCrl.hidesForSinglePage = true
        pageCrl.pageIndicatorTintColor = UIColor.darkGrayColor()
        pageCrl.currentPageIndicatorTintColor = UIColor.whiteColor()
        pageCrl.numberOfPages = self.rounds.count
        pageCrl.currentPage = 0
        let screenWidth = UIScreen.mainScreen().bounds.width
        let pageW: CGFloat = 80
        let pageH: CGFloat = 20
        let pageX: CGFloat = screenWidth/2 - pageW/2
        let pageY: CGFloat = CGFloat(self.pageHeight) - 30.0
        pageCrl.frame = CGRectMake(pageX, pageY, pageW, pageH)
        return pageCrl
    }()
    private func startTimer(){
        timer = nil
        timer = NSTimer.scheduledTimerWithTimeInterval(3.0, target: self, selector: "autoTurnNextView", userInfo: nil, repeats: true)
    }
    private func stopTimer(){
        guard let timer = self.timer else{
            return
        }
        if timer.valid{
            timer.invalidate()
        }
    }
    @objc private func autoTurnNextView(){

        if currentPage == rounds.count - 1{
            currentPage = 0
        }else{
            currentPage += 1
        }
        updateImageData()
    }

    // MARK: - 点击图片调转
    @objc private func imageViewClick(tap: UITapGestureRecognizer) {
        NSNotificationCenter.defaultCenter().postNotificationName(RoundImageClick, object: self, userInfo: [ "index" : currentPage])
    }

    deinit{
        stopTimer()
    }
}
extension PageScrollView: UIScrollViewDelegate{
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        let ratio = scrollView.contentOffset.x/scrollView.frame.size.width
        endScrollMethod(ratio)
    }
    func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if !decelerate{
            let ratio = scrollView.contentOffset.x/scrollView.frame.size.width
            endScrollMethod(ratio)
        }
    }
    func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        stopTimer()
    }
    private func endScrollMethod(ratio:CGFloat){
        if ratio <= 0.7{
            if currentPage - 1 < 0{
                currentPage = rounds.count - 1
            }else{
                currentPage -= 1
            }
        }
        if ratio >= 1.3{
            if currentPage == rounds.count - 1{
                currentPage = 0
            }else{
                currentPage += 1
            }
        }
        updateImageData()
        startTimer()
    }
    //MARK: - reload data
    private func updateImageData(){

        if currentPage == 0{
            imageView0.sd_setImageWithURL(NSURL(string: rounds.last!.rdata!.avatar!), placeholderImage: placeholderImage)
            imageView1.sd_setImageWithURL(NSURL(string: rounds[currentPage].rdata!.avatar!), placeholderImage: placeholderImage)
            imageView2.sd_setImageWithURL(NSURL(string: rounds[currentPage + 1].rdata!.avatar!), placeholderImage: placeholderImage)
        }else if currentPage == rounds.count - 1{
            imageView0.sd_setImageWithURL(NSURL(string: rounds[currentPage - 1].rdata!.avatar!), placeholderImage: placeholderImage)
            imageView1.sd_setImageWithURL(NSURL(string: rounds[currentPage].rdata!.avatar!), placeholderImage: placeholderImage)
            imageView2.sd_setImageWithURL(NSURL(string: rounds.first!.rdata!.avatar!), placeholderImage: placeholderImage)
        }else{
            imageView0.sd_setImageWithURL(NSURL(string: rounds[currentPage - 1].rdata!.avatar!), placeholderImage: placeholderImage)
            imageView1.sd_setImageWithURL(NSURL(string: rounds[currentPage].rdata!.avatar!), placeholderImage: placeholderImage)
            imageView2.sd_setImageWithURL(NSURL(string: rounds[currentPage + 1].rdata!.avatar!), placeholderImage: placeholderImage)
        }
        pageControl.currentPage = currentPage
        scrollView.contentOffset = CGPoint(x: scrollView.frame.size.width, y: 0)
    }
    
}
