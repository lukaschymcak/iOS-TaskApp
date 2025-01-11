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
        
        let today = calendar.startOfDay(for: now)
        let selfDay = calendar.startOfDay(for: self)
        
        if let daysDifference =  calendar.dateComponents([.day], from: selfDay, to: today).day {
            print(daysDifference)
            print(now)
            print(self)
            return daysDifference > 0
        }
        print(now)
        print(self)
         
        return false
    }

    func isToday() -> Bool {
        return Calendar.current.isDate(self, inSameDayAs: Date.now)
    }
    func isTmrw() -> Bool {
        return Calendar.current.isDateInTomorrow(self)
    }
}

extension UINavigationController: UIGestureRecognizerDelegate {
    override open func viewDidLoad() {
           super.viewDidLoad()
           interactivePopGestureRecognizer?.delegate = nil
       }
}
