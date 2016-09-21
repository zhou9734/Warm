//
//  TopicViewController.swift
//  Warm
//
//  Created by zhoucj on 16/9/19.
//  Copyright © 2016年 zhoucj. All rights reserved.
//

import UIKit

class TopicViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Color_GlobalBackground
        title = "发起话题"
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: rightBtn)
        setupUI()
        setupConstraint()
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        var textAttrs: [String : AnyObject] = Dictionary()
        textAttrs[NSForegroundColorAttributeName] = UIColor.blackColor()
        textAttrs[NSFontAttributeName] = UIFont.systemFontOfSize(17)
        navigationController?.navigationBar.titleTextAttributes = textAttrs
    }

    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        textView.resignFirstResponder()
        titleField.resignFirstResponder()
    }

    private func setupUI(){
        view.addSubview(bgImageView)
        view.addSubview(iconBtn)
        view.addSubview(deleteBtn)
        view.addSubview(titleField)
        view.addSubview(textView)
        view.addSubview(placeholderLbl)
        rightBtn.enabled = false
    }

    private func setupConstraint(){
        bgImageView.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(view.snp_top).offset(64)
            make.left.right.equalTo(view)
            make.height.equalTo(180)
        }
        iconBtn.snp_makeConstraints { (make) -> Void in
            make.centerX.equalTo(view.snp_centerX)
            make.top.equalTo(bgImageView.snp_top).offset(30)
            make.height.width.equalTo(47.0)
        }
        deleteBtn.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(bgImageView.snp_top).offset(20)
            make.right.equalTo(view.snp_right).offset(-10)
            make.size.equalTo(CGSize(width: 30.0, height: 30.0))
        }
        titleField.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(iconBtn.snp_bottom).offset(20)
            make.centerX.equalTo(view.snp_centerX)
            make.width.equalTo(ScreenWidth - 40)
            make.height.equalTo(30)
        }
        textView.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(bgImageView.snp_bottom)
            make.left.right.bottom.equalTo(view)
        }
        placeholderLbl.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(textView.snp_top).offset(8)
            make.left.equalTo(textView.snp_left).offset(4)
            make.width.equalTo(200)
        }
    }
    

    private lazy var rightBtn: UIButton = {
        let btn = UIButton()
        btn.setTitle("提交", forState: .Normal)
        btn.setTitleColor(UIColor.blackColor(), forState: .Normal)
        btn.setTitleColor(UIColor.grayColor(), forState: .Disabled)
        btn.sizeToFit()
        return btn
    }()

    private lazy var bgImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "bgCover_375x200_")
        return iv
    }()

    private lazy var iconBtn: UIButton = {
        let btn = UIButton()
        btn.setBackgroundImage(UIImage(named: "icPhoto_47x47_"), forState: .Normal)
        btn.layer.cornerRadius = 47.0/2
        btn.layer.masksToBounds = true
        btn.addTarget(self, action: Selector("selectTitleBg"), forControlEvents: .TouchUpInside)
        return btn
    }()
    private lazy var deleteBtn: UIButton = {
        let btn = UIButton()
        btn.setBackgroundImage(UIImage(named: "icDeletecoverphoto_45x45_"), forState: .Normal)
        btn.addTarget(self, action: Selector("deleteBtnClick:"), forControlEvents: .TouchUpInside)
        btn.hidden = true
        btn.sizeToFit()
        return btn
    }()
    private lazy var titleField: UITextField = {
        let txt = UITextField()
        txt.placeholder = "取个响亮的标题吧"
        txt.textAlignment = .Center
        txt.backgroundColor = Color_GlobalBackground
        txt.textColor = UIColor.blackColor()
        txt.font = UIFont.systemFontOfSize(15)
        return txt
    }()

    private lazy var textView: UITextView = {
        let tv = UITextView()
        tv.font = UIFont.systemFontOfSize(15)
        tv.alwaysBounceVertical = true
        tv.delegate = self
        return tv
    }()
    //提示标签
    private lazy var placeholderLbl: UILabel = {
        let lbl = UILabel()
        lbl.text = "最多可添加12张图片"
        lbl.textColor = UIColor.grayColor()
        lbl.textAlignment = .Left
        lbl.font = UIFont.systemFontOfSize(16)
        return lbl
    }()
    @objc private func selectTitleBg(){
        if !UIImagePickerController.isSourceTypeAvailable(.PhotoLibrary){
            alert("不能打开相册")
            return
        }
        // 2.创建图片选择器
        let vc = UIImagePickerController()
        vc.delegate = self
        // 设置允许用户编辑选中的图片
        // 开发中如果需要上传头像, 那么请让用户编辑之后再上传
        // 这样可以得到一张正方形的图片, 以便于后期处理(圆形)
        //vc.allowsEditing = true
        presentViewController(vc, animated: true, completion: nil)

    }
    @objc private func deleteBtnClick(btn: UIButton){
        bgImageView.image = UIImage(named: "bgCover_375x200_")
        btn.hidden = true
    }
}
//MARK: - textView代理
extension TopicViewController: UITextViewDelegate{
    func textViewDidChange(textView: UITextView) {
        placeholderLbl.hidden = textView.hasText()
        rightBtn.enabled = (textView.hasText() && titleField.hasText())
    }
    //即将拖拽
    func scrollViewWillBeginDecelerating(scrollView: UIScrollView) {
        textView.resignFirstResponder()
    }
}
extension TopicViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        let newImage = image.imageWithScale(ScreenWidth)
        bgImageView.image = newImage
        deleteBtn.hidden = false
        picker.dismissViewControllerAnimated(true, completion: nil)
    }
}
