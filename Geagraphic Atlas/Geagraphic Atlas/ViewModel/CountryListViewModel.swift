//
//  CountryListViewModel.swift
//  Geagraphic Atlas
//
//  Created by Adil Gumarov on 16.05.2023.
//

import Foundation

class CountryListViewModel {
    
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
    
}
