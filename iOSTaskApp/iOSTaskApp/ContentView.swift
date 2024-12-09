//
//  ContentView.swift
//  iOSTaskApp
//
//  Created by Lukas Chymcak on 10/10/2024.
//

import SwiftData
import SwiftUI
import UserNotifications

struct ContentView: View {
    @AppStorage("isWelcomeScreenOver") var isWelcomeScreenOver = false 
    @State var checkWelcomeScreen: Bool = true
    @EnvironmentObject var dateManager: DateManager
    @EnvironmentObject var packingVM: PackingModuleViewModel
   
    var body: some View {
        ZStack {
            VStack {
                if isWelcomeScreenOver {
                    HomeView()
                        .transition(.opacity)
                        .environmentObject(dateManager)
                        .environmentObject(packingVM)

                } else {
                    WelcomeView()
                        .transition(.move(edge: .bottom))
                    
                }
            }.animation(.easeInOut, value: isWelcomeScreenOver)
        }.onAppear(){
            UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
                if success {
                    print("Permission approved!")
                } else if let error = error {
                    print(error.localizedDescription)
                }
            }
         
            
        }
    }

}
struct WelcomeView: View {
    @State var isWelcomeSreenOver: Bool = false
    @State var name: String = ""
    @Environment(\.colorScheme) var colorScheme
    @FocusState private var nameIsFocused: Bool


    var body: some View {

        VStack(alignment: .center, spacing: 0) {
            Image(colorScheme == .dark ? "WelcomeLogoLight" : "WelcomeLogoDark")
                .resizable()
             
                .frame(width: 250, height: 250)
                .padding(.top, 20)
            Text("Welcome,")
                .font(.system(size: 60))
                .fontWeight(.heavy)
                .padding(5)

            TextField("Enter your name", text: $name)
                .focused($nameIsFocused)
                .multilineTextAlignment(.center)
                .font(.largeTitle)
                .frame(width: 280, height: 80)
                .background(
                    Color.gray.opacity(colorScheme == .dark ? 0.3 : 0.7)
                )
                .clipShape(.rect(cornerRadius: 10))
                .autocorrectionDisabled()

                .padding(.bottom,30)

            Button {
                UserDefaults.standard.set(name, forKey: "userName")
                UserDefaults.standard.set(true, forKey: "isWelcomeScreenOver")
            } label: {
                Image(systemName: "arrow.down.circle")
                    .renderingMode(.original)
                    .resizable()
                    .frame(width: 120, height: 120)
                    .foregroundStyle(
                        Color(colorScheme == .dark ? .white : .black))

            }
            .transition(.slide)
            Spacer()

        }.onTapGesture {
            nameIsFocused = false
        }
        .ignoresSafeArea(.keyboard)
    }

}

struct HomeView: View {
    @AppStorage("isWelcomeScreenOver") var isWelcomeScreenOver: Bool = false
    @State var currentStep = 0
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.dismiss) var dismiss
    @State var isAddModuleOpen: Bool = false
    @EnvironmentObject var packingVM: PackingModuleViewModel
    @EnvironmentObject var dateManager: DateManager


    var body: some View {

            VStack {
              
         
                    NavigationStack {
                        ZStack {
                     
                            VStack() {
                                CustomNavBar(
                                    isWelcomeScreenOver: $isWelcomeScreenOver,
                                    isAddModuleOpen: $isAddModuleOpen
                                ).environmentObject(packingVM)
                                
                                
                                
                                
                                
                                
                                
                                ScrollView {
                                    PackageModuleHomeView()
                                        .environmentObject(dateManager)
                                        .environmentObject(packingVM)
                               
                                    
                                    
                                    
                                    
                                    
                                    
                                    PlantsModuleHomeView()
                                    
                                    
                                }
                            }
                    }
                    
                    .sheet(isPresented: $isAddModuleOpen) {
                        
                        AddModuleView(isAddModuleOpen: $isAddModuleOpen)
                        
                    }
                    
                }
            }
      
     

    }
 
}

struct AddModuleView: View {
    @Environment(\.modelContext) var context
    @Environment(\.colorScheme) var colorScheme
    @Binding var isAddModuleOpen: Bool
    @State var isAddingModuleOpen: Bool = false
    @Query var availableModules: [CreatingModuleData]

    var body: some View {
        NavigationStack {

            VStack(alignment: .center) {

                HStack {
                    Button {
                        isAddModuleOpen.toggle()
                    } label: {
                        Image(systemName: "chevron.up")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundStyle(Utils.textColor(colorScheme))
                    }.padding(.bottom, 20)

                    Button {
                        for modules in availableModules {
                            context.delete(modules)
                        }
                        for newModules in DefaultModules.defaults {
                            context.insert(newModules)
                        }
                    } label: {
                        Image(systemName: "arrow.clockwise")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundStyle(Utils.textColor(colorScheme))
                    }.padding(.bottom, 20)
                }.frame(maxWidth: .infinity, alignment: .center)

                Text("Choose a Module")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundStyle(Utils.textColor(colorScheme))
                    .padding(.bottom, 20)

      

                    ModuleListView(isAddingModuleOpen: $isAddingModuleOpen)
             

            }

            .padding(.top, 20)

            Spacer()

        }

    }
}
#Preview {
    ContentView()
        .modelContainer(for: [
            Trip.self, PackingModuleDataClass.self, CreatingModuleData.self,
            PlantsModuleDataClass.self,
        ],inMemory: true)
        .environmentObject(DateManager())
        .environmentObject(PackingModuleViewModel())
}
