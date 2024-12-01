//
//  DateManager.swift
//  iOSTaskApp
//
//  Created by Lukas Chymcak on 29/11/2024.
//

import Foundation
class DateManager: ObservableObject {
    static let shared = DateManager()
    private init() {}
    

    @Published var currentDate: Date = Date()
    
    @MainActor
    func updateDate() {
        currentDate = Date()
        print("Refreshed date \(currentDate)")

    }
    @MainActor
    func fetchDate() -> Date {
        print("Fetched date \(currentDate)")
        return currentDate
     
    }
}
