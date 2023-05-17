//
//  CountryDetailModel.swift
//  Geagraphic Atlas
//
//  Created by Adil Gumarov on 17.05.2023.
//

import Foundation

struct CountryDetailModel: Codable {
    let flags: Flags
    let subregion: String
    let name: Name
    let capital: [String]?
    let capitalInfo: CapitalInfo
    let population: Int
    let area: Int
    let currencies: [String: Currency]?
    let timezones: [String]
}

struct Currency: Codable {
       let name: String
       let symbol: String
}

struct Flags: Codable {
    let png: String
}

struct Name: Codable {
    let common: String
}

struct CapitalInfo: Codable {
    let latlng: [Double]
}
