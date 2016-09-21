//
//  NewFeatureViewController.swift
//  Warm
//
//  Created by zhoucj on 16/9/16.
//  Copyright © 2016年 zhoucj. All rights reserved.
//

import UIKit
let NewFeatureReuseIdentifier = "NewFeatureReuseIdentifier"
class NewFeatureViewController: UIViewController {
    private var picCounts = 3
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    private func setupUI(){
        view.addSubview(collectionView)
    }

    private lazy var collectionView: UICollectionView = {
        let clv = UICollectionView(frame: self.view.bounds, collectionViewLayout: NewFeatureViewFlowLayout())
        clv.registerClass(NewFeatureCollectionViewCell.self, forCellWithReuseIdentifier: NewFeatureReuseIdentifier)
        clv.dataSource = self
        clv.delegate = self
        return clv
    }()
}
//MARK: - UICollectionViewDataSource代理
extension NewFeatureViewController: UICollectionViewDataSource{
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return picCounts
    }
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(NewFeatureReuseIdentifier, forIndexPath: indexPath) as! NewFeatureCollectionViewCell
        cell.index = indexPath.item
        return cell
    }
}
//MARK: - UICollectionViewDelegate代理
extension NewFeatureViewController: UICollectionViewDelegate{
    func collectionView(collectionView: UICollectionView, didEndDisplayingCell cell: UICollectionViewCell, forItemAtIndexPath indexPath: NSIndexPath) {
        //注意: 传入的cell和indexPath都是上一页的,不是当前页的

        //手动获取当前显示的cell对应的index
        let index = collectionView.indexPathsForVisibleItems().last!
        //根据指定的index获取当前显示的cell
        let currentCell = collectionView.cellForItemAtIndexPath(index) as! NewFeatureCollectionViewCell
        if index.item == (picCounts - 1){
            currentCell.pageBtnEnable()
        }
    }
}

//MAKE: - 自定义Cell
class NewFeatureCollectionViewCell: UICollectionViewCell{
    var index: Int = 0{
        didSet{
            bgImageView.image = UIImage(named: "splash0\(index+1)_background_640x960_")
            pageBtn.setBackgroundImage(UIImage(named: "splash0\(index+1)_dot_130x29_"), forState: .Normal)
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupUI()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI(){
        contentView.addSubview(bgImageView)
        contentView.addSubview(pageBtn)
    }
    //图片
    private lazy var bgImageView: UIImageView = {
        let iv = UIImageView()
        iv.frame = ScreenBounds
        return iv
    }()

    private lazy var pageBtn: UIButton = {
        let btn = UIButton()
        btn.frame = CGRect(x: (ScreenWidth - 130)/2, y: ScreenHeight - 140, width: 130, height: 29)
        btn.addTarget(self, action: Selector("pageBtnClick"), forControlEvents: .TouchUpInside)
        btn.enabled = false
        return btn
    }()
    //MARK: - 外部调用
    func pageBtnEnable(){
        pageBtn.enabled = true
        pageBtn.transform = CGAffineTransformMakeScale(0, 0)
        pageBtn.userInteractionEnabled = false
        unowned let tmpSelf = self
        UIView.animateWithDuration(2.0, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 10, options: UIViewAnimationOptions(rawValue: 0), animations: { () -> Void in
            tmpSelf.pageBtn.transform = CGAffineTransformIdentity
            }, completion: { (_) -> Void in
                tmpSelf.pageBtn.userInteractionEnabled = true
        })
    }
    @objc private func pageBtnClick(){
        //跳转到主页面
        NSNotificationCenter.defaultCenter().postNotificationName(SwitchRootViewController, object: true, userInfo: ["image" : ""])
    }
}
//MARK: - 自定义collectionView布局
class NewFeatureViewFlowLayout: UICollectionViewFlowLayout  {
    override func prepareLayout() {
        super.prepareLayout()
        //设置每个cell尺寸
        itemSize = ScreenBounds.size
        // 最小的行距
        minimumLineSpacing = 0
        // 最小的列距
        minimumInteritemSpacing = 0
        // collectionView的滚动方向
        scrollDirection =  .Horizontal // default .Vertical
        //设置分页
        collectionView?.pagingEnabled = true
        //禁用回弹
        collectionView?.bounces = false
        //去除滚动条
        collectionView?.showsHorizontalScrollIndicator = false
        collectionView?.showsVerticalScrollIndicator = false
    }
}

