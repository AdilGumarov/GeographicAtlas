//
//  CountryListModel.swift
//  Geagraphic Atlas
//
//  Created by Adil Gumarov on 14.05.2023.
//

import Foundation

struct CountryListModel: Codable {
    let flags: Flags
    let name: Name
    let capital: [String]?
    let population: Int
    
    struct Flags: Codable {
        let png: String
    }

    struct Name: Codable {
        let common: String
    }
}
