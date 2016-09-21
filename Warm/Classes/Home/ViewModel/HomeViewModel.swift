//
//  HomeViewModel.swift
//  Warm
//
//  Created by zhoucj on 16/9/13.
//  Copyright © 2016年 zhoucj. All rights reserved.
//

import UIKit

class HomeViewModel: NSObject {
    var rounds: [WRound] = [WRound]()
    var recommends: [WRecommend] = [WRecommend]()
    var salons: [WSalon] = [WSalon]()

    func resetData(){
        self.rounds.removeAll()
        self.recommends.removeAll()
        self.salons.removeAll()
    }
    //MARK: - 加载首页数据
    func loadHomeData(citycode: String, page: Int, finished: (data: AnyObject?, error: NSError?)->()){
        unowned let tmpSelf = self
        NetworkTools.sharedInstance.getHomeData(citycode, page: page, count: pageSize) { (data, error) -> () in
            // 安全校验
            if error != nil{
                finished(data: nil, error: error)
                return
            }
            guard let _data = data else{
                return
            }
            guard let _rounds = _data["rounds"] as? [[String: AnyObject]] else{
                return
            }
            guard let _recommends = _data["recommends"] as? [[String: AnyObject]] else{
                return
            }
            guard let _salons = _data["salons"] as? [[String: AnyObject]] else{
                return
            }
            if page == 1{
                for _round in _rounds {
                    let round = WRound(dict: _round)
                    tmpSelf.rounds.append(round)
                }
                for _recommend in _recommends{
                    let recommend = WRecommend(dict: _recommend)
                    tmpSelf.recommends.append(recommend)
                }
            }
            for _salon in _salons{
                let salon = WSalon(dict: _salon)
                tmpSelf.salons.append(salon)
            }
            finished(data: data, error: error)
        }
    }
}