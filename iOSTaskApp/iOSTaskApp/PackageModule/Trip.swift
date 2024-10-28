//
//  Trip.swift
//  iOSTaskApp
//
//  Created by Lukas Chymcak on 18/10/2024.
//

import Foundation
import SwiftData

@Model
class Trip{
    var id = UUID()
    private var module: PackingModuleDataClass?
    private(set)var name: String
    private(set)var dateFrom: Date
    private(set)var dateTo: Date
    @Relationship(deleteRule: .cascade)
    private(set)var bags = [Bags]()
    var allItems:Int {
        var allItems:Int = 0
        for bag in bags {
            allItems = allItems + bag.numberOfItems
        }
        return allItems
    }
    
    var allCheckedItems:Int {
        var packedItems:Int = 0
        for bag in bags {
            packedItems = packedItems + bag.packedItems
        }
        return packedItems
    }
    
    var percentage: Int {
        if allCheckedItems == 0 || allItems == 0 {
            return 0
        } else if  allCheckedItems == allItems  {
            
            return 100
        }
        else{
            return Int((Double(allCheckedItems) / Double(allItems)) * 100)
            
        }
    }

    init(id: UUID = UUID(), name: String, dateFrom: Date, dateTo: Date , module: PackingModuleDataClass? = nil) {
        self.id = id
        self.name = name
        self.dateFrom = dateFrom
        self.dateTo = dateTo
        self.module = module
       
    }
    
    func dayDifference() -> Int{
        return Calendar.current.dateComponents([.day], from: Date.now, to: dateTo).day! + 1
    }
    func validBag(name:String) -> Bool{
        name.isEmpty || bags.contains(where: { $0.name == name }) ? false : true
    }
    
    func alertMessage(name:String) -> String{
        name.isEmpty ? "Please enter a bag name" : bags.contains(where: { $0.name == name }) ? "Bag name already exists" : ""
    }
    
    func setName(a:String){
        self.name = a
    }
    func setDateFrom(a:Date){
        self.dateFrom = a
    }
    func setDateTo(a:Date){
        self.dateTo = a
    }
    func addBags(a:Bags){
        self.bags.append(a)
    }
    func removeBags(a:Bags){
        if let index = self.bags.firstIndex(of: a){
            self.bags.remove(at: index)
        }
    }
   
    
   
}

struct MockData {
    static let tripData = Trip(name: "Kosice", dateFrom: Date.now, dateTo: Date.now)
    
    static let tripsMocked = [tripData,tripData,tripData]
                              }
