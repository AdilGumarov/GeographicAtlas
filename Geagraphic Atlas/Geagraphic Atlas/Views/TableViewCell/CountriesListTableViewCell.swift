//
//  CountriesListTableViewCell.swift
//  Geagraphic Atlas
//
//  Created by Adil Gumarov on 16.05.2023.
//

import UIKit
import Kingfisher
import SnapKit

protocol CountriesListTableViewCellDelegate: AnyObject {
    func buttonTapped(_ cell: UITableViewCell)
    func learnMoreButtonTapped(_ cell: UITableViewCell)
}

class CountriesListTableViewCell: UITableViewCell {
    
    weak var delegate: CountriesListTableViewCellDelegate?
    
    var cardView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1.0)//.lightGray //UIColor(red: 247/255, green: 248/255, blue: 249/255, alpha: 1)
        view.layer.cornerRadius = 12
        return view
    }()
    
    var stackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        return sv
    }()
    
    private let contentCardView = CardTopContentView()
    private let expandedContentCardView = CardExpandedContentView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        
        contentCardView.delegate = self
        expandedContentCardView.delegate = self
        
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        if stackView.arrangedSubviews.count > 1 {
            stackView.arrangedSubviews[1].removeFromSuperview()
        }
        
    }
    
    func initialize() {
        contentView.addSubview(cardView)
        cardView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(6)
            make.left.right.equalToSuperview().inset(12)
            make.bottom.equalToSuperview().offset(-6)
            
            
//            make.top.equalToSuperview().inset(6)
//            make.height.equalTo(84)
        }
        
        cardView.addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(12)
            make.left.right.equalToSuperview().inset(12)
            make.bottom.equalToSuperview().offset(-12)
        }

        stackView.addArrangedSubview(contentCardView)

        
//        stackView.addSubview(expandedCardView)
        
    }
    
    func setData(imageURL: URL, country: CountryListModel, isExpanded: Bool) {
        contentCardView.flagImage.kf.setImage(with: imageURL)
        contentCardView.countryLabel.text = country.name.common
        contentCardView.capitalLabel.text = country.capital?[0] ?? ""
        contentCardView.expandStateButton.setImage(UIImage(systemName: "chevron.down"), for: .normal)
        
        if isExpanded {
            contentCardView.expandStateButton.setImage(UIImage(systemName: "chevron.up"), for: .normal)
            expandedContentCardView.populationLabel.text = "Population: \(country.population)"
            expandedContentCardView.areaLabel.text = "Area: \(country.area)"
            expandedContentCardView.currenciesLabel.text = "Currencies: \(country.currencies?.keys)"
            stackView.addArrangedSubview(expandedContentCardView)
        }
    }
}

extension CountriesListTableViewCell: CardTopContentViewDelegate {
    func didTapButton() {
        delegate?.buttonTapped(self)
    }
}

extension CountriesListTableViewCell: CardExpandedContentViewDelegate {
    func learnMoreButtonTapped() {
        delegate?.learnMoreButtonTapped(self)
    }
}
