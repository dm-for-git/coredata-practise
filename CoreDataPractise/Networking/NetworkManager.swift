//
//  NetworkManager.swift
//  CoreDataPractise
//
//  Created by DavidMartin on 1/16/20.
//  Copyright © 2020 Ultimate Weapon Corporation. All rights reserved.
//

import Foundation

class NetworkManager {
    
    static let sharedInstance = NetworkManager()
    
    
    func executePost(using url: String) {
        
    }
    
    func executeGet(using link: String, and params: [String: String], completedHandler: @escaping(Data) -> Void) {
        DispatchQueue(label: "executeGet").async {[weak self] in
            let session = URLSession.shared
            guard let url = URL(string: link + (self?.getQueryString(fromDictionary: params) ?? "")) else { return }
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            _ = session.dataTask(with: request, completionHandler: {(data, response, error) in
                if error != nil {
                    print(error.debugDescription)
                } else {
                    completedHandler(data ?? Data())
                }
            }).resume()
        }
    }
    
    func downloadData(using link: String) {
        
    }
    
    func uploadData(using link: String) {
        
    }
    
    private func getQueryString(fromDictionary parameters: [String: String]) -> String {
        var urlVars: [String] = []
        for (key, value) in parameters {
            if let encodedValue = value.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) {
                urlVars.append(key + "=" + encodedValue)
            }
        }
        return urlVars.isEmpty ? "" : "?" + urlVars.joined(separator: "&")
    }
    
    
}



enum AirVisual: String {
    case countries = "countries"
    case states = "states"
    case cities = "cities"
    case nearestCity = "nearest_city"
    case specificCity = "city"
}
