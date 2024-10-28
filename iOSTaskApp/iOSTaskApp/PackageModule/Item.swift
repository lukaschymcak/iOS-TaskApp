//
//  Item.swift
//  iOSTaskApp
//
//  Created by Lukas Chymcak on 10/10/2024.
//

import Foundation
import SwiftData

@Model
final class Item {
    private(set) var name:String
    private(set) var isChecked:Bool
   private var bag:Bags?
    
    init(name: String, isChecked: Bool) {
        self.name = name
        self.isChecked = isChecked
    }
    
    func toggleChecked() {
        isChecked.toggle()
    }
    
    var marker:String  {
        switch isChecked {
            case true:
            return "checkmark"
        case false:
            return "square"
        
        }
    }
    func setName(a:String){
        self.name = name
    }
}

struct MockItems{
   static let mockItemA = Item(name: "Mock Item", isChecked: false)
   static let mockItemB = Item(name: "Mock ItemB", isChecked: false)
    
   static let mockItems: [Item] = [mockItemA, mockItemB]
}
