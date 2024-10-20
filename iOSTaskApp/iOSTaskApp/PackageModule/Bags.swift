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
    var desc: String
    var items: [String]
    var numberOfItems: Int {
        items.count
    }
    @Relationship(.unique, deleteRule: .nullify, inverse: \Trip.bags)
    var trip: Trip?
    init(name: String, desc: String, items: [String]) {
        self.name = name
        self.desc = desc
        self.items = items
    }
}
