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
    @State var checkWelcomeScreen : Bool = false

    var body: some View {
        VStack{
            if isWelcomeScreenOver {
                HomeView()
                    .transition(.opacity)
            }
            else {
                WelcomeView()
                    .transition(.slide)
            }
        }.animation(.easeInOut,value: isWelcomeScreenOver)
    }

   
}
struct WelcomeView: View{
    @AppStorage("isWelcomeScreenOver") var isWelcomeScreenOver: Bool = false
    var body: some View{
            VStack(alignment: .center){
                Image("AppLogo")
                    .resizable()
                    .frame(width: 200, height: 200)
                    .padding(.top,100)
                    .padding(.bottom,50)
                Text("Welcome,")
                    .font(.custom("EDU", size: 40))
                    
                    
                   
                Spacer()
                Button {
                    isWelcomeScreenOver = true
                } label: {
                    Text("Close Welcome")
                }
                

            }
    }

    
}

struct HomeView: View{
    @AppStorage("isWelcomeScreenOver") var isWelcomeScreenOver: Bool = false
    var body: some View{
        VStack {
            Text("HOMEVIEW")
            Button {
                isWelcomeScreenOver = false
            } label: {
                Text("Show WElcome")
            }

        }
        
        
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
}
