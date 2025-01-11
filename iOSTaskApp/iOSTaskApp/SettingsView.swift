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
    @AppStorage("selectedLanguage") var selectedLang: String = "EN"
    @EnvironmentObject var PlantsVM: PlantsModuleViewModel
    @EnvironmentObject var packingVM: PackingModuleViewModel
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
                                    .bold()
                                    .foregroundStyle(Utils.textColor(colorScheme))
                                Text(LocalizedStringKey("edit_name"))
                                    
                            }
                      
                        }.alert(LocalizedStringKey("enter_name"), isPresented: $editingName) {
                            TextField(LocalizedStringKey("name"), text: $newUserName)
                            Button("OK") {
                                UserDefaults.standard.set(newUserName, forKey: "userName")
                            }
                        }

                    }
                    HStack{
                        Image(systemName: "person")
                            .foregroundStyle(Utils.textColor(colorScheme))
                            .bold()
                        Button {
                            UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
                        } label: {
                            Text(LocalizedStringKey("language"))

                        }

                    }.onChange(of: selectedLang) { _,_ in
                        UserDefaults.standard.set([selectedLang], forKey: "AppleLanguages")
                        UserDefaults.standard.synchronize()
                        
                    }
                    
                } header: {
                    Text(LocalizedStringKey("settings"))
                        .fontWeight(.bold)
                        .font(.subheadline)
                        
                }
        
                    Section {
                        HStack{
                            
                            Image(systemName: "app.badge")
                            
                            Toggle(LocalizedStringKey("enable_notifications"), isOn: $isNotificationForPackingOn)
                                .onChange(of: isNotificationForPackingOn) { _, newValue in
                                    if !newValue{
                                        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: ["TripNotification"])
                                    }
                                }
                           

                            
                               
                            
                        }
                        HStack{
                            Button {
                                context.delete(packingVM.selectedModule!)
                               try? context.save()
                                context.insert(PackingModuleDataClass())
                               
                            } label: {
                               Text(LocalizedStringKey("reset_packing"))
                                + Text(" (TESTING)")
                            }
                        }
                    } header: {
                        Text(LocalizedStringKey("packing_module_settings"))
                            .fontWeight(.bold)
                            .font(.subheadline)
    
                    }
                Section {
                    HStack{
                        
                        Image(systemName: "app.badge")
                        
                        Toggle(LocalizedStringKey("enable_notifications"), isOn: $isNotificationForPlantsOn)
                         
                    }
                    HStack{
                        Button {
                            context.delete(PlantsVM.selectedModule)
                            try? context.save()
                            context.insert(PlantsModuleDataClass())
                    
                   
                        } label: {
                           Text(LocalizedStringKey("reset_plants"))
                            + Text(" (TESTING)")
                        }
                    }
                } header: {
                    Text(LocalizedStringKey("plants_module_settings"))
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
                    Text(LocalizedStringKey("settings"))
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
