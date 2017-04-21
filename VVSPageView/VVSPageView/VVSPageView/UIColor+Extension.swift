//
//  UIColor+Extension.swift
//  VVSPageView
//
//  Created by sw on 17/4/21.
//  Copyright © 2017年 sw. All rights reserved.
//

import UIKit

extension UIColor {
    
    convenience init(r: CGFloat, g: CGFloat, b: CGFloat, alpha: CGFloat = 1) {
        self.init(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: alpha)
    }
    
    // 计算属性 ： 只读属性 
    class var randomColor : UIColor {
        return UIColor(r: CGFloat(arc4random_uniform(256)), g : CGFloat(arc4random_uniform(256)), b : CGFloat(arc4random_uniform(256)))
    }
}
