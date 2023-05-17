//
//  HeaderView.swift
//  Geagraphic Atlas
//
//  Created by Adil Gumarov on 17.05.2023.
//

import Foundation
import UIKit
import SnapKit

class HeaderView: UIView {
    
    lazy var flagImageView: UIImageView = {
        let image = UIImageView()
//        image.kf.setImage(with: URL(string: viewModel.getURLImage()))
        image.contentMode = .scaleToFill
        image.layer.cornerRadius = 8.0
        image.clipsToBounds = true
        return image
    }()
    
    func setImageURL(url: String) {
        flagImageView.kf.setImage(with: URL(string: url))
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(flagImageView)
        flagImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(16)
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
