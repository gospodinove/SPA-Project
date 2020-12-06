//
//  InstitutionTableViewCell.swift
//  SPA Project
//
//  Created by Mitko on 6.12.20.
//

import UIKit
 
class InstitutionTableViewCell: UITableViewCell {

    @IBOutlet private weak var nameLabel: UILabel!

    var institution: Institution? {
        didSet {
            updateUI()
        }
    }

    override func awakeFromNib() {
        
        super.awakeFromNib()
        configureViews()
    }
    
    private func configureViews() {
        
    }

    private func updateUI() {

        guard let institution = institution else { return }

        nameLabel.text = institution.name
    }
}
