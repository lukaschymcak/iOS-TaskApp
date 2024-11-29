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
    @Attribute(.unique) var Id: UUID = UUID()
    private(set)var name: String
    @Relationship(deleteRule: .cascade)
    private(set)var items = [Item]()
    private(set)var isCollapsed:Bool = true
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
    private var trip: Trip?
    init(name: String, items: [Item] = [],isCollapsed: Bool = true,trip: Trip? = nil) {
        self.name = name
        self.items = items
        self.isCollapsed = isCollapsed
        self.trip = trip

    }
    func setName(a:String){
        self.name = a
    }
    func addItem(a:Item){
        self.items.append(a)
    }
    func removeItem(a:Item){
        if let index = self.items.firstIndex(of: a) {
            self.items.remove(at: index)
        }
    }
    func toggleCollapsed(){
        isCollapsed.toggle()
    }
    func getTrip() -> Trip? {
        return trip
    }
   
    
}

struct MockBags {
    static let bagA = Bags(name: "Bag A", items: [Item(name: "geg", isChecked: false),Item(name: "geg", isChecked: false)])
   static let bagB = Bags(name: "Bag B", items: [])
    
   static let bags = [bagA, bagB]
}
