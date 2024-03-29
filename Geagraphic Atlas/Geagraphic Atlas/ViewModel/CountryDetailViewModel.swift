//
//  CountryDetailViewModel.swift
//  Geagraphic Atlas
//
//  Created by Adil Gumarov on 17.05.2023.
//

import Foundation
import UIKit

protocol CountryDetailViewModelDelegate: AnyObject {
    func fetchingEnd()
}

class CountryDetailViewModel {
    
    weak var delegate: CountryDetailViewModelDelegate?
    
    var data: CountryDetailModel?
    let sections = ["Region:", "Capital:", "Capital coordinates:", "Population:", "Area:", "Currency", "Timezones"]
    var value = [String]()
    
    
    func getURLImage() -> String {
        return data?.flags.png ?? "Fail"
    }
    
    func getRegion() -> String {
        return data?.subregion ?? "Fail"
    }
    
    func getSectionArray() -> [String] {
        return sections
    }
    
    func getSection(index: Int) -> String {
        return sections[index]
    }
    
    func getCountofSection() -> Int {
        return sections.count
    }
    
    func prepareData() {
        
        var capital = ""
        if let temp = data?.capital {
            if temp.count > 1 {
                for i in temp {
                    capital.append(i)
                    capital.append("\n")
                }
            } else {
                capital.append(temp[0])
            }
        }
        
        var capitalCoordinates = ""
        if let temp = data?.capitalInfo?.latlng {
            capitalCoordinates = "\(temp[0]), \(temp[1])"
        }
        
        var currency = ""
        if let dict = data?.currencies {
            var counter = dict.count
           
            for (key, value) in dict {
                if counter > 1 {
                    currency.append(String(format: "%@ (%@) (%@)", value.name, value.symbol, key))
                    currency.append("\n")
                    counter -= 1
                } else {
                    currency.append(String(format: "%@ (%@) (%@)", value.name, value.symbol, key))
                }
            }
        }

        
        var timezone = ""
        if let temp = data?.timezones {
            for i in temp {
                timezone.append(i)
                timezone.append("\n")
            }
        }
        
        value.append("\(data?.subregion ?? "")")
        value.append("\(capital)")
        value.append("\(capitalCoordinates)")
        value.append("\(data?.population ?? 0)")
        value.append("\(data?.area ?? 0) km2")
        value.append("\(currency)")
        value.append("\(timezone)")
        
        print(value)
        
    }
    
    func getValue(index: Int) -> String {
        return value[index]
    }
    
    func fetchingData(URL url: String, completion: @escaping ([CountryDetailModel]) -> Void) {
        if let url = URL(string: url) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { data, response, error in
                if data != nil && error == nil {
                    do {
                        let decoder = JSONDecoder()
                        let parsingData = try decoder.decode([CountryDetailModel].self, from: data!)
                        completion(parsingData)
                    } catch {
                        print(error)
                    }
                }
            }
            task.resume()
        }
    }
    
    func getDataFromApi(code: String) {
        let URLString = Constant.urlStringApiAlpha+code
        fetchingData(URL: URLString) { [weak self] data in
            self?.data = data[0]
            self?.delegate?.fetchingEnd()
            self?.prepareData()
        }
    }
    
    
    
}
