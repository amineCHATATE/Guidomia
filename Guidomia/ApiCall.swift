//
//  ApiCall.swift
//  Guidomia
//
//  Created by Amine CHATATE on 30/3/2023.
//

import Foundation


struct ApiCall {
    
    //*****************************************************************
    // Load local JSON Data
    //*****************************************************************
    
    static func getDataFromFileWithSuccess(completion: @escaping(_ cars: [CarModel]) -> Void) {
        guard let filePathURL = Bundle.main.url(forResource: "car_list", withExtension: "json") else {
            print("The local JSON file could not be found")
            completion([CarModel]())
            return
        }
        
        do {
            let data = try Data(contentsOf: filePathURL, options: .uncached)
            let cars = try JSONDecoder().decode([CarModel].self, from: data)
            completion(cars)
        } catch {
            fatalError()
        }
    }
}
