//
//  VVSContentView.swift
//  VVSPageView
//
//  Created by sw on 17/4/19.
//  Copyright © 2017年 sw. All rights reserved.
//

import UIKit

protocol VVSContentViewDelegate : class {
    func contentView(contentView: VVSContentView, didScrollToIndex index: Int)
}

private let kContentCellID = "kContentCellID"

class VVSContentView: UIView {

    weak var delegate : VVSContentViewDelegate?
    
    fileprivate var childVcs : [UIViewController]
    fileprivate var parentVc : UIViewController
    
    fileprivate lazy var collectionView : UICollectionView = {
        // layout
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = self.bounds.size
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        
        // collectionView
        let collectionView = UICollectionView(frame: self.bounds, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
        collectionView.scrollsToTop = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.bounces = false
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: kContentCellID)
        
        return collectionView
    
    }()
    
    init(frame: CGRect, childVcs: [UIViewController], parentVc : UIViewController) {
        self.childVcs = childVcs
        self.parentVc = parentVc
        super.init(frame: frame)
        addSubview(collectionView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension VVSContentView : UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return childVcs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // 获取cell
        let cell : UICollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: kContentCellID, for: indexPath)
        // 给cell设置内容
        for subview in cell.contentView.subviews {
            subview.removeFromSuperview()
        }
        let childVc = childVcs[indexPath.item]
        childVc.view.backgroundColor = UIColor.randomColor
        childVc.view.frame = cell.contentView.bounds
        cell.contentView.addSubview(childVc.view)
        return cell
        
    }
}

// MARK: -UICollectionViewDelegate/ UIScrollViewDelegate
extension VVSContentView : UICollectionViewDelegate {
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if decelerate {
            return
        }
        // 直接拖拽到指定页，没有减速滑动
        scrollViewDidEndScroll(scrollView: scrollView)
    }
    
    // 减速
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        scrollViewDidEndScroll(scrollView: scrollView)
    }
    
    private func scrollViewDidEndScroll(scrollView: UIScrollView) {
        let index = Int(scrollView.contentOffset.x / scrollView.bounds.width)
        delegate?.contentView(contentView: self, didScrollToIndex: index)
    }
}

// MARK: -VVSTitleViewDelegate
extension VVSContentView : VVSTitleViewDelegate {
    func titleView(titleView: VVSTitleView, didCilckIndex index: Int) {
        let indexPath = IndexPath(row: index, section: 0)
        collectionView.scrollToItem(at: indexPath, at: .left, animated: false)
    }
}
