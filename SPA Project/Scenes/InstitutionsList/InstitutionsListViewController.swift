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

        ParseManager.shared.parseCSV(region: "\"Искър\"")
        configureViews()
    }
    
    private func configureViews() {
        
        title = "Детски градини"
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func getInstitution(forIndexPath indexPath: IndexPath) -> Institution{

        return ParseManager.shared.filteredInstitutions[indexPath.row]
    }
}

// MARK: - UITableViewDataSource

extension InstitutionsListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return ParseManager.shared.filteredInstitutions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let cell = tableView.dequeueReusableCell(withIdentifier: "institution", for: indexPath) as? InstitutionTableViewCell
        else { return UITableViewCell() }
        
        let institution = getInstitution(forIndexPath: indexPath)
        cell.institution = institution

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let institution = getInstitution(forIndexPath: indexPath)
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "InstitutionDetailsViewController") as! InstitutionDetailsViewController
        vc.institution = institution
        navigationController?.pushViewController(vc, animated: true)

        tableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: - UITableViewDelegate

extension InstitutionsListViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 60.0
    }
}


