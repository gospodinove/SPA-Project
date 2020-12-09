//
//  ChooseRegionViewController.swift
//  SPA Project
//
//  Created by Mitko on 8.12.20.
//

import UIKit
import IQDropDownTextField

class ChooseRegionViewController: UIViewController {

    var itemList = ["Искър",
                    "Оборище",
                    "Витоша",
                    "Сердика",
                    "Студентски",
                    "Панчарево",
                    "Изгрев",
                    "Младост",
                    "Подуяне",
                    "Триадица",
                    "Лозенец",
                    "Красно село",
                    "Банкя",
                    "Възраждане",
                    "Овча Купел",
                    "Слатина",
                    "Връбница",
                    "Илинден",
                    "Надежда",
                    "Кремиковци",
                    "Люлин",
                    "Нови Искър"
    ]
   
    @IBOutlet weak var regionTextField: IQDropDownTextField!
    
    @IBOutlet private weak var searchButton: UIButton!

    override func viewDidLoad() {

        super.viewDidLoad()
        configureViews()
    }
    
    private func configureViews() {

        searchButton.layer.cornerRadius = 12.0
        regionTextField.itemList = itemList
    }
    @IBAction func didTapOnSearchButton(_ sender: UIButton) {

        guard let region = regionTextField.selectedItem?.trimmingCharacters(in: .whitespacesAndNewlines), region.isEmpty == false else { return }
        
        let tabBar = storyboard?.instantiateViewController(identifier: "MainTabBarViewController") as! UITabBarController
        
        let institutionsListVC = (tabBar.viewControllers?.first as! UINavigationController).viewControllers.first as! InstitutionsListViewController
        
        institutionsListVC.region = "\"\(region.capitalized)\""
        
        UIApplication.shared.changeRootViewController(to: tabBar, animation: .transitionCurlUp)
    }
}
