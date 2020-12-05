//
//  InstitutionsListViewController.swift
//  SPA Project
//
//  Created by Mitko on 4.12.20.
//

import UIKit

class InstitutionsListViewController: UIViewController {

    @IBOutlet private weak var tableView: UITableView!

    override func viewDidLoad() {

        super.viewDidLoad()
        ParseManager.shared.parseCSV()
    }
}
