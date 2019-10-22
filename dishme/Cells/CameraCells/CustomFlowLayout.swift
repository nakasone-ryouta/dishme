//
//  CustomFlowLayout.swift
//  dishme
//
//  Created by 中曽根　涼太 on 2019/10/22.
//  Copyright © 2019年 中曽根　涼太. All rights reserved.
//

import Foundation
import UIKit

class CustomFlowLayout: UICollectionViewFlowLayout {
    
    private let largeFlickVelocityThreshold: CGFloat = 2.0
    private let minimumFlickVelocityThreshold: CGFloat = 0.2
    private let pageWidth: CGFloat = 320.0
    
    override init() {
        super.init()
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    private func setup() {
        itemSize = CGSize(width: 375, height: 600)
        minimumInteritemSpacing = 0
        minimumLineSpacing = 0
        sectionInset = UIEdgeInsets(top: 0.0, left: 0, bottom: 0.0, right: 0)
        scrollDirection = .horizontal
    }
    
    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
        guard let collectionView = collectionView else {
            return proposedContentOffset
        }
        
        let pageWidth = itemSize.width + minimumLineSpacing
        let currentPage = collectionView.contentOffset.x / pageWidth
        
        if abs(velocity.x) > largeFlickVelocityThreshold {
            // velocityが大きいときは2つ動かす
            let nextPage = (velocity.x > 0.0) ? ceil(currentPage) + 1 : floor(currentPage) - 1
            return CGPoint(x: nextPage * pageWidth, y: proposedContentOffset.y)
        } else if abs(velocity.x) > minimumFlickVelocityThreshold {
            // 1つ動かす
            let nextPage = (velocity.x > 0.0) ? ceil(currentPage) : floor(currentPage)
            return CGPoint(x: nextPage * pageWidth, y: proposedContentOffset.y)
        } else {
            // velocityが小さすぎるときは近いほうへ
            return CGPoint(x: round(currentPage) * pageWidth, y: proposedContentOffset.y)
        }
    }
    
}
