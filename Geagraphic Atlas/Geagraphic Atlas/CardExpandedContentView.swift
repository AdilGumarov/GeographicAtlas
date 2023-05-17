//
//  CardExpandedContentView.swift
//  Geagraphic Atlas
//
//  Created by Adil Gumarov on 17.05.2023.
//

import Foundation
import UIKit

protocol CardExpandedContentViewDelegate: AnyObject {
    func learnMoreButtonTapped()
}

class CardExpandedContentView: UIView {

    weak var delegate: CardExpandedContentViewDelegate?
    
    let stackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.distribution = .fill
        sv.spacing = 12
        return sv
    }()
    
    let infoStackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.distribution = .fill
        sv.spacing = 8
        return sv
    }()
    
    let populationLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = .systemGray
        return label
    }()
    
    let areaLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = .systemGray
        return label
    }()
    
    let currenciesLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = .systemGray
        return label
    }()
    
    lazy var learnMoreButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17)
        button.setTitle("Learn more", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.addTarget(self, action: #selector(learnMoreButtonTapped), for: .touchUpInside)
        return button
    }()
     
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func learnMoreButtonTapped() {
        delegate?.learnMoreButtonTapped()
    }
    
    func initialize() {
        addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview().inset(12)
            make.bottom.equalToSuperview()
        }
    
        stackView.addArrangedSubview(infoStackView)
        infoStackView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
        }
        
        infoStackView.addArrangedSubview(populationLabel)
        infoStackView.addArrangedSubview(areaLabel)
        infoStackView.addArrangedSubview(currenciesLabel)
        
        stackView.addArrangedSubview(learnMoreButton)
        learnMoreButton.snp.makeConstraints { make in
            make.height.equalTo(40)
        }
        
    }
    
}
