//
//  Resort.swift
//  SnowSeeker
//
//  Created by Alpay Calalli on 29.11.22.
//

import Foundation

struct Resort: Codable, Identifiable {
    let id: String
    var name: String
    let country: String
    let description: String
    let imageCredit: String
    let price: Int
    let size: Int
    let snowDepth: Int
    let elevation: Int
    let runs: Int
    let facilities: [String]
    
    var facilityTypes: [Facility] {
        facilities.map(Facility.init)
    }
    
    static let allResorts: [Resort] = Bundle.main.decode("resorts.json")
    static let example = allResorts[0]
}
