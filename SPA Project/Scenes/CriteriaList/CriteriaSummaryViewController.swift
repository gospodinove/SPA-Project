//
//  CriteriaSummaryViewController.swift
//  SPA Project
//
//  Created by Emanuil Gospodinov on 6.12.20.
//

import UIKit

class CriteriaSummaryViewController: UIViewController {

    @IBOutlet private weak var pointsLabel: UILabel!
    @IBOutlet private weak var additionalPointsLabel: UILabel!
    @IBOutlet private weak var linkButton: UIButton!
    @IBOutlet private weak var dismissButton: UIButton!
    @IBOutlet private weak var belowDismissButtonView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        dismissButton.applyCustomStyle()
        belowDismissButtonView.backgroundColor = dismissButton.backgroundColor
        
        let points = CriteriaManager.shared.getAccumulatedPoints()
        pointsLabel.text = "Имате \(points) точк\(points == 1 ? "a" : "и") от избраните критерии"
        additionalPointsLabel.text = "За всяко дете, автоматично се дават допълнителни точки по реда на желанията:\n1.   в градината по първо желание - 3 т.\n2.  в градината по второ желание - 2 т.\n3.  в градината по трето желание - 1 т."
    }
    
    @IBAction func linkTapped(_ sender: UIButton) {
        guard let url = URL(string: "https://kg.sofia.bg/isodz/sdoc/pr1.html") else { return }
        
        UIApplication.shared.open(url)
    }

    @IBAction func dismissTapped(_ sender: UIButton) {
        dismiss(animated: true)
    }
}
