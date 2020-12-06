//
//  CriteriaListViewController.swift
//  SPA Project
//
//  Created by Emanuil Gospodinov on 5.12.20.
//

import UIKit

final class CriteriaListViewController: UIViewController {
    
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var submitButton: UIButton!
    @IBOutlet private weak var belowSubmitButtonView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Критерии"
        
        configureTableView()
        configureSubmitButton()
        belowSubmitButtonView.backgroundColor = submitButton.backgroundColor
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // Reload visible cells
        tableView.reloadRows(at: tableView.indexPathsForVisibleRows ?? [], with: .automatic)
        updateSubmitButtonText()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "toCriterionDetails":
            guard let destination = segue.destination as? CriterionDetailsViewController,
                  let cell = sender as? CriteriaTableViewCell,
                  let indexPath = tableView.indexPath(for: cell) else { break }
            
            
            destination.criterion = getCriterion(forIndexPath: indexPath)
        default:
            break
        }
    }
    
    private func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 80
    }
    
    private func configureSubmitButton() {
        updateSubmitButtonText()
        submitButton.applyCustomStyle()
    }
    
    private func updateSubmitButtonText() {
        let points = CriteriaManager.shared.getAccumulatedPoints()
        submitButton.setTitle("Прегледайте \(points) точк\(points == 1 ? "a" : "и")", for: .normal)
    }
    
    private func getCriterion(forIndexPath indexPath: IndexPath) -> Criterion {
        let section = CriteriaManager.shared.sections[indexPath.section]
        return section.criteria[indexPath.row]
    }
}


extension CriteriaListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return CriteriaManager.shared.sections[section].variant.title
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
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
        
        let criterion = getCriterion(forIndexPath: indexPath)
        
        cell.delegate = self
        cell.configure(
            title: criterion.title,
            detailsImage: UIImage(systemName: criterion.directlySelectable ? "info.circle" : "chevron.right"),
            variant: CriteriaManager.shared.isSelected(criterion) ? .selected : .notSelected
        )
        
        return cell
    }
}

extension CriteriaListViewController: CriteriaTableViewCellDelegate {
    func criteraiTableViewCell(_ cell: CriteriaTableViewCell, changedSelectionTo selection: CriteriaTableViewCell.Variant) {
        guard let indexPath = tableView.indexPath(for: cell) else { return }
        
        let criterion = getCriterion(forIndexPath: indexPath)
        
        if criterion.directlySelectable == false, selection == .selected {
            cell.variant.toggle()
            performSegue(withIdentifier: "toCriterionDetails", sender: cell)
            return
        }
        
        switch selection {
        case .selected:
            CriteriaManager.shared.select(criterion)
        case .notSelected:
            CriteriaManager.shared.deselect(criterion)
        }
        
        cell.updateCheckmarkButton()
        updateSubmitButtonText()
    }
}
