//
//  VVSTitleView.swift
//  VVSPageView
//
//  Created by sw on 17/4/19.
//  Copyright © 2017年 sw. All rights reserved.
//

import UIKit

protocol VVSTitleViewDelegate : class {
    func titleView(titleView : VVSTitleView, didCilckIndex  index : Int)
}

class VVSTitleView: UIView {
    // delegate 用weak修饰 代理遵守协议不再用<>，改用 :
    weak var delegate : VVSTitleViewDelegate?
    fileprivate var currentIndex : Int = 0
    
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
            label.textColor = i == 0 ? style.selectColor : style.normalColor
            label.font = UIFont.systemFont(ofSize: style.fontSize)
            scrollView.addSubview(label)

            titleLabels.append(label)
            
            let tapGes = UITapGestureRecognizer(target: self, action: #selector(titleLabelClick(_:)))
            label.addGestureRecognizer(tapGes)
            label.isUserInteractionEnabled = true
        }
    }
}

// MARK:- 事件监听
extension VVSTitleView {
    @objc fileprivate func titleLabelClick(_ tapGes:UITapGestureRecognizer) {
        guard let targetLabel = tapGes.view as? UILabel else {
            return
        }
        print(targetLabel.tag)
        
        // 点击了同一个标签
        if targetLabel.tag == currentIndex {
            return
        }
        
        // 修改上个标签的状态
        let lastLabel = titleLabels[currentIndex]
        lastLabel.textColor = style.normalColor
        // 修改当前标签的状态
        let currentLabel = targetLabel
        currentLabel.textColor = style.selectColor
        currentIndex = currentLabel.tag
        // 居中显示
        if style.titleIsScrollEnable {
            adjustLabelPosition(label: currentLabel)
        }
        // 通知delegate
        delegate?.titleView(titleView: self, didCilckIndex: currentIndex)
        
    }
    
    fileprivate func adjustLabelPosition(label : UILabel) {
        // 1.计算一下offsetX
        var offsetX = label.center.x - bounds.width * 0.5
        
        // 2.临界值的判断
        if offsetX < 0 {
            offsetX = 0
        }
        if offsetX > scrollView.contentSize.width - scrollView.bounds.width {
            offsetX = scrollView.contentSize.width - scrollView.bounds.width
        }
        // 3.设置scrollView的contentOffset
        scrollView.setContentOffset(CGPoint(x: offsetX, y: 0), animated: true)

    }
}

extension VVSTitleView : VVSContentViewDelegate {
    func contentView(contentView: VVSContentView, didScrollToIndex index: Int) {
        if style.titleIsScrollEnable {
            adjustLabelPosition(label: titleLabels[index])
        }
        
        // 如果titleView支持渐变
        if style.titleIsTransitionEnable  {
            
        } else {
        // 如果titleView不支持渐变
            let lastLabel = titleLabels[currentIndex]
            let currentLabel = titleLabels[index]
            lastLabel.textColor = style.normalColor
            currentLabel.textColor = style.selectColor
            
        }
        currentIndex = index
    }
}
