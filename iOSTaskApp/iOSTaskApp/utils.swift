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
}

