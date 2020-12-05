//
//  CriteriaListViewController.swift
//  SPA Project
//
//  Created by Emanuil Gospodinov on 5.12.20.
//

import UIKit

final class CriteriaListViewController: UIViewController {
    
    @IBOutlet private weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        configureTableView()
    }
    
    //MARK: - Private
    private func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
    }

}


extension CriteriaListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return CriteriaManager.shared.sections[section].variant.title
    }
}

extension CriteriaListViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return CriteriaManager.shared.sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CriteriaManager.shared.sections[section].criteria.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        let section = CriteriaManager.shared.sections[indexPath.section]
        let criteria = section.criteria[indexPath.row]
        
        cell.textLabel?.text = criteria.title
        cell.accessoryType = criteria.points.increment != nil ? .disclosureIndicator : .none
        
        return cell
    }
}
