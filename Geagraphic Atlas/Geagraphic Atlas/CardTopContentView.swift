//
//  CardTopContentView.swift
//  Geagraphic Atlas
//
//  Created by Adil Gumarov on 17.05.2023.
//

import Foundation
import UIKit

protocol CardTopContentViewDelegate: AnyObject {
    func didTapButton()
}

class CardTopContentView: UIView {
    
    var flagImage: UIImageView = {
        let image = UIImageView()
        image.backgroundColor = .red
        image.contentMode = .scaleToFill
        image.layer.cornerRadius = 8.0
        image.clipsToBounds = true
        return image
    }()
    
    var countryLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont.boldSystemFont(ofSize: 17)
        return label
    }()
    
    let capitalLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 13)
        label.textColor = .systemGray
        return label
    }()
    
    lazy var expandStateButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "chevron.down"), for: .normal)
        button.tintColor = .black
        button.addTarget(self, action: #selector(expandButtonTapped), for: .touchUpInside)
        return button
    }()
    
    weak var delegate: CardTopContentViewDelegate?
    
    @objc func expandButtonTapped() {
        delegate?.didTapButton()
    }
    
    func setExpandedState(_ state: Bool) {
        if state {
            expandStateButton.setImage(UIImage(systemName: "chevron.up"), for: .normal)
        } else {
            expandStateButton.setImage(UIImage(systemName: "chevron.up"), for: .normal)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initialize() {
        addSubview(flagImage)
        flagImage.snp.makeConstraints { make in
            make.left.top.equalToSuperview()//.inset(6)
            make.height.equalTo(48)
            make.width.equalTo(82)
            make.bottom.equalToSuperview()
        }

        addSubview(expandStateButton)
        expandStateButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(12)
            make.size.equalTo(24)
            make.centerY.equalToSuperview()
        }

        addSubview(countryLabel)
        countryLabel.snp.makeConstraints { make in
            make.left.equalTo(flagImage.snp.right).offset(12)
            make.right.equalTo(expandStateButton.snp.left).inset(4)
            make.top.equalToSuperview().inset(4)
        }

        addSubview(capitalLabel)
        capitalLabel.snp.makeConstraints { make in
            make.left.equalTo(flagImage.snp.right).offset(12)
            make.right.equalTo(expandStateButton.snp.left).inset(4)
            make.top.equalTo(countryLabel.snp.bottom).offset(4)
        }
    }
}
