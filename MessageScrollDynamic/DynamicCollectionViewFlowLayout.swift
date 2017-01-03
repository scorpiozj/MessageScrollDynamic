//
//  DynamicCollectionViewFlowLayout.swift
//  MessageScrollDynamic
//
//  Created by ZhuJiang on 17/1/2.
//  Copyright © 2017年 Charles. All rights reserved.
//

import UIKit

class DynamicCollectionViewFlowLayout: UICollectionViewFlowLayout {
    
    var dynamicAnimator: UIDynamicAnimator?
    
    override func prepare() {
        super.prepare()
        
        if dynamicAnimator == nil {
            dynamicAnimator = UIDynamicAnimator.init(collectionViewLayout: self)
            
            let contentSize = self.collectionViewContentSize
            let itemArray = super.layoutAttributesForElements(in: CGRect(x: 0, y: 0, width: contentSize.width, height: contentSize.height))
            
            for item in itemArray! {
                if let attri = item as? UICollectionViewLayoutAttributes {
                    let spring = UIAttachmentBehavior.init(item: attri, attachedToAnchor: attri.center)
                    spring.length = 0
                    spring.damping = 0.5
                    spring.frequency = 0.8
                    self.dynamicAnimator!.addBehavior(spring)
                } else {
                    print("should not happen")
                }
            }
        }
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return self.dynamicAnimator?.items(in: rect) as! [UICollectionViewLayoutAttributes]?
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return self.dynamicAnimator?.layoutAttributesForCell(at: indexPath)
    }
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        let scrollView = self.collectionView! as? UIScrollView
        let delta = newBounds.origin.y - (scrollView!.bounds.origin.y)
        for behavior  in (self.dynamicAnimator?.behaviors)! {
            if let attach = behavior as? UIAttachmentBehavior{
                let attri = attach.items.first as? UICollectionViewLayoutAttributes
                var center = attri!.center
                center.y += delta
                attri!.center = center
                
                self.dynamicAnimator!.updateItem(usingCurrentState: attri as! UIDynamicItem)
                
            }
        }
        
        
        return false
    }
}
