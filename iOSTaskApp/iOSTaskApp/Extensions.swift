//
//  Extensions.swift
//  iOSTaskApp
//
//  Created by Lukas Chymcak on 08/11/2024.
//

import Foundation
import SwiftUI
extension Color {
    init(hex: String) {
        var cleanHexCode = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        cleanHexCode = cleanHexCode.replacingOccurrences(of: "#", with: "")
        print(cleanHexCode)
        var rgb: UInt64 = 0
        
        Scanner(string: cleanHexCode).scanHexInt64(&rgb)
        
        let redValue = Double((rgb >> 16) & 0xFF) / 255.0
        let greenValue = Double((rgb >> 8) & 0xFF) / 255.0
        let blueValue = Double(rgb & 0xFF) / 255.0
        self.init(red: redValue, green: greenValue, blue: blueValue)
    }
}
extension Date {
    func isBeforeToday() -> Bool {
        let calendar = Calendar.current
        let now = Date()
        
        if let daysDifference = calendar.dateComponents([.day], from: self, to: now).day {
            return daysDifference > 0
        }
        
        return false
    }

    func isToday() -> Bool {
        return Calendar.current.isDate(self, inSameDayAs: Date.now)
    }
    func isTmrw() -> Bool {
        return Calendar.current.isDateInTomorrow(self)
    }
}