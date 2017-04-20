//
//  VVSTitleView.swift
//  VVSPageView
//
//  Created by sw on 17/4/19.
//  Copyright © 2017年 sw. All rights reserved.
//

import UIKit

class VVSTitleView: UIView {

    
    fileprivate var style : VVSPageStyle
    fileprivate var titles : [String]
    fileprivate var titleLabels : [UILabel] = [UILabel]()
    fileprivate lazy var scrollView : UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.frame = self.bounds
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.scrollsToTop = false
        return scrollView
    }()
    
    // MARK:- 构造函数
//    init(frame: CGRect, style : VVSPageStyle, titles : Array<String>) {

    init(frame: CGRect, style : VVSPageStyle, titles : [String]) {

        self.style = style
        self.titles = titles
        
        super.init(frame: frame)
        
        setupUI()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK:- UI
extension VVSTitleView {
    fileprivate func setupUI() {
        // 添加一个scrollView
        addSubview(scrollView)
        // 添加label
        setupTitleLabels()
        // 设置label的frame
        setupLabelFrame()
    }
    
    private func setupLabelFrame() {
        var labelW : CGFloat = 0
        let labelH : CGFloat = frame.height
        var labelX : CGFloat = 0
        let labelY : CGFloat = 0
        for (i, titleLabel) in titleLabels.enumerated() {
            if style.titleIsScrollEnable {// 可以滚动
                 labelW = (titles[i] as NSString).boundingRect(with: CGSize(width:CGFloat.greatestFiniteMagnitude, height : 0) , options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSFontAttributeName : titleLabel.font], context: nil).width
                labelX = titleLabel.tag == 0 ? style.titleMargin * 0.5 : (titleLabels[i - 1].frame.maxX + style.titleMargin)
            } else {// 不可以滚动
                labelW = frame.width / CGFloat(titleLabels.count)
                labelX = labelW * CGFloat(i)
            }
            titleLabel.frame = CGRect(x: labelX, y: labelY, width: labelW, height: labelH)
        }
        
        // 如果标题是可以滚动的，那么需要设置scrollView的contentSize
        if style.titleIsScrollEnable {
            guard let lastLabel = titleLabels.last else {
                return
            }
            scrollView.contentSize = CGSize(width: lastLabel.frame.maxX + style.titleMargin * 0.5, height: 0)
        }
    }
    
    private func setupTitleLabels() {
        for (i,title) in titles.enumerated() {
            let label = UILabel()
            label.tag = i
            label.text = title
            label.textAlignment = .center
            label.backgroundColor = i == 0 ? style.selectColor : style.normalColor
            label.font = UIFont.systemFont(ofSize: style.fontSize)
            scrollView.addSubview(label)

            titleLabels.append(label)
            
            let tapGes = UITapGestureRecognizer(target: self, action: #selector(titleLabelClick(_:)))
            label.addGestureRecognizer(tapGes)
            label.isUserInteractionEnabled = true
        }
    }
}

// MARK:- lazy
extension VVSTitleView {
    @objc fileprivate func titleLabelClick(_ tapGes:UITapGestureRecognizer) {
        guard let target = tapGes.view as? UILabel else {
            return
        }
        print(target.tag)
    }
}
