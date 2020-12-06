//
//  InstitutionDetailsViewController.swift
//  SPA Project
//
//  Created by Mitko on 6.12.20.
//

import UIKit

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
    
    private func configureViews() {

        title = institution?.name
        updateUI()
    }
    
    private func updateUI() {

        guard let institution = institution else { return }

        areaLabel.text = institution.area
        municipalityLabel.text = institution.municipality
        populatedPlaceLabel.text = institution.populatedPlace
        regionLabel.text = institution.region
        institutionTypeLabel.text = institution.type
        institutionFinanceLabel.text = institution.typeFinance
    }
}
