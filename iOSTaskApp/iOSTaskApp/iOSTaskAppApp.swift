//
//  iOSTaskAppApp.swift
//  iOSTaskApp
//
//  Created by Lukas Chymcak on 10/10/2024.
//

import SwiftUI
import SwiftData
import BackgroundTasks
@main
struct iOSTaskAppApp: App {
    @StateObject var dateManager = DateManager.shared
    @Environment(\.scenePhase) var scenephase
    @StateObject var packingVM =  PackingModuleViewModel()
    private static let refreshId = "dateRefresh"
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(for: [PackingModuleDataClass.self,Trip.self,CreatingModuleData.self,PlantsModuleDataClass.self])
                .environmentObject(dateManager)
                .environmentObject(packingVM)
        }.onChange(of: scenephase) { _,phase in
            if phase == .background {
                scheduleAppRefresh()
                print("bacground")
            } else if phase == .active {
                dateManager.updateDate()
            }
        }.backgroundTask(.appRefresh(Self.refreshId)) {
            await scheduleAppRefresh()
            await dateManager.updateDate()
            await print(packingVM.selectedModule.earliestTrip.dateFrom)
            await print(packingVM.selectedModule.dayDifference)
            
            
        }
    }
    private func scheduleAppRefresh() {
        let today = Calendar.current.startOfDay(for: .now)
        let tomorrow = Calendar.current.date(byAdding: .day, value: 1, to: today)!
        BGTaskScheduler.shared.getPendingTaskRequests { request in
            print("\(request.count) BGTask pending.")
            guard request.isEmpty else { return }
        }
        
        let request = BGAppRefreshTaskRequest(identifier: Self.refreshId)
        request.earliestBeginDate = .now.addingTimeInterval(1 * 60)
        do {
            try BGTaskScheduler.shared.submit(request)
            print("Scheduled app refresh for tomorrow: \(tomorrow)")
        } catch {
            print("Could not schedule app refresh: \(error)")
        }
    }
 
    private func sampleNotification() {
        let content = UNMutableNotificationContent()
        content.title = "Hello"
        content.subtitle = "Hello"
        content.sound = UNNotificationSound.default
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 10, repeats: false)
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request)
    }
}
