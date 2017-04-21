//
//  VVSPageStyle.swift
//  VVSPageView
//
//  Created by sw on 17/4/19.
//  Copyright © 2017年 sw. All rights reserved.
//

import UIKit

class VVSPageStyle {

    // titleView是否可以滚动
    var titleIsScrollEnable = false
    
    // titleView的label的属性
    var titleHeight : CGFloat = 44
    var normalColor : UIColor = .black
    var selectColor : UIColor = .orange
    var fontSize : CGFloat = 15
    var titleMargin : CGFloat = 30
    
    // titleView底部滚动条
    var bottomLineIsShowEnable = false
    var bottomLineHeight : CGFloat = 3
    var bottomLineColor : UIColor = .blue
    
    // titleView的label是否需要缩放
    var titleIsScaleWhenSelected = false
    var maxScale = 1.2
    
    // coverView
    var coverViewIsShowEnable = false
    var coverViewBgColor : UIColor = .black
    var coverViewMargin : CGFloat = 8
    var coverViewHeight : CGFloat = 24
    var CoverViewRadius : CGFloat = 12
    var coverViewAlpha : CGFloat  = 0.5

    // pageControl
    var pageControlHeight : CGFloat = 20
    var pageControlSelectColor : UIColor = .orange
    var pageControlNormalColor : UIColor = .white
    
    
    
    
}
