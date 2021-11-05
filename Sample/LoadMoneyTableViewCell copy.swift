//
//  LoadMoneyTableViewCell.swift
//  MyTelenor
//
//  Created by Atif Saeed on 09/01/2021.
//  Copyright © 2021 Telenor. All rights reserved.
//

import UIKit

class LoadMoneyTableViewCell: UITableViewCell {

    
    // MARK: - Properties

    @IBOutlet weak var headingLabel: UILabel! {
        didSet {
//            headingLabel.font = ASFont.standard.of(size: .extraMedium)
//            headingLabel.textColor = .black
//            headingLabel.textAlignment = .center
//            headingLabel.layer.cornerRadius = 14
//            headingLabel.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
//            headingLabel.layer.masksToBounds = true
//            headingLabel.layer.borderWidth = 1.0
//            headingLabel.layer.backgroundColor = #colorLiteral(red: 0.8549019608, green: 0.8274509804, blue: 1, alpha: 1)
//            headingLabel.layer.borderColor = UIColor.black.cgColor
        }
    }
    
    // MARK: - Cell Methods
    // MARK: - Helping Methods

    // MARK: - Life Cycle

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
