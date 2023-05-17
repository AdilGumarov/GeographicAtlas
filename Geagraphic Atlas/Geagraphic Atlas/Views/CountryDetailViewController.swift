//
//  CountryDetailViewController.swift
//  Geagraphic Atlas
//
//  Created by Adil Gumarov on 17.05.2023.
//

import Foundation
import UIKit

class CountryDetailViewController: UIViewController {
    
    var cca2Code: String = ""
    
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
        
    }
}

