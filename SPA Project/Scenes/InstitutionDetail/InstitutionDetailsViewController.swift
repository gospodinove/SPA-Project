//
//  InstitutionDetailsViewController.swift
//  SPA Project
//
//  Created by Mitko on 6.12.20.
//

import UIKit
import WebKit

class InstitutionDetailsViewController: UIViewController {

    var institution: Institution?

    @IBOutlet private weak var areaLabel: UILabel!
    @IBOutlet private weak var municipalityLabel: UILabel!
    @IBOutlet private weak var populatedPlaceLabel: UILabel!
    @IBOutlet private weak var regionLabel: UILabel!
    @IBOutlet private weak var institutionTypeLabel: UILabel!
    @IBOutlet private weak var institutionFinanceLabel: UILabel!
    @IBOutlet private weak var moreInfoButton: UIButton!

    override func viewDidLoad() {

        super.viewDidLoad()
        configureViews()
    }
    
    var labels: [UILabel]?
    
    private func configureViews() {

        title = institution?.name
        labels = [areaLabel, municipalityLabel, populatedPlaceLabel, regionLabel, institutionTypeLabel, institutionFinanceLabel]
        for label in labels ?? [] {
            label.font = UIFont(name: "HelveticaNeue", size: 18.0)
            label.textColor = .darkGray
        }
        updateUI()
    }
    
    private func updateUI() {

        guard let institution = institution else { return }

        areaLabel.text = ParseManager.shared.removeQuotes(institution.area)
        municipalityLabel.text = ParseManager.shared.removeQuotes(institution.municipality)
        populatedPlaceLabel.text = ParseManager.shared.removeQuotes(institution.populatedPlace)
        regionLabel.text = ParseManager.shared.removeQuotes(institution.region)
        institutionTypeLabel.text = ParseManager.shared.removeQuotes(institution.type)
        institutionFinanceLabel.text = ParseManager.shared.removeQuotes(institution.typeFinance)
    }
}
