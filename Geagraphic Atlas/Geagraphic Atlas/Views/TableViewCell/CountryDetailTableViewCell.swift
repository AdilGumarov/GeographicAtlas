//
//  CountryDetailTableViewCell.swift
//  Geagraphic Atlas
//
//  Created by Adil Gumarov on 17.05.2023.
//

import Foundation
import UIKit

class CountryDetailTableViewCell: UITableViewCell {
    
    let rowView: UIView = {
        let view = UIView()
        return view
    }()

    let dotImageView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "circle.fill")
        image.tintColor = .black
        return image
    }()

    let sectionLabel: UILabel = {
        let label = UILabel()
        label.text = "Region:"
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = .systemGray
        return label
    }()

    lazy var valueLabel: UILabel = {
        let label = UILabel()
//        label.text = viewModel.getRegion()
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        label.textColor = .black
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        
        
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setData(section: String, name: String) {
        sectionLabel.text = section
        valueLabel.text = name
    }
    
    func initialize() {
        contentView.addSubview(rowView)
        rowView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(12)
            make.left.right.equalToSuperview().inset(16)
            make.bottom.equalToSuperview().inset(12)
        }
        
        rowView.addSubview(dotImageView)
        dotImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(6)
            make.left.equalToSuperview().inset(6)
            make.width.equalTo(10)
            make.height.equalTo(10)
        }

        rowView.addSubview(sectionLabel)
        sectionLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.equalTo(dotImageView.snp.right).offset(12)
        }

        rowView.addSubview(valueLabel)
        valueLabel.snp.makeConstraints { make in
            make.top.equalTo(sectionLabel.snp.bottom).offset(6)
            make.left.equalTo(dotImageView.snp.right).offset(12)
            make.bottom.equalToSuperview()
        }
    }
    
}
