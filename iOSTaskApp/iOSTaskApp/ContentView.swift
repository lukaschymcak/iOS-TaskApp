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
            Image("AppLogo")
                .resizable()
                .frame(width: 170, height: 170)
                .padding(.top, 50)
                .padding(.bottom, 50)
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

            Spacer()

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
    @AppStorage("showOnboarding") var showOnboarding: Bool = true
    @State var currentStep = 0
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.dismiss) var dismiss
    @State var isAddModuleOpen: Bool = false
    @EnvironmentObject var packingVM: PackingModuleViewModel
    @EnvironmentObject var dateManager: DateManager
    @State var navStack : [String] = []

    var body: some View {

        ZStack {
            VStack {
                NavigationStack {
                    
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
                
                .sheet(isPresented: $isAddModuleOpen) {
                    
                    AddModuleView(isAddModuleOpen: $isAddModuleOpen)
                    
                }
            }
            if showOnboarding {
                OnboardingView(showOnboarding: $showOnboarding,currentStep: $currentStep)
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

struct OnboardingView:View {
    @Binding var showOnboarding: Bool
    @Binding var currentStep: Int
    @State var showButton = false
    @State var showButton2 = false
    @State var showTextSub = false
    @State var showTextSub2 = false
    var body: some View {
        GeometryReader { GeometryProxy in
            
            
            ZStack {
                Color.black.opacity(0.6)
                    .ignoresSafeArea()
                VStack{
                    if currentStep == 0 {
                        Text("Welcome to TaskApp")
                            .font(.title)
                            .foregroundStyle(.white)
                            .fontWeight(.bold)
                            .padding(.bottom, 10)
                        if showTextSub{
                            Text("Let me guide you through the Home Screen")
                                .foregroundStyle(.white)
                                .fontWeight(.bold)
                                .padding(.bottom, 10)
                        }
                        if showButton{
                            Button {
                                currentStep += 1
                            } label: {
                                Image(systemName: "arrow.right.circle")
                                    .font(.largeTitle)
                                    .foregroundStyle(.white)
                            }
                            
                        }
                    } else if currentStep == 1 {
                        VStack {
                            HStack {
                                VStack(alignment:.leading){
                                    RoundedRectangle(cornerRadius: 20)
                                        .fill(.white.opacity(0.3))
                                        .frame(width: 40, height: 40)
                                        .padding(.bottom,10)
                                    Text("Tap this button to enter settings")
                                        .foregroundStyle(.white)
                                        .fontWeight(.bold)
                                        .font(.title)
                                    
                                }.frame(maxWidth: .infinity, alignment: .leading)
                                    .frame(width: GeometryProxy.size.width - 50)
                                
                                
                                Spacer()
                            }.padding(.horizontal,10)
                                .padding(.top,3)
                            Spacer()
                            
                            Button {
                                currentStep += 1
                            } label: {
                                Image(systemName: "arrow.right.circle")
                                    .font(.system(size: 50))
                                    .foregroundStyle(.white)
                            }
                            Spacer()
                        }
             
                            
                                
                        
                        

                        
                    } else if currentStep == 2 {
                        VStack {
                            HStack {
                                VStack(alignment:.trailing){
                                    RoundedRectangle(cornerRadius: 20)
                                        .fill(.white.opacity(0.3))
                                        .frame(width: 40, height: 40)
                                        .padding(.bottom,10)
                                    Text("Tap this button to add a module")
                                        .foregroundStyle(.white)
                                        .fontWeight(.bold)
                                        .font(.title)
                                    
                                }.frame(maxWidth: .infinity, alignment: .trailing)
                                    .frame(width: GeometryProxy.size.width - 18)
                                
                                
                            
                            }.padding(.horizontal,10)
                                .padding(.top,3)
                            Spacer()
                            
                            Button {
                                currentStep += 1
                            } label: {
                                Image(systemName: "arrow.right.circle")
                                    .font(.system(size: 50))
                                    .foregroundStyle(.white)
                            }
                            Spacer()
                        }
                        
                    } else if currentStep == 3 {
                        VStack {
                            VStack{
                                
                                RoundedRectangle(cornerRadius: 20)
                                    .fill(.white.opacity(0.3))
                                    .frame(width: GeometryProxy.size.width - 25, height: 130)
                                RoundedRectangle(cornerRadius: 20)
                                    .fill(.white.opacity(0.3))
                                    .frame(width: GeometryProxy.size.width - 25, height: 130)
                                RoundedRectangle(cornerRadius: 20)
                                    .fill(.white.opacity(0.3))
                                    .frame(width: GeometryProxy.size.width - 25, height: 130)
                                Text("And here you will see all your modules")
                                    .font(.title)
                                    .fontWeight(.bold)
                                    .foregroundStyle(.white)
                          
                            }.padding(.top,80)
                            Spacer()
                            
                            Button {
                                currentStep += 1
                            } label: {
                                Image(systemName: "arrow.right.circle")
                                    .font(.system(size: 50))
                                    .foregroundStyle(.white)
                            }
                            Spacer()
                            
                        }
                        
                    } else {
                        
                        VStack(spacing: 20){
                            if showTextSub2 {
                                Text("You are ready to go!")
                                    .font(.largeTitle)
                                    .foregroundStyle(.white)
                                    .fontWeight(.bold)
                            }
                            if showButton2 {
                                Button{
                                    showOnboarding = false
                                } label: {
                              
                                   
                                        Image(systemName: "arrow.right.circle")
                                            .font(.system(size: 50))
                                            .foregroundStyle(.white)
                                        
                                    
                                }
                            }
                        }.onAppear {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                withAnimation{
                                    showTextSub2.toggle()
                                }
                            }
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                withAnimation{
                                    showButton2.toggle()
                                }
                            }
                        }
                            
                    }
                    
                }.onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        withAnimation{
                            showTextSub.toggle()
                        }
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        withAnimation{
                            showButton.toggle()
                        }
                    }
                    
                }
            }
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
