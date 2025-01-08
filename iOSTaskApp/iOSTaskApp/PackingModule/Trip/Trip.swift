//
//  Trip.swift
//  iOSTaskApp
//
//  Created by Lukas Chymcak on 18/10/2024.
//

import Foundation
import SwiftData
import SwiftUI
@Model
class Trip{
    @Attribute(.unique) var Id: UUID = UUID()
    private(set) var module: PackingModuleDataClass?
    private(set)var name: String
    private(set)var dateFrom: Date
    private(set)var dateTo: Date
    @Relationship(deleteRule: .cascade)
    private(set)var bags = [Bags]()
    private(set)var notified: Bool = false
    var allItems:Int {
        var allItems:Int = 0
        for bag in bags {
            allItems = allItems + bag.numberOfItems
        }
        return allItems
    }
    var dayDifference:Int {
        let currentDay = Calendar.current.dateComponents([.day], from: Date())
        let tripDay = Calendar.current.dateComponents([.day], from: self.dateFrom)
        return Calendar.current.dateComponents([.day], from: currentDay, to: tripDay).day!
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

    init(name: String, dateFrom: Date, dateTo: Date , module: PackingModuleDataClass? = nil) {
        self.name = name
        self.dateFrom = dateFrom
        self.dateTo = dateTo
        self.module = module
       
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
   
    func wasNotified(){
        self.notified = true
    }
    func wasNotNotified(){
        self.notified = false
    }
    
  
    
   
}

struct MockData {
    static let tripData = Trip(name: "Kosice", dateFrom: Date.now, dateTo: Date.now)
    
    static let tripsMocked = [tripData,tripData,tripData]
                              }
