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
    
    lazy var flagImageView: UIImageView = {
        let image = UIImageView()
        image.kf.setImage(with: URL(string: viewModel.getURLImage()))
        image.contentMode = .scaleToFill
        image.layer.cornerRadius = 8.0
        image.clipsToBounds = true
        return image
    }()
    
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
        
        view.addSubview(self.flagImageView)
        flagImageView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).inset(16)
            make.left.right.equalToSuperview().inset(16)
            make.height.equalTo(200)
        }
        
        tableView.register(CountryDetailTableViewCell.self, forCellReuseIdentifier: Constant.cellDetailIdentifier)
        
        tableView.dataSource = self
        
        tableView.separatorStyle = .none
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.equalTo(flagImageView.snp.bottom).offset(12)
            make.left.right.bottom.equalToSuperview()
        }
    }
}

extension CountryDetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.getCountofSection()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constant.cellDetailIdentifier, for: indexPath) as! CountryDetailTableViewCell
        
        let section = viewModel.getSection(index: indexPath.row)
        let value = viewModel.prepareData()
        
        cell.setData(section: section, name: value[indexPath.row])
        
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


