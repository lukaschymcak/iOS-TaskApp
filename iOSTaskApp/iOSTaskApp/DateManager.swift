//
//  DateManager.swift
//  iOSTaskApp
//
//  Created by Lukas Chymcak on 29/11/2024.
//

import Foundation
@MainActor
class DateManager: ObservableObject {
    static let shared = DateManager()
    private init() {}
    

    @Published var currentDate: Date = Date()
    
    
    func updateDate() {
        currentDate = Date()
        print("Refreshed date \(currentDate)")

    }
    func fetchDate() -> Date {
        print("Fetched date \(currentDate)")
        return currentDate
     
    }
}
