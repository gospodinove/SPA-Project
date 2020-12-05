//
//  CriteriaTableViewCell.swift
//  SPA Project
//
//  Created by Emanuil Gospodinov on 5.12.20.
//

import UIKit

protocol CriteriaTableViewCellDelegate: class {
    func criteraiTableViewCell(_ cell: CriteriaTableViewCell, changedSelectionTo selection: CriteriaTableViewCell.Variant)
}

class CriteriaTableViewCell: UITableViewCell {
    enum Variant {
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
        
        var iconTint: UIColor {
            switch self {
            case .selected:
                return .green
            case .notSelected:
                return .secondaryLabel
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
    
    var variant: Variant = .notSelected
    weak var delegate: CriteriaTableViewCellDelegate?
    
    @IBAction private func checkmarkButtonTapped(_ sender: UIButton) {
        variant.toggle()
        delegate?.criteraiTableViewCell(self, changedSelectionTo: variant)
    }
    
    func configure(title: String, detailsImage: UIImage?, variant: Variant) {
        titleLabel.text = title
        
        self.variant = variant
        
        if detailsImage == nil {
            iconImageView.isHidden = true
        } else {
            iconImageView.isHidden = false
            iconImageView.image = detailsImage
        }
        
        updateCheckmarkButton()
    }
    
    func updateCheckmarkButton() {
        checkmarkButton.tintColor = variant.iconTint
        checkmarkButton.setImage(variant.iconImage, for: .normal)
    }
}
