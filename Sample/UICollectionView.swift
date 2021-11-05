//
//  UICollectionView.swift
//  ASSnippet
//

import UIKit

extension UICollectionView {
    func registerNib(with type: UICollectionViewCell.Type) {
        let name = String(describing: type.self)
        let nib = UINib.init(nibName: name, bundle: nil)
        register(nib, forCellWithReuseIdentifier: name)
    }
    
    func dequeueReusableCell<C: UICollectionViewCell>(with type: C.Type, at indexPath: IndexPath) -> C? {
        return dequeueReusableCell(withReuseIdentifier: String(describing: C.self), for: indexPath) as? C
    }
}

extension UIScrollView {
    var isAtBottom: Bool {
        return contentOffset.y >= verticalOffsetForBottom
    }
    
    var verticalOffsetForBottom: CGFloat {
        let scrollViewHeight = bounds.height
        let scrollContentSizeHeight = contentSize.height
        let bottomInset = contentInset.bottom
        let scrollViewBottomOffset = scrollContentSizeHeight + bottomInset - scrollViewHeight
        return scrollViewBottomOffset
    }
}
