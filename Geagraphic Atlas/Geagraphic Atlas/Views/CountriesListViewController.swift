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
    
    let list = ["Kazakhstan", "Japan", "South Korea", "Malaysia", "Kyrgyzstan", "China"]
    
    let viewModel = CountryListViewModel()

    var data = [CountryListModel]()
    var continentsData: [String: [CountryListModel]] = [:]
    var continentSections: [String] = []
    var expandedCards: Set<String> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        title = "World countries"
        
        viewModel.fetchingData(URL: "https://restcountries.com/v3.1/all") { [self] data in
            print(data)
            self.data = data
            self.data.forEach { country in
                if let continent = country.continents.first {
                    if var continentCountries = self.continentsData[continent] {
                        continentCountries.append(country)
                        continentsData[continent] = continentCountries
                    } else {
                        continentsData[continent] = [country]
                    }
                }
                continentSections = continentsData.keys.sorted()
                
            }
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }

        initialize()
    }

    func initialize() {
        
        tableView.register(CountriesListTableViewCell.self, forCellReuseIdentifier: "cell")
        
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
        return continentSections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let continent = continentSections[section]
        return continentsData[continent]?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CountriesListTableViewCell

        cell.delegate = self
        
        let continent = continentSections[indexPath.section]
        if let countries = continentsData[continent] {
            let country = countries[indexPath.row]
            let imageUrl = URL(string: country.flags.png)!
            let isExpanded = expandedCards.contains(country.name.common)
            cell.setData(imageURL: imageUrl, country: country, isExpanded: isExpanded)
        }

        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let continent = continentSections[section]
        return continent.uppercased()
    }
}

extension CountriesListViewController: CountriesListTableViewCellDelegate {
    func buttonTapped(_ cell: UITableViewCell) {
        if let indexPath = tableView.indexPath(for: cell) {
            let continent = continentSections[indexPath.section]
            if let countries = continentsData[continent] {
                let country = countries[indexPath.row]
                let countryName = country.name.common
                if expandedCards.contains(countryName) {
                    expandedCards.remove(countryName)
                } else {
                    expandedCards.insert(countryName)
                }
                tableView.reloadRows(at: [indexPath], with: .automatic)
            }
        }
    }
}
