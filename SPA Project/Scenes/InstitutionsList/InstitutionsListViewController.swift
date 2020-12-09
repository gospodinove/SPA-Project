//
//  InstitutionsListViewController.swift
//  SPA Project
//
//  Created by Mitko on 4.12.20.
//

import UIKit

class InstitutionsListViewController: UIViewController {

    var region: String?

    @IBOutlet private weak var tableView: UITableView!

    override func viewDidLoad() {

        super.viewDidLoad()

        ParseManager.shared.parseCSV(region: region ?? "") 
        configureViews()
        configureNavigationItem()
    }
    
    private func configureViews() {
        
        title = "Детски градини"
        tabBarController?.tabBar.barTintColor = #colorLiteral(red: 0.4219818413, green: 0.7247959375, blue: 0.5735316873, alpha: 1)
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func getInstitution(forIndexPath indexPath: IndexPath) -> Institution{

        return ParseManager.shared.filteredInstitutions[indexPath.row]
    }
    
    private func configureNavigationItem() {
        
        let backButton = UIButton(type: .custom)
        backButton.setImage(UIImage(systemName: "chevron.left"), for: .normal) // Image can be downloaded from here below link
        backButton.setTitle("Back", for: .normal)
        backButton.setTitleColor(backButton.tintColor, for: .normal) // You can change the TitleColor
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
    }
    
    @objc private func backButtonTapped() {
        
        guard let vc = storyboard?.instantiateViewController(identifier: "ChooseRegionViewController") else { return }
        
        UIApplication.shared.changeRootViewController(to: vc, animation: .transitionCurlDown)
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


