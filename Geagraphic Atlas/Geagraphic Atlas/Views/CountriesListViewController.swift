//
//  ViewController.swift
//  Geagraphic Atlas
//
//  Created by Adil Gumarov on 14.05.2023.
//

import UIKit
import SnapKit

class CountriesListViewController: UIViewController {
    
    let tableView = UITableView()
    let viewModel = CountryListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        title = Constant.title
        
        viewModel.delegate = self
        viewModel.getDataFromApi()

        initialize()
    }

    func initialize() {
        
        tableView.register(CountriesListTableViewCell.self, forCellReuseIdentifier: Constant.cellListIdentifier)
        
        tableView.dataSource = self

        tableView.separatorStyle = .none
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

extension CountriesListViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.getNumberOfConinents()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getNumberOfRowInSection(section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constant.cellListIdentifier, for: indexPath) as! CountriesListTableViewCell

        cell.delegate = self
        
        let country = viewModel.getCountry(from: indexPath)!
        let imageUrl = viewModel.getUrlOfImage(from: indexPath)
        let isExpanded = viewModel.isExpanded(country.name.common)
        let currency = viewModel.getCurrency(from: indexPath)
        cell.setData(imageURL: imageUrl, country: country, currency: currency, isExpanded: isExpanded)

        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return viewModel.getTitleOfSection(from: section)
    }
}

extension CountriesListViewController: CountriesListTableViewCellDelegate {
    func learnMoreButtonTapped(_ cell: UITableViewCell) {
        if let indexPath = tableView.indexPath(for: cell) {
            let country = viewModel.getCountry(from: indexPath)!
            let detailVC = CountryDetailViewController(country.cca2)
            
            detailVC.title = country.name.common
            navigationController?.pushViewController(detailVC, animated: true)
        }
    }
    
    func buttonTapped(_ cell: UITableViewCell) {
        
        if let indexPath = tableView.indexPath(for: cell) {
            let country = viewModel.getCountry(from: indexPath)!
            let countryName = country.name.common
            
            if !viewModel.isExpanded(countryName) {
                viewModel.insertCountry(by: countryName)
            } else {
                viewModel.removeCountry(by: countryName)
            }
        
            tableView.reloadRows(at: [indexPath], with: .automatic)
        }
    }
}

extension CountriesListViewController: CountryListViewModelDelegate {
    func fetchingEnd() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}
