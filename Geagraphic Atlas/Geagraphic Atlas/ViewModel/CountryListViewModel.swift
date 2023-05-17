//
//  CountryListViewModel.swift
//  Geagraphic Atlas
//
//  Created by Adil Gumarov on 16.05.2023.
//

import Foundation

protocol CountryListViewModelDelegate: AnyObject {
    func fetchingEnd()
}

class CountryListViewModel {
    
    var data = [CountryListModel]()
    
    var continentsData: [String: [CountryListModel]] = [:]
    var continentSections: [String] = []
    
    var expandedCards: Set<String> = []
    
    weak var delegate: CountryListViewModelDelegate?
    
    func getNumberOfConinents() -> Int {
        return continentSections.count
    }
    
    func getNumberOfRowInSection(_ section: Int) -> Int {
        let continent = continentSections[section]
        return continentsData[continent]?.count ?? 0
    }
    
    func getCountry(from indexPath: IndexPath) -> CountryListModel? {
        let continent = continentSections[indexPath.section]
        var country: CountryListModel
        if let countries = continentsData[continent] {
            country = countries[indexPath.row]
            return country
        }
        return nil
    }
    
    func getUrlOfImage(from indexPath: IndexPath) -> URL {
        let country = getCountry(from: indexPath)
        return URL(string: country!.flags.png)!
    }
    
    func isExpanded(_ name: String) -> Bool {
        return expandedCards.contains(name)
    }
    
    func getTitleOfSection(from section: Int) -> String {
        let continent = continentSections[section]
        return continent.uppercased()
    }
    
    func isExpanded(from indexPath: IndexPath) {
        let country = getCountry(from: indexPath)!
        let countryName = country.name.common
        if isExpanded(countryName) {
            expandedCards.remove(countryName)
        } else {
            expandedCards.insert(countryName)
        }
    }
    
    func insertCountry(by countryName: String) {
        expandedCards.insert(countryName)
    }
    
    func removeCountry(by countryName: String) {
        expandedCards.remove(countryName)
    }
    
    func fetchingData(URL url: String, completion: @escaping ([CountryListModel]) -> Void) {
        if let url = URL(string: url) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { data, response, error in
                if data != nil && error == nil {
                    do {
                        let decoder = JSONDecoder()
                        let parsingData = try decoder.decode([CountryListModel].self, from: data!)
                        completion(parsingData)
                    } catch {
                        print(error)
                    }
                }
            }
            task.resume()
        }
    }
    
    func getDataFromApi() {
        let urlString = "https://restcountries.com/v3.1/all"
        fetchingData(URL: urlString) { [self] data in
            self.data = data
//            print(data)
            self.data.forEach { country in
                if let continent = country.continents.first {
                    if var continentCountries = self.continentsData[continent] {
                        continentCountries.append(country)
                        continentsData[continent] = continentCountries
                    } else {
                        continentsData[continent] = [country]
                    }
                }
                continentSections = continentsData.keys.sorted()
            }
            delegate?.fetchingEnd()
        }
    }
    
}
