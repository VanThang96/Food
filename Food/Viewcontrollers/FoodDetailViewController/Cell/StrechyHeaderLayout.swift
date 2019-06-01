//
//  StrechyHeaderLayout.swift
//  Food
//
//  Created by win on 5/23/19.
//  Copyright © 2019 win. All rights reserved.
//

import UIKit

class StrechyHeaderLayout: UICollectionViewFlowLayout {
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        let layoutAttributes = super.layoutAttributesForElements(in: rect)
        layoutAttributes?.forEach({ (attributes) in
            if attributes.representedElementKind == UICollectionView.elementKindSectionHeader && attributes.indexPath.section == 0{
                guard let collectionView = collectionView else { return }
                
                let contentOffsetY = collectionView.contentOffset.y
                let width = collectionView.frame.width
                if contentOffsetY > 0 { return }
                
                //header
                attributes.frame = CGRect(x: 0, y: contentOffsetY, width: width, height: attributes.frame.height - contentOffsetY)
            }
        })
        
        return layoutAttributes
    }
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
}
