//
//  CriterionDetailsViewController.swift
//  SPA Project
//
//  Created by Emanuil Gospodinov on 5.12.20.
//

import UIKit

class CriterionDetailsViewController: UIViewController {

    @IBOutlet private weak var criterionTitleLabel: UILabel!
    @IBOutlet private weak var pointsLabel: UILabel!
    
    @IBOutlet private weak var documentsLabel: UILabel!
    @IBOutlet private weak var documentsStackView: UIStackView!
    
    @IBOutlet private weak var itemCountPickerView: UIPickerView!
    @IBOutlet private weak var itemCountLabel: UILabel!
    @IBOutlet private weak var itemCountStackView: UIStackView!
    
    @IBOutlet private weak var addButton: UIButton!
    @IBOutlet private weak var belowAddButtonView: UIView!
    
    var criterion: Criterion?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Информация"
        
        addButton.applyCustomStyle()
        belowAddButtonView.backgroundColor = addButton.backgroundColor
        
        configureCounter()
        configureLabels()
        updateAddButton()
    }
    
    @IBAction private func addButtonTapped(_ sender: UIButton) {
        if let criterionUnwrapped = criterion {
            CriteriaManager.shared.select(criterionUnwrapped)
        }
        
        navigationController?.popViewController(animated: true)
    }
    
    private func configureCounter() {
        guard criterion?.directlySelectable == false else {
            itemCountStackView.isHidden = true
            return
        }
        
        itemCountPickerView.delegate = self
        itemCountPickerView.dataSource = self
        
        itemCountLabel.text = "Брой \(criterion?.points.countLabelText ?? "")"
    }
    
    private func configureLabels() {
        criterionTitleLabel.text = criterion?.title
        pointsLabel.text = criterion?.points.text
        
        if criterion?.additionalDocuments == nil {
            documentsStackView.isHidden = true
        } else {
            documentsLabel.text = criterion?.additionalDocuments?.reduce("", { $0 + $1.description + "\n\n" }).trimmingCharacters(in: .newlines)
        }
    }
    
    private func updateAddButton() {
        guard let criterion = criterion, CriteriaManager.shared.isSelected(criterion) == false else {
            addButton.isHidden = true
            belowAddButtonView.isHidden = true
            return
        }
        
        addButton.setTitle("Добавете \(criterion.accumulatedPoints) точк\(criterion.accumulatedPoints == 1 ? "a" : "и")", for: .normal)
    }
}

extension CriterionDetailsViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "\(row + 1)"
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        criterion?.updateSelectedCount(to: row + 1)
        updateAddButton()
    }
}

extension CriterionDetailsViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        guard let criterionUnwrapped = criterion else { return 0 }
        
        return criterionUnwrapped.points.stepsCount
    }
}
