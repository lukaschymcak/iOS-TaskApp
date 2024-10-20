//
//  Trip.swift
//  iOSTaskApp
//
//  Created by Lukas Chymcak on 18/10/2024.
//

import Foundation


struct Trip{
    let name: String
    let dateFrom: Date
    let dateTo: Date
    let bags:[Bags]
}

struct MockData {
    static let tripData = Trip(name: "Kosice", dateFrom: Date.now, dateTo: Date.now, bags: [Bags(name: "taska", description: "Taska Veci", items: ["lampa","nabijacka","mobil"]),Bags(name: "taska", description: "Taska Veci", items: ["lampa","nabijacka","mobil"])])
    
    static let tripsMocked = [tripData,tripData,tripData]
                              }
