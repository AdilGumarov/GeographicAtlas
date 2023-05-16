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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        title = "World countries"
        
        viewModel.fetchingData(URL: "https://restcountries.com/v3.1/all") { [self] data in
            print(data)
            self.data = data
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }

        initialize()
    }

    func initialize() {
        
        tableView.register(CountriesListTableViewCell.self, forCellReuseIdentifier: "cell")
        
        tableView.dataSource = self

        
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
    }
    
}

extension CountriesListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        
        cell.textLabel?.text = list[indexPath.row]


        return cell
    }
    
}
