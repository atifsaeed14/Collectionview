//
//  DasboardCollectionViewCellShortcutCard.swift
//  Atif Saeed
//
//  Created by Atif Saeed on 10/10/21.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    // MARK: - Outlets
    
    @IBOutlet weak var iconImg: UIImageView!
    @IBOutlet weak var cardTitle: UILabel! {
        didSet {
            cardTitle.text = "index no "
        }
    }
    @IBOutlet weak var shortcutLabel: UILabel! {
        didSet {
            shortcutLabel.text = "SHORTCUT"
        }
    }
    
    
    // MARK: - LifeCycle Methods
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
