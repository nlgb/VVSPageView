//
//  ViewController.swift
//  VVSPageView
//
//  Created by sw on 17/4/19.
//  Copyright © 2017年 sw. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let style = VVSPageStyle()
        style.titleIsScrollEnable = false
        automaticallyAdjustsScrollViewInsets = false
        let titles = ["精华","热门视频","图片","文字"]

//        let titles = ["精华","热门视频","动态图片","搞笑文字","热门游戏","广告"]
        var childVcs = [UIViewController]()
        
        for _ in 0..<titles.count {
            let vc = UIViewController()
            vc.view.backgroundColor = UIColor(red: CGFloat(arc4random_uniform(256))/255.0, green: CGFloat(arc4random_uniform(256))/255.0, blue: CGFloat(arc4random_uniform(256))/255.0, alpha: 1.0)
            childVcs.append(vc)
        }
        let pageViewFrame = CGRect(x: 0, y: 64, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height - 64)
        let pageView = VVSPageView(frame: pageViewFrame, style: style, titles: titles, childVcs: childVcs, parentVc: self)
        pageView.backgroundColor = .blue
        view.addSubview(pageView)
    }


}

