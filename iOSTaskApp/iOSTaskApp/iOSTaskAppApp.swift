//
//  iOSTaskAppApp.swift
//  iOSTaskApp
//
//  Created by Lukas Chymcak on 10/10/2024.
//

import SwiftUI
import SwiftData

@main
struct iOSTaskAppApp: App {

    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(for: [PackingModuleDataClass.self,Trip.self,CreatingModuleData.self,PlantsModuleDataClass.self,ModuleManager.self])
        }
        

    }
}
