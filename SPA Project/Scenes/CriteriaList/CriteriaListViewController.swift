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

        title = "Критерии"
        
        configureTableView()
    }
    
    //MARK: - Private
    private func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 80
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
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "criteria", for: indexPath) as? CriteriaTableViewCell else {
            return UITableViewCell()
        }
        
        let section = CriteriaManager.shared.sections[indexPath.section]
        let criterion = section.criteria[indexPath.row]
        
        cell.delegate = self
        cell.configure(
            title: criterion.title,
            detailsImage: UIImage(systemName: criterion.points.increment == nil ? "info.circle" : "chevron.right"),
            variant: CriteriaManager.shared.isSelected(criterion) ? .selected : .notSelected
        )
        
        return cell
    }
}

extension CriteriaListViewController: CriteriaTableViewCellDelegate {
    func criteraiTableViewCell(_ cell: CriteriaTableViewCell, changedSelectionTo selection: CriteriaTableViewCell.Variant) {
        guard let indexPath = tableView.indexPath(for: cell) else { return }
        
        let section = CriteriaManager.shared.sections[indexPath.section]
        let criterion = section.criteria[indexPath.row]
        
        switch selection {
        case .selected:
            CriteriaManager.shared.select(criterion)
        case .notSelected:
            CriteriaManager.shared.deselect(criterion)
        }
    }
}
