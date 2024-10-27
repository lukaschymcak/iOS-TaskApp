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
    @Relationship(deleteRule: .cascade)
    var items = [Item]()
    var isCollapsed:Bool
    var numberOfItems: Int {
        items.count
    }
    var packedItems:Int {
        items.filter { item in
            item.isChecked
        }.count
    }
    
    var percent: Int {
        (packedItems / numberOfItems) * 100
    }
    var trip: Trip?
    init(name: String, items: [Item] = [],isCollapsed: Bool = true,trip: Trip? = nil) {
        self.name = name
        self.items = items
        self.isCollapsed = isCollapsed
        self.trip = trip

    }

    
}

struct MockBags {
    static let bagA = Bags(name: "Bag A", items: [])
   static let bagB = Bags(name: "Bag B", items: [])
    
   static let bags = [bagA, bagB]
}
