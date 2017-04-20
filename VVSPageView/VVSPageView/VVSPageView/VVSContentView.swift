//
//  VVSContentView.swift
//  VVSPageView
//
//  Created by sw on 17/4/19.
//  Copyright © 2017年 sw. All rights reserved.
//

import UIKit

class VVSContentView: UIView {

 
    fileprivate var childVcs : [UIViewController]
    
    init(frame: CGRect, childVcs: [UIViewController]) {
        self.childVcs = childVcs
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
