//
//  utils.swift
//  iOSTaskApp
//
//  Created by Lukas Chymcak on 19/10/2024.
//

import Foundation
import SwiftUI
import BackgroundTasks


struct Utils {
    static let defaults = UserDefaults.standard
    static let defaultsKey = "lastRefreshday"
   static func textColor(_ color: ColorScheme) -> Color {
        color == .dark ? .white : .black
    }
    
    static func changeColorBasedOnDarkMode(_ color: ColorScheme, setDarkColor: Color,setLightColor:Color) ->Color {
        if(color == .dark){
            return setDarkColor
        }
        return setLightColor
    }
    static func check() -> Bool {
        guard let lastRefreshDate = UserDefaults.standard.object(forKey: defaultsKey) as? Date else {
            UserDefaults.standard.set(Date(), forKey: defaultsKey)
            return true
            
        }
        if let diff = Calendar.current.dateComponents([.day], from: lastRefreshDate, to: Date()).day, diff == 1 {
            UserDefaults.standard.set(Date(), forKey: defaultsKey)
            return true
        } else {
            return false
        }
            
        
    }
    
    static func scheduleAppRefresh() {
        let today = Calendar.current.startOfDay(for: .now)
        let tomorrow = Calendar.current.date(byAdding: .day, value: 1, to: today)!
        
        let request = BGAppRefreshTaskRequest(identifier: "dateRefresh")
        request.earliestBeginDate = .now.addingTimeInterval(1 * 60)
        do {
            try BGTaskScheduler.shared.submit(request)
            print("Scheduled app refresh for tomorrow: \(tomorrow)")
        } catch {
            print("Could not schedule app refresh: \(error)")
        }
    }
}

