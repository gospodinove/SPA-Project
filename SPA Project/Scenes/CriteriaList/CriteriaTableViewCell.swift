//
//  CriteriaTableViewCell.swift
//  SPA Project
//
//  Created by Emanuil Gospodinov on 5.12.20.
//

import UIKit

class CriteriaTableViewCell: UITableViewCell {
    private enum Variant {
        case selected
        case notSelected
        
        var iconImage: UIImage? {
            switch self {
            case .selected:
                return UIImage(systemName: "checkmark.circle")
            case .notSelected:
                return UIImage(systemName: "circle")
            }
        }
        
        mutating func toggle() {
            switch self {
            case .selected:
                self = .notSelected
            case .notSelected:
                self = .selected
            }
        }
    }
    
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var checkmarkButton: UIButton!
    @IBOutlet private weak var iconImageView: UIImageView!
    
    private var variant: Variant = .notSelected
    
    @IBAction private func checkmarkButtonTapped(_ sender: UIButton) {
        variant.toggle()
        checkmarkButton.setImage(variant.iconImage, for: .normal)
    }
    
    func configure(title: String, detailsImage: UIImage?) {
        titleLabel.text = title
        
        if detailsImage == nil {
            iconImageView.isHidden = true
        } else {
            iconImageView.isHidden = false
            iconImageView.image = detailsImage
        }
        
        checkmarkButton.setImage(variant.iconImage, for: .normal)
    }
}
