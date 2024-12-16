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
    @StateObject var plantsVM = PlantsModuleViewModel()
    private static let refreshId = "dateRefresh"
    let packingNotificationManager = PackingNotificationManager.shared
    @AppStorage("isPackingModuleCreated") var isPackingModuleCreated: Bool = false
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(for: [PackingModuleDataClass.self,Trip.self,PlantsModuleDataClass.self],inMemory: false)
                .environmentObject(dateManager)
                .environmentObject(packingVM)
                .environmentObject(plantsVM)
        }.onChange(of: scenephase) { _,phase in
            if phase == .background {
                plantsVM.selectedModule.refreshPlants()
                scheduleAppRefresh()
                if isPackingModuleCreated {
                      packingVM.checkAndAddToHistory()
                    if packingVM.selectedModule?.trips.isEmpty == true{
                        packingNotificationManager.removeTripNotificationfromCenter()
                        print("removed")
                    } else {
                        packingNotificationManager.checkAndcreatePackingNotifications(for: packingVM)
                    }
                        
                    
                }

            } else if phase == .active {
          
                plantsVM.selectedModule.refreshPlants()
                packingVM.checkAndAddToHistory()
                UNUserNotificationCenter.current().setBadgeCount(0)
                UNUserNotificationCenter.current().getPendingNotificationRequests(completionHandler: { requests in
                    print("Pending notifications: \(requests.count)")
                })
                dateManager.updateDate()
     
            }
        }.backgroundTask(.appRefresh(Self.refreshId)) {
            await scheduleAppRefresh()
            await dateManager.updateDate()
            if await isPackingModuleCreated {
               await packingVM.checkAndAddToHistory()
                if await packingVM.selectedModule?.trips.isEmpty == true{
                  await   packingNotificationManager.removeTripNotificationfromCenter()
                    print("removed")
                } else {
                   await packingNotificationManager.checkAndcreatePackingNotifications(for: packingVM)
                }
                
               await packingNotificationManager.checkAndcreatePackingNotifications(for: packingVM)

            }
            
        }
    }
    private func scheduleAppRefresh() {
        let today = Calendar.current.startOfDay(for: .now)
        let tomorrow = Calendar.current.date(byAdding: .day, value: 1, to: today)!
        BGTaskScheduler.shared.getPendingTaskRequests { request in
            print("\(request.count) BGTask pending.")
            guard request.isEmpty else { print("BGTASK ALREADY SET")
                return }
        }
        
        let request = BGAppRefreshTaskRequest(identifier: Self.refreshId)
        request.earliestBeginDate = tomorrow
        do {
            try BGTaskScheduler.shared.submit(request)
            print("Scheduled app refresh for tomorrow: \(tomorrow)")
        } catch {
            print("Could not schedule app refresh: \(error)")
        }
    }

}
