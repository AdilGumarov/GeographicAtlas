//
//  CountryDetailViewController.swift
//  Geagraphic Atlas
//
//  Created by Adil Gumarov on 17.05.2023.
//

import Foundation
import UIKit

class CountryDetailViewController: UIViewController {
    
    let tableView = UITableView()
    var viewModel = CountryDetailViewModel()
    
    var cca2Code: String = ""
    
    let headerView = HeaderView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 200))
    
    init(_ code: String) {
        super.init(nibName: nil, bundle: nil)
        self.cca2Code = code
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        
        viewModel.delegate = self
        
        viewModel.getDataFromApi(code: cca2Code)
    }
    
    func initialize() {
        
//        view.addSubview(self.flagImageView)
//        flagImageView.snp.makeConstraints { make in
//            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).inset(16)
//            make.left.right.equalToSuperview().inset(16)
//            make.height.equalTo(200)
//        }
        
        tableView.register(CountryDetailTableViewCell.self, forCellReuseIdentifier: Constant.cellDetailIdentifier)
        
        tableView.dataSource = self
        
        headerView.setImageURL(url: viewModel.getURLImage())
        
        tableView.separatorStyle = .none
        tableView.tableHeaderView = headerView
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
//            make.equalTo(flagImageView.snp.bottom).offset(12)
            make.top.left.right.bottom.equalToSuperview()
        }
    }
}

extension CountryDetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.getCountofSection()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constant.cellDetailIdentifier, for: indexPath) as! CountryDetailTableViewCell
        
        let section = viewModel.getSection(index:  indexPath.row)
        let value = viewModel.getValue(index: indexPath.row)
//        let value = viewModel.prepareData()
        
        cell.setData(section: section, name: value)
        
        return cell
    }
}

extension CountryDetailViewController: CountryDetailViewModelDelegate {
    func fetchingEnd() {
        DispatchQueue.main.async {
            self.initialize()
        }
    }
}


