//
//  CustomLayout.swift
//  Atif Saeed
//
//  Created by Atif Saeed on 10/10/21.
//

import UIKit

protocol CustomLayoutDelegate: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView (_ collectionView: UICollectionView,
                         layout: CustomLayout,
                         cellSizeForItemAtIndex indexPath: IndexPath, collectionViewWidth:CGFloat) -> CGSize
}


class CustomLayout: UICollectionViewLayout {
    
    // MARK: - Properties
    
    private var cache: [UICollectionViewLayoutAttributes] = []
    private var contentHeight: CGFloat = 0
    let numberOfColumns = 2
    var cellPadding: CGFloat = 0
    weak var delegate: CustomLayoutDelegate?
    var columnWidth: CGFloat {
        get {
            contentWidth / CGFloat(numberOfColumns)
        }
    }
    var contentWidth: CGFloat {
        get {
            guard let collectionView = collectionView else {
                return 0
            }
            let insets = collectionView.contentInset
            return collectionView.bounds.width - (insets.left + insets.right)
        }
    }
    
    
    // MARK: - Lifecycle Methods
    
    override func prepare() {
        guard let collectionView = collectionView
        else {
            return
        }
        cache.removeAll()
        contentHeight = 0
        var xOffset: [CGFloat] = []
        var column = 0
        var yOffset: [CGFloat] = .init(repeating: 0, count: numberOfColumns)
        
        for item in 0 ..< collectionView.numberOfItems(inSection: 0) {
            let indexPath = IndexPath(item: item, section: 0)
            
            let cellSize:CGSize = delegate?.collectionView(
                collectionView,layout: self,
                cellSizeForItemAtIndex: indexPath, collectionViewWidth: contentWidth) ?? CGSize(width: 100, height: 150)
            let takesFullRow = cellSize.width > columnWidth
            var y = yOffset[column]
            
            if takesFullRow {
                column = 0
                var longestColumn = 0
                for i in 0 ..< numberOfColumns {
                    if yOffset[i] > yOffset[longestColumn] {
                        longestColumn = i
                    }
                }
                y = yOffset[longestColumn]
            }
            xOffset.append(CGFloat(column) * columnWidth)
            
            let height = cellPadding * 2 + cellSize.height
            let frame = CGRect(x: xOffset.last ?? 0,
                               y: y,
                               width: cellSize.width,
                               height: height)
            let insetFrame = frame.insetBy(dx: cellPadding, dy: cellPadding)
            
            let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            attributes.frame = insetFrame
            cache.append(attributes)
            
            contentHeight = max(contentHeight, frame.maxY)
            yOffset[column] = y + height
            if takesFullRow {
                for i in 0 ..< numberOfColumns {
                    yOffset[i] = y + height
                }
            }
            if takesFullRow {
                column = 0
            } else {
                var leastColumn = 0
                for i in 0 ..< numberOfColumns {
                    if yOffset[i] < yOffset[leastColumn] {
                        leastColumn = i
                    }
                }
                column = leastColumn
            }
        }
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var visibleLayoutAttributes: [UICollectionViewLayoutAttributes] = []
        for attributes in cache {
            if attributes.frame.intersects(rect) {
                visibleLayoutAttributes.append(attributes)
            }
        }
        return visibleLayoutAttributes
    }
    
    override var collectionViewContentSize: CGSize {
        return CGSize(width: contentWidth, height: contentHeight + 100)
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return cache[indexPath.item]
    }
    
    override func shouldInvalidateLayout (forBoundsChange newBounds : CGRect) -> Bool {
        let oldBounds = self.collectionView!.bounds
        if newBounds.width != oldBounds.width{
            return true
        }
        return false
    }
    
    
    // MARK: - Helping Methods
    
    internal override func invalidationContext(forInteractivelyMovingItems targetIndexPaths: [IndexPath], withTargetPosition targetPosition: CGPoint, previousIndexPaths: [IndexPath], previousPosition: CGPoint) -> UICollectionViewLayoutInvalidationContext {
        let context = super.invalidationContext(forInteractivelyMovingItems: targetIndexPaths, withTargetPosition: targetPosition, previousIndexPaths: previousIndexPaths, previousPosition: previousPosition)
        self.delegate?.collectionView!(self.collectionView!, moveItemAt: previousIndexPaths[0], to: targetIndexPaths[0])
        return context
    }
}
