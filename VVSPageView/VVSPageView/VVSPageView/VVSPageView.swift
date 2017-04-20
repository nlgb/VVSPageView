//
//  VVSPageView.swift
//  VVSPageView
//
//  Created by sw on 17/4/19.
//  Copyright © 2017年 sw. All rights reserved.
//

import UIKit

class VVSPageView: UIView {

    fileprivate var style : VVSPageStyle
    fileprivate var titles : [String]
    fileprivate var childVcs : [UIViewController]
    
    init(frame: CGRect, style: VVSPageStyle, titles: [String], childVcs: [UIViewController]) {
        self.style = style
        self.titles = titles
        self.childVcs = childVcs
        
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

// MARK: -UI
extension VVSPageView {
    fileprivate func setupUI() {
        // 创建titleView
        let titleViewFrame = CGRect(x: 0, y: 0, width: bounds.width, height: style.titleHeight)
        let titleView = VVSTitleView(frame: titleViewFrame, style: style, titles: titles)
        titleView.backgroundColor = .gray
        addSubview(titleView)
        // 创建contentView
        
        // 让titleView和contentView可以交互
        
    }
}
