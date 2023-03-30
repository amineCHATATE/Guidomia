//
//  CarModel.swift
//  Guidomia
//
//  Created by Amine CHATATE on 30/3/2023.
//

import Foundation

struct CarModel: Equatable, Decodable {
    let consList: [String]
    let customerPrice: Int
    let make: String
    let marketPrice: Int
    let model: String
    let prosList: [String]
    let rating: Double
}
