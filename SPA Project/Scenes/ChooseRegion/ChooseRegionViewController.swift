//
//  ChooseRegionViewController.swift
//  SPA Project
//
//  Created by Mitko on 8.12.20.
//

import UIKit

class ChooseRegionViewController: UIViewController {

    @IBOutlet private weak var regionTextField: UITextField!
    @IBOutlet private weak var searchButton: UIButton!

    override func viewDidLoad() {

        super.viewDidLoad()
    }
    
    @IBAction func didTapOnSearchButton(_ sender: UIButton) {

        guard let region = regionTextField.text else { return }
        let vc = storyboard?.instantiateViewController(identifier: "InstitutionsListViewController") as! InstitutionsListViewController
        vc.region = "\"\(region.capitalized)\""
        navigationController?.pushViewController(vc, animated: true)
    }
}
