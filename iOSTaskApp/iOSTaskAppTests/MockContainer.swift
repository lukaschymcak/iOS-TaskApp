//
//  MockContainer.swift
//  iOSTaskAppTests
//
//  Created by Lukas Chymcak on 18/11/2024.
//

import Foundation
import SwiftData
@MainActor
var mockContainer:ModelContainer {
    do{
       let  container = try ModelContainer(for:PackingModuleDataClass.self,Trip.self,Bags.self,Item.self, configurations:ModelConfiguration(isStoredInMemoryOnly: true))
        return container
    } catch{
        fatalError("Failed to create container")
    }
}
