//
//  SalonViewController.swift
//  Warm
//
//  Created by zhoucj on 16/9/22.
//  Copyright © 2016年 zhoucj. All rights reserved.
//

import UIKit
import SVProgressHUD

let SalonTableReuseIdentifier = "SalonTableReuseIdentifier"
class SalonViewController: UIViewController {
    let homeViewModel = HomeViewModel()
    var salons: WSalon?
    var salonId: Int64?{
        didSet{
            guard let id = salonId else{
                return
            }
            SVProgressHUD.setDefaultMaskType(.Black)
            SVProgressHUD.show()
            unowned let tmpSelf = self
            homeViewModel.loadSalonDetail(id) { (data, error) -> () in
                guard let _salon = data as? WSalon else {
                    return
                }
                tmpSelf.salons = _salon
                let height = tmpSelf.scrollView.caluHeight(_salon)
                tmpSelf.scrollView.contentSize = CGSize(width: ScreenWidth, height: height + 30)
                tmpSelf.view.layoutIfNeeded()
                SVProgressHUD.dismiss()
            }
        }
    }
    var _lastPosition: CGFloat = 0.0
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Color_GlobalBackground
        navigationItem.rightBarButtonItems = [UIBarButtonItem(customView: shareBtn), UIBarButtonItem(customView: loveBtn)]
        view.addSubview(scrollView)
        view.addSubview(editBtn)
    }
    private lazy var loveBtn: UIButton  = {
        let btn = UIButton()
        btn.setBackgroundImage(UIImage(named: "navigationLoveNormal_22x20_"), forState: .Normal)
        btn.addTarget(self, action: Selector("loveBtnClick:"), forControlEvents: .TouchUpInside)
        btn.setBackgroundImage(UIImage(named: "navigation_liked_22x22_"), forState: .Selected)
        btn.sizeToFit()
        return btn
    }()
    private lazy var shareBtn: UIButton = UIButton(target: self, backgroundImage: "navigationShare_20x20_", action: Selector("shareBtnClick"))

    private lazy var scrollView: SalonScrollView = {
        let sv = SalonScrollView(frame: ScreenBounds)
        sv.delegate = self
        return sv
    }()
    private lazy var editBtn: UIButton = {
        let btn = UIButton()
        btn.setBackgroundImage(UIImage(named: "edit_54x54_"), forState: .Normal)
        btn.addTarget(self, action: Selector("editBtnClick"), forControlEvents: .TouchUpInside)
        btn.frame = CGRect(x: 25.0, y: ScreenHeight - 70.0, width: 40.0, height: 40.0)
        btn.layer.cornerRadius = 20
        btn.layer.masksToBounds = true
        return btn
    }()

    @objc func loveBtnClick(btn: UIButton){
        btn.selected = !btn.selected
    }
    @objc func shareBtnClick(){
        ShareTools.shareApp(self, shareText: nil)
    }
    @objc func editBtnClick(){
        CJLog("edit")
    }
    deinit{
        SVProgressHUD.dismiss()
    }
}
extension SalonViewController: UIScrollViewDelegate{
    //滚动事件
    func scrollViewDidScroll(scrollView: UIScrollView) {
        unowned let tmpSelf = self
        let currentPostion = scrollView.contentOffset.y;
        if (currentPostion - _lastPosition > 40) {
            _lastPosition = currentPostion;
            //消失
            UIView.animateWithDuration(0.5, animations: { () -> Void in
                tmpSelf.editBtn.frame = CGRect(x: -65.0, y: ScreenHeight - 70.0, width: 40.0, height: 40.0)
            })
        }else if (_lastPosition - currentPostion > 40){
            _lastPosition = currentPostion;
            //隐藏
            UIView.animateWithDuration(0.5, animations: { () -> Void in
                tmpSelf.editBtn.frame = CGRect(x: 25.0, y: ScreenHeight - 70.0, width: 40.0, height: 40.0)
            })
        }
    }
}
