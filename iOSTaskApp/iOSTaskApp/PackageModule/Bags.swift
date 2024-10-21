//
//  Bags.swift
//  iOSTaskApp
//
//  Created by Lukas Chymcak on 18/10/2024.
//

import Foundation
import SwiftData
@Model
class Bags{
    var name: String
  
    var items: [String]
    var numberOfItems: Int {
        items.count
    }
    @Relationship(.unique, deleteRule: .nullify, inverse: \Trip.bags)
    var trip: Trip?
    init(name: String, items: [String]) {
        self.name = name

        self.items = items
    }
}

struct MockBags {
    static let bagA = Bags(name: "Bag A", items: ["Item A", "Item B"])
   static let bagB = Bags(name: "Bag B", items: ["Item C", "Item D"])
    
   static let bags = [bagA, bagB]
}
