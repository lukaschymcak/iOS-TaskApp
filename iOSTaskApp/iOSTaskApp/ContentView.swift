//
//  ContentView.swift
//  iOSTaskApp
//
//  Created by Lukas Chymcak on 10/10/2024.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @AppStorage("isWelcomeScreenOver") var isWelcomeScreenOver: Bool = false
    @State var checkWelcomeScreen : Bool = true
    @State var name: String = "Lukas"
    var body: some View {
        ZStack {
            VStack{
                if isWelcomeScreenOver {
                    HomeView(name: $name)
                        .transition(.opacity)
                        
                }
                else {
                    WelcomeView(name: $name)
                        .transition(.move(edge: .bottom))
                }
            }.animation(.easeInOut,value: isWelcomeScreenOver)
        }
    }

   
}
struct WelcomeView: View{
    @AppStorage("isWelcomeScreenOver") var isWelcomeScreenOver: Bool = false
    @Binding var name:String
    @Environment(\.colorScheme) var colorScheme
    @FocusState private var nameIsFocused : Bool
    
    var body: some View{
    
        VStack(alignment: .center,spacing: 0){
                Image("AppLogo")
                    .resizable()
                    .frame(width: 170, height: 170)
                    .padding(.top,50)
                    .padding(.bottom,50)
                Text("Welcome,")
                    .font(.system(size: 60))
                    .fontWeight(.heavy)
                    .padding(5)
                
                TextField("Enter your name", text: $name )
                    .focused($nameIsFocused)
                    .multilineTextAlignment(.center)
                    .font(.largeTitle)
                    .frame(width: 280, height: 80)
                    .background(Color.gray.opacity(colorScheme == .dark ? 0.3 : 0.7))
                    .clipShape(.rect(cornerRadius: 10))
                    .autocorrectionDisabled()
                   
                   
                Spacer()
            
            
        
                Button {
                    isWelcomeScreenOver = true
                } label: {
                    Image(systemName: "arrow.down.circle")
                        .renderingMode(.original)
                        .resizable()
                        .frame(width: 120, height: 120)
                        .foregroundStyle(Color(colorScheme == .dark ? .white : .black))
                    
                        
                }
                .transition(.slide)
                Spacer()
    
         
          
         
            

                

        }.onTapGesture {
            nameIsFocused = false
        }
        .ignoresSafeArea(.keyboard)
    }

    
}

struct HomeView: View{
    @AppStorage("isWelcomeScreenOver") var isWelcomeScreenOver: Bool = false
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.dismiss) var dismiss
    @Binding var name:String
    @State var isAddModuleOpen:Bool = false

  
   
    var body: some View{
        
        GeometryReader { GeometryProxy in
            VStack(){
                    NavigationStack{
                    CustomNavBar(name: $name, isAddModuleOpen: $isAddModuleOpen)
                            .frame(width: GeometryProxy.size.width - 30)
    
                        ScrollView(){
                            PackageModuleHomeView()
                                .frame(height: 250)
                            Spacer()
                   
                      
                            
                            
                        }
                            Spacer()
                 
                }
            }
        
            .sheet(isPresented: $isAddModuleOpen) {
                
                AddModuleView(isAddModuleOpen: $isAddModuleOpen)
                   
            }
        }
       
     
        
        
        
    }
}

struct AddModuleView: View {
    @Binding var isAddModuleOpen: Bool
    @State var isAddingModuleOpen: Bool = false
    
    var body: some View {
        NavigationStack{
            
            VStack(alignment:.center){
                Button {
                    isAddModuleOpen.toggle()
                } label: {
                    Image(systemName: "chevron.up")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundStyle(.black)
                }.padding(.bottom,20)
                
                Text("Choose a Module")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundStyle(.black)
                    .padding(.bottom,20)
                
                HStack{
                    
                    ModuleListView(isAddingModuleOpen: $isAddingModuleOpen)
                    }

                
                
                
            }

      

            .padding(.top,20)
        
            Spacer()
            
            
        
        }
       
    }
}


#Preview {
        ContentView()
        .modelContainer(for:[Trip.self,PackingModuleDataClass.self,CreatingModuleData.self])
}

