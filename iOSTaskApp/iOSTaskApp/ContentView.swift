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
    @AppStorage("ModulesLoaded") var modulesLoaded: Bool = false
   
    @Environment(\.modelContext) var context

   
    var body: some View {
        NavigationStack {
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
                print(modulesLoaded.description)
            
                if modulesLoaded == false {
                    context.delete(PackingModuleDataClass())
                    context.insert(PackingModuleDataClass())
                    context.delete(PlantsModuleDataClass())
                    context.insert(PlantsModuleDataClass())
                    modulesLoaded = true
                }
                
                
            }
        }
    }

}
struct WelcomeView: View {
    @State var name: String = ""
    @Environment(\.colorScheme) var colorScheme
    @FocusState private var nameIsFocused: Bool


    var body: some View {

        VStack(alignment: .center, spacing: 0) {
            Image(colorScheme == .dark ? "WelcomeLogoLight" : "WelcomeLogoDark")
                .resizable()
             
                .frame(width: 250, height: 250)
                .padding(.top, 20)
            Text(LocalizedStringKey("welcome"))
                .font(.system(size: 60))
                .fontWeight(.heavy)
                .padding(5)

            TextField(LocalizedStringKey("enter_name"), text: $name)
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
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var packingVM: PackingModuleViewModel
    @EnvironmentObject var plantsVM: PlantsModuleViewModel
    @EnvironmentObject var dateManager: DateManager
    @AppStorage("userName") var name:String = ""
    @State var viewArrra : [AnyView] = [AnyView(PackageModuleHomeView()), AnyView(PlantsModuleHomeView()),AnyView(RecipeModuleView()),AnyView(ShoppingModuleView())]
  


    var body: some View {

        VStack {
            
            
            NavigationStack {
                GeometryReader { geometry in
                    ZStack {
                        VStack() {
                            ScrollView {
                                ForEach(viewArrra.indices, id: \.self) { index in
                                    VStack(spacing:10){
                                        
                                        viewArrra[index]
                                            .environmentObject(packingVM)
                                            .environmentObject(plantsVM)
                                            .environmentObject(DateManager())
                                        
                                    }
                                    
                                    
                                }.frame(width: max(geometry.size.width - 20,0))
                                    .frame(maxWidth: .infinity, alignment: .center)
                                
                                  
    
    
                            } .frame(height: max(geometry.size.height - 15,0),alignment: .top)
                        }.padding(.top, 20)
                           
                    }
                    
                    
                }.toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        NavigationLink {
                            SettingsView()
                            
                            
                            
                        } label: {
                            Image(systemName: "slider.vertical.3")
                                .font(.title)
                                .foregroundStyle(Utils.textColor(colorScheme))
                                .fontWeight(.bold)
                        }
                    }
                    ToolbarItem(placement: .principal) {
                        
                        Text(LocalizedStringKey("hello"))
                            .font(.title)
                            .foregroundStyle(Utils.textColor(colorScheme))
                            .fontWeight(.bold)
                        
                        +   Text(", \(name == "" ? "User" : name)")
                            .font(.title)
                            .foregroundStyle(Utils.textColor(colorScheme))
                            .fontWeight(.bold)
                        
                        
                        
                        
                    }
                    
                    ToolbarItem(placement: .topBarTrailing) {
                        
                    }
                }.toolbarTitleDisplayMode(.inline)

            }
            
        }

    }
 
}

#Preview {
    ContentView()
        .modelContainer(for: [
            Trip.self, PackingModuleDataClass.self,
            PlantsModuleDataClass.self,
        ],inMemory: true)
        .environmentObject(DateManager())
        .environmentObject(PackingModuleViewModel())
        .environmentObject(PlantsModuleViewModel())
}
