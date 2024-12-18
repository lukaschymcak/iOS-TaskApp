//
//  SettingsView.swift
//  iOSTaskApp
//
//  Created by Lukas Chymcak on 27/11/2024.
//

import SwiftUI

struct SettingsView: View {
    @State var editingName:Bool = false
    @State private var newUserName = ""
    @Environment(\.dismiss) var dismiss
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.modelContext) var context
    @AppStorage("packingNotif")  var isNotificationForPackingOn = false
    @AppStorage("plantsNotif")  var isNotificationForPlantsOn = false
    var body: some View {
  
        NavigationStack {
           
                
            Form{
                Section {
                    HStack{
                        Button {
                            editingName.toggle()
                            
                        } label: {
                            HStack {
                                Image(systemName: "person")
                                Text("Edit Name")
                            }
                      
                        }.alert("Enter new name", isPresented: $editingName) {
                            TextField("Enter your name", text: $newUserName)
                            Button("OK") {
                                UserDefaults.standard.set(newUserName, forKey: "userName")
                            }
                        }

                    }
                } header: {
                    Text("User Settings")
                        .fontWeight(.bold)
                        .font(.subheadline)
                        
                }
        
                    Section {
                        HStack{
                            
                            Image(systemName: "app.badge")
                            
                            Toggle("Enable Notifications", isOn: $isNotificationForPackingOn)
                                .onChange(of: isNotificationForPackingOn) { _, newValue in
                                    if !newValue{
                                        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: ["TripNotification"])
                                    }
                                }
                           

                            
                               
                            
                        }
                        HStack{
                            Button {
                                context.delete(PackingModuleDataClass(name: "Packing"))
                                context.insert(PackingModuleDataClass(name: "Packing"))
                            } label: {
                               Text("Reset Packing Module (TESTING)")
                            }
                        }
                    } header: {
                        Text("Packing Module Settings")
                            .fontWeight(.bold)
                            .font(.subheadline)
                        
                    }
                Section {
                    HStack{
                        
                        Image(systemName: "app.badge")
                        
                        Toggle("Enable Notifications", isOn: $isNotificationForPlantsOn)
                         
                    }
                    HStack{
                        Button {
                            context.delete(PlantsModuleDataClass())
                            context.insert(PlantsModuleDataClass())
                        } label: {
                           Text("Reset Plants Module (TESTING)")
                        }
                    }
                } header: {
                    Text("Plants Module Settings")
                        .fontWeight(.bold)
                        .font(.subheadline)
                    
                }
                
            }
            
        }
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
     dismiss()
                    } label: {
                        Image(systemName: "chevron.backward")
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundStyle(Utils.textColor(colorScheme))
                        
                    }
                }
                ToolbarItem(placement: .principal) {
                    Text("Settings")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundStyle(Utils.textColor(colorScheme))
                        
                }
                        
            }
    }
}

#Preview {
    SettingsView()

}
