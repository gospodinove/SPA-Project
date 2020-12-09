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

        guard let region = regionTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines), region.isEmpty == false else { return }
        
        let tabBar = storyboard?.instantiateViewController(identifier: "MainTabBarViewController") as! UITabBarController
        
        let institutionsListVC = (tabBar.viewControllers?.first as! UINavigationController).viewControllers.first as! InstitutionsListViewController
        institutionsListVC.region = "\"\(region.capitalized)\""
        
        UIApplication.shared.changeRootViewController(to: tabBar, animation: .transitionCurlUp)
    }
}
