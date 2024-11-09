//
//  utils.swift
//  iOSTaskApp
//
//  Created by Lukas Chymcak on 19/10/2024.
//

import Foundation
import SwiftUI


struct Utils {
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
            if let referenceDate = UserDefaults.standard.object(forKey: "reference") as? Date {
                if !Calendar.current.isDateInToday(referenceDate) {
                    UserDefaults.standard.set(Date(), forKey: "reference")
                    return true
                }
            } else {
             
                UserDefaults.standard.set(Date(), forKey: "reference")
                return true
            }
            return false
        }
}

